package com.example.labnative.ui.screen.listing_list

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.labnative.domain.repository.ListingRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.stateIn
import javax.inject.Inject

@HiltViewModel
class ListingListViewModel @Inject constructor(
    private val repository: ListingRepository
): ViewModel() {
    val listingList = repository.getAllListings()
        .stateIn(
            scope = viewModelScope,
            started = SharingStarted.WhileSubscribed(5000),
            initialValue = emptyList()
        )
}