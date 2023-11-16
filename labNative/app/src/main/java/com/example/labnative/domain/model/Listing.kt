package com.example.labnative.domain.model

data class Listing (
    val id: Int? = null,
    val title: String = "",
    val cost: Int = 0,
    val description: String = "",
    val seller: String = ""
)