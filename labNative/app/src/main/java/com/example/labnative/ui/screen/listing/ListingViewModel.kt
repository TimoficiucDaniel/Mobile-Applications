package com.example.labnative.ui.screen.listing

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.labnative.domain.model.Listing
import com.example.labnative.domain.repository.ListingRepository
import com.example.labnative.ui.util.UiEvent
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.receiveAsFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class ListingViewModel @Inject constructor(
    private val repository: ListingRepository,
    private val savedStateHandle: SavedStateHandle
) : ViewModel(){
    private val _state = MutableStateFlow(ListingState())
    val state = _state.asStateFlow()

    private val _event = Channel<UiEvent>()
    val event = _event.receiveAsFlow()

    private fun sendEvent(event: UiEvent){
        viewModelScope.launch {
            _event.send(event)
        }
    }

    init{
        savedStateHandle.get<String>("id")?.let {
          val id = it.toInt()
            viewModelScope.launch {
                repository.getListingById(id)?.let {listing ->
                    _state.update {screenState ->
                        screenState.copy(
                            title = listing.title,
                            id = listing.id,
                            cost = listing.cost,
                            description = listing.description,
                            seller = listing.seller
                        )
                    }
                }
            }
        }
    }

    fun onEvent(event: ListingEvent){
        when(event){
            is ListingEvent.CostChange -> {
                _state.update {
                    it.copy(
                        cost = event.value
                    )
                }
            }
            is ListingEvent.DescriptionChange -> {
                _state.update {
                    it.copy(
                        description = event.value
                    )
                }
            }
            is ListingEvent.SellerChange -> {
                _state.update {
                    it.copy(
                        seller = event.value
                    )
                }
            }
            ListingEvent.NavigateBack -> sendEvent(UiEvent.NavigateBack)
            ListingEvent.Save -> {
                viewModelScope.launch {
                    val state = state.value
                    val listing = Listing(
                        id = state.id,
                        title = state.title,
                        cost = state.cost,
                        description = state.description,
                        seller = state.seller
                    )
                    if (state.id == null) {
                        repository.insertListing(listing)
                    }
                    else{
                        repository.updateListing(listing)
                    }
                    sendEvent(UiEvent.NavigateBack)
                }
            }
            is ListingEvent.TitleChange -> {
                _state.update {
                    it.copy(
                        title = event.value
                    )
                }
            }

            ListingEvent.DeleteListing -> {
                viewModelScope.launch {
                    val state = state.value
                    val listing = Listing(
                        id = state.id,
                        title = state.title,
                        cost = state.cost,
                        description = state.description,
                        seller = state.seller
                    )
                    repository.deleteListing(listing)
                }
                sendEvent(UiEvent.NavigateBack)
            }
        }
    }

}