package com.example.labnative.data.local.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Entity
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import com.example.labnative.data.local.entity.ListingEntity
import kotlinx.coroutines.flow.Flow

@Dao
interface ListingDao {
    @Query("SELECT * FROM ListingEntity")
    fun getAllListings(): Flow<List<ListingEntity>>

    @Query("SELECT * FROM ListingEntity WHERE id = :id")
    suspend fun getListingById(id: Int): ListingEntity?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertListing(listingEntity: ListingEntity)

    @Query("DELETE FROM ListingEntity WHERE id = :id")
    suspend fun deleteListing(id: Int)

    @Update
    suspend fun updateListing(listingEntity: ListingEntity)
}