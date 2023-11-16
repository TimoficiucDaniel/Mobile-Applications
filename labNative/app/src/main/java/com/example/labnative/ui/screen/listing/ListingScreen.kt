package com.example.labnative.ui.screen.listing

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.ArrowBack
import androidx.compose.material.icons.rounded.Delete
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import java.lang.NumberFormatException

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ListingScreen(
    state: ListingState,
    onEvent: (ListingEvent) -> Unit
){
    var showDialog by remember { mutableStateOf(false) }
    var message by remember { mutableStateOf("empty") }
    var type by remember { mutableStateOf("empty") }
    if(showDialog){
        Dialog(
            dismissCallback = { showDialog = false },
            message = message,
            type = type
            )
    }
    var delete by remember { mutableStateOf(false) }
    if(delete){
        DeleteDialog(
            onDismissRequest = { delete = false },
            onConfirmation = { onEvent(ListingEvent.DeleteListing) }
        )
    }
    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(
                title = { /*TODO*/ },
                navigationIcon = {
                    IconButton(onClick = {
                        onEvent(ListingEvent.NavigateBack)
                    }) {
                        Icon(
                            imageVector = Icons.Rounded.ArrowBack,
                            contentDescription = "navigate back"
                        )
                    }
                },
                actions ={
                    IconButton(onClick = {
                            delete=true
                    }) {
                        Icon(
                            imageVector = Icons.Rounded.Delete,
                            contentDescription = "delete")
                    }
                } )
        }
    ) { padding ->
        Column (
            modifier = Modifier
                .fillMaxSize()
                .background(Color(254, 255, 186, 255))
                .padding(padding)
                .padding(
                    horizontal = 20.dp,
                    vertical = 15.dp
                ),
            verticalArrangement = Arrangement.spacedBy(10.dp)
        ){
            OutlinedTextField(
                value = state.title,
                onValueChange = {
                        onEvent(ListingEvent.TitleChange(it))
                },
                placeholder = {
                    Text(text = "title")
                }
            )
            OutlinedTextField(
                value = state.cost.toString(),
                onValueChange = {
                    try {
                        if(it == ""){
                            onEvent(ListingEvent.CostChange(0))
                        }else {
                            onEvent(ListingEvent.CostChange(it.toInt()))
                        }
                    }catch (e: NumberFormatException){
                        showDialog = true
                        message = "Cost cannot be non-numeric"
                        type = "Error"
                    }

                },
                placeholder = {
                    Text(text = "cost")
                }
            )
            OutlinedTextField(
                value = state.description,
                onValueChange = {
                        onEvent(ListingEvent.DescriptionChange(it))
                },
                placeholder = {
                    Text(text = "description")
                }
            )
            OutlinedTextField(
                value = state.seller,
                onValueChange = {
                    onEvent(ListingEvent.SellerChange(it))
                },
                placeholder = {
                    Text(text = "seller")
                }
            )
            Box(
                modifier = Modifier.fillMaxWidth(),
                contentAlignment = Alignment.Center
            ){
                Button(onClick = {
                    if((state.title == "") || state.description == "")
                    {
                        showDialog = true
                        message = "Cannot have empty fields"
                        type = "Error"
                    }
                    else {
                        onEvent(ListingEvent.Save)
                    }
                },
                    modifier = Modifier
                        .fillMaxWidth(0.5f)
                ){
                    Text(text = "Save")
                }
            }
        }
    }
}

@Composable
fun Dialog(
    dismissCallback: () -> Unit,
    message: String,
    type: String
){
    AlertDialog(
        onDismissRequest = dismissCallback,
        title = { Text(type) },
        text = { Text(message) },
        confirmButton = {
            TextButton(onClick = dismissCallback) {
                Text("OK")
            }
        }
    )
}

@Composable
fun DeleteDialog(
    onDismissRequest: () -> Unit,
    onConfirmation: () -> Unit,
) {
    AlertDialog(
        title = {
            Text(text = "Confirm")
        },
        text = {
            Text(text = "Are you sure you want to delete this item?")
        },
        onDismissRequest = {
            onDismissRequest()
        },
        confirmButton = {
            TextButton(
                onClick = {
                    onConfirmation()
                }
            ) {
                Text("Confirm")
            }
        },
        dismissButton = {
            TextButton(
                onClick = {
                    onDismissRequest()
                }
            ) {
                Text("Dismiss")
            }
        }
    )
}