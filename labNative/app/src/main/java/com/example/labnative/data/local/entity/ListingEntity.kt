package com.example.labnative.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class ListingEntity (
    @PrimaryKey val id: Int?,
    val title: String,
    val cost: Int,
    val description: String,
    val seller: String
)