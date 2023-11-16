package com.example.labnative

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.labnative.ui.screen.listing.ListingScreen
import com.example.labnative.ui.screen.listing.ListingViewModel
import com.example.labnative.ui.screen.listing_list.ListingListScreen
import com.example.labnative.ui.screen.listing_list.ListingListViewModel
import com.example.labnative.ui.theme.LabNativeTheme
import com.example.labnative.ui.util.Route
import com.example.labnative.ui.util.UiEvent
import dagger.hilt.android.AndroidEntryPoint


@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
                LabNativeTheme {
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(Color(254, 255, 186, 255))

                    )
                    {
                        val navController = rememberNavController()
                        NavHost(
                            navController = navController,
                            startDestination = Route.listingList
                        ) {
                            composable(route = Route.listingList) {
                                val viewModel = hiltViewModel<ListingListViewModel>()
                                val listingList by viewModel.listingList.collectAsStateWithLifecycle()

                                ListingListScreen(
                                    listingList = listingList,
                                    onListingClick = {
                                        navController.navigate(
                                            Route.listing.replace(
                                                "{id}",
                                                it.id.toString()
                                            )
                                        )
                                    },
                                    onAddListingClick = {
                                        navController.navigate(Route.listing)
                                    }
                                )
                            }

                            composable(route = Route.listing) {
                                val viewModel = hiltViewModel<ListingViewModel>()
                                val state by viewModel.state.collectAsStateWithLifecycle()

                                LaunchedEffect(key1 = true) {
                                    viewModel.event.collect { event ->
                                        when (event) {
                                            is UiEvent.NavigateBack -> {
                                                navController.popBackStack()
                                            }

                                            else -> Unit
                                        }
                                    }
                                }
                                ListingScreen(
                                    state = state,
                                    onEvent = viewModel::onEvent
                                )
                            }
                        }
                    }
            }
        }
    }
}

