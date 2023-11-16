import 'package:get/get.dart';

import '../model/listing.dart';
import '../services/listing_service.dart';

class ListingListController extends GetxController {
  ListingListController() {
    _listingService = ListingService();
  }

  List<Listing> users = [];

  late ListingService _listingService;

  @override
  void onInit() async {
    super.onInit();
    await getAllListings();
  }

  Future<void> getAllListings() async {
    users = await _listingService.readListings();
    update();
  }
}

class HandleListingController extends GetxController {
  final ListingService _listingService = ListingService();

  Future<void> createListing(Listing listing) async {
    await Future.delayed(const Duration(seconds: 2));
    await _listingService.createListing(listing);
    update();
  }

  Future<void> updateListing(Listing listing) async {
    await Future.delayed(const Duration(seconds: 2));
    await _listingService.updateListing(listing);
    update();
  }

  Future<void> deleteListing(int id) async {
    await _listingService.deleteListing(id!);
    update();
  }
}
