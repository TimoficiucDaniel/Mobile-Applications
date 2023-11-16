package com.example.labnative.domain.repository

import com.example.labnative.domain.model.Listing
import kotlinx.coroutines.flow.Flow

interface ListingRepository {
    fun getAllListings(): Flow<List<Listing>>

    suspend fun getListingById(id: Int): Listing?

    suspend fun insertListing(listing: Listing)

    suspend fun deleteListing(listing: Listing)

    suspend fun updateListing(listing: Listing)
}