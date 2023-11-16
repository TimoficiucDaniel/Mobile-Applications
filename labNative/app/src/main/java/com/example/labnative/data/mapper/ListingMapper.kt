package com.example.labnative.data.mapper

import com.example.labnative.data.local.entity.ListingEntity
import com.example.labnative.domain.model.Listing

fun ListingEntity.asExternalModel(): Listing = Listing(
    id,title,cost,description,seller
)

fun Listing.toEntity(): ListingEntity = ListingEntity(
    id,title,cost,description,seller
)
