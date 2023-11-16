package com.example.labnative.data.local

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.labnative.data.local.dao.ListingDao
import com.example.labnative.data.local.entity.ListingEntity

@Database(version = 1, entities = [ListingEntity::class])
abstract class ListingDatabase : RoomDatabase(){
    abstract val dao: ListingDao

    companion object{
        const val name = "listind_db"
    }
}