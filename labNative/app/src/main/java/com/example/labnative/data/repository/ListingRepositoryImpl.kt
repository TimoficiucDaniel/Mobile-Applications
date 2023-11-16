package com.example.labnative.data.repository

import com.example.labnative.data.local.dao.ListingDao
import com.example.labnative.data.mapper.asExternalModel
import com.example.labnative.data.mapper.toEntity
import com.example.labnative.domain.model.Listing
import com.example.labnative.domain.repository.ListingRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

class ListingRepositoryImpl(
    private val dao: ListingDao)
    : ListingRepository{
    override fun getAllListings(): Flow<List<Listing>> {
       return dao.getAllListings()
            .map { listings ->
                listings.map {
                    it.asExternalModel()
                }
            }
    }

    override suspend fun getListingById(id: Int): Listing? {
        return dao.getListingById(id)?.asExternalModel()
    }

    override suspend fun insertListing(listing: Listing) {
        dao.insertListing(listing.toEntity())
    }

    override suspend fun deleteListing(listing: Listing) {
        listing.toEntity().id?.let { dao.deleteListing(it) }
    }

    override suspend fun updateListing(listing: Listing) {
        dao.updateListing(listing.toEntity())
    }
}