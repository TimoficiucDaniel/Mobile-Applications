import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../db/db_helper.dart';
import '../model/listing.dart';

class ListingRepository extends ChangeNotifier{
  final List<Listing> listings = [];
  final SQLHelper dbHelper = SQLHelper.instance;

  ListingRepository() {
    init();
  }

  UnmodifiableListView<Listing> get getListings => UnmodifiableListView(listings);

  Future<void> init() async{
    await dbHelper.db();
    final List<Listing> listingsTemp = await dbHelper.getListings();
    listings.addAll(listingsTemp);
    notifyListeners();
  }

  Future<void> insertData(Listing listing) async {
      final int id = await dbHelper.createListing(listing);
      final Listing listingTemp = listing.copyWith(id : id);
      listings.add(listingTemp);
      notifyListeners();
  }

  Listing readDataById(int id)  {
    final index = listings.indexWhere((element) => element.id == id);
    return listings[index];
  }

  Future<void> updateData(Listing listing) async {
    await dbHelper.updateListing(listing);
    final index = listings.indexWhere((element) => element.id == listing.id);
    if(index != -1)
      {
        listings[index] = listing;
        notifyListeners();
      }
  }

  Future<void> deleteDataById(int id) async {
    await dbHelper.deleteListing(id);
    final index = listings.indexWhere((element) => element.id == id);
    listings.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
