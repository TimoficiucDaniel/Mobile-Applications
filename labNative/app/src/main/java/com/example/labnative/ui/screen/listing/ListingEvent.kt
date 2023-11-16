package com.example.labnative.ui.screen.listing

sealed interface ListingEvent {
    data class TitleChange(val value:String): ListingEvent
    data class CostChange(val value:Int): ListingEvent
    data class DescriptionChange(val value:String): ListingEvent
    data class SellerChange(val value:String): ListingEvent
    object Save: ListingEvent
    object NavigateBack: ListingEvent
    object DeleteListing : ListingEvent
}