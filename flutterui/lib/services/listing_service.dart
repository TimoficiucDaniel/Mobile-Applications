import '../model/listing.dart';
import '../repositories/listing_repository.dart';

class ListingService {
  late ListingRepository _repository;

  ListingService() {
    _repository = ListingRepository();
  }

  //Save User
  Future<int> createListing(Listing listing) async {
    return (await _repository.insertData(listing.toMap()))!;
  }

  //Read All Users
  Future<List<Listing>> readListings() async {
    var data = await _repository.readData();
    return data!.map((e) => Listing.fromMap(e)).toList();
  }

  //Edit User
  Future<int> updateListing(Listing listing) async {
    return (await _repository.updateData(listing.toMap()))!;
  }

  Future<int> deleteListing(int id) async {
    return (await _repository.deleteDataById(id))!;
  }
}
