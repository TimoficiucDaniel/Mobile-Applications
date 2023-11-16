package com.example.labnative.data.di

import android.content.Context
import androidx.room.Room
import com.example.labnative.data.local.ListingDatabase
import com.example.labnative.data.repository.ListingRepositoryImpl
import com.example.labnative.domain.repository.ListingRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton


@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Provides
    @Singleton
    fun provideListingDatabase(@ApplicationContext context: Context ): ListingDatabase =
        Room.databaseBuilder(
            context,
            ListingDatabase::class.java,
            ListingDatabase.name
        ).build()

    @Provides
    @Singleton
    fun provideListingRepository(database: ListingDatabase): ListingRepository =
        ListingRepositoryImpl(dao = database.dao)
}