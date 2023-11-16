package com.example.labnative.ui.screen.listing_list

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.example.labnative.domain.model.Listing

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ListingListScreen(
    listingList: List<Listing>,
    onListingClick: (Listing) -> Unit,
    onAddListingClick: () -> Unit
) {
     Scaffold(
         floatingActionButton = {
             FloatingActionButton(onClick =
                 onAddListingClick
             ) {
                 Icon(
                     imageVector = Icons.Rounded.Add,
                     contentDescription = "add listing"
                 )
             }
         },
         topBar = {
             TopAppBar(
                 title = {
                 Text(
                     text = "Listables",
                     style = MaterialTheme.typography.titleLarge,
                     textAlign = TextAlign.Right
                 )
             })
         }
     ) { padding ->
         LazyColumn(
             contentPadding = PaddingValues(
                 start = 20.dp,
                 end = 20.dp,
                 top = 15.dp + padding.calculateTopPadding(),
                 bottom = 15.dp + padding.calculateBottomPadding()
             )
         ){
            items(listingList){ listing ->
                ListItem(
                    headlineText = {
                    Text(
                        text = listing.title,
                        style = MaterialTheme.typography.titleMedium
                    )
                },
                    supportingText = {
                        Text(
                            text = listing.description,
                            maxLines = 2,
                            overflow = TextOverflow.Ellipsis
                        )
                        Text(
                            text = listing.cost.toString()
                        )
                        Text(
                            text = listing.seller
                        )
                    },
                    modifier = Modifier
                        .background(Color(241, 88, 88, 255))
                        .clickable(onClick = {
                            onListingClick(listing)

                        }
                        )
                )
            }
         }
     }
}
