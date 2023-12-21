import 'package:flutter/material.dart';
import 'package:flutterui/repositories/listing_repository.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/listing.dart';
import 'new_listing.dart';
import 'update_listing.dart';
import 'listing_details.dart';

class ListingsList extends StatelessWidget {
  const ListingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size(
            double.infinity,
            40,
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            child: Hero(
              tag: 'title',
              child: Text(
                'Listables',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<ListingRepository>(
        builder: (context,repository,child) {
          final logger = Logger();
          try {
            final listings = repository.getListings;
            return ListView.builder(
              itemCount: listings.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: 2 * defaultPadding,
              ),
              itemBuilder: (context, index) {
                Listing listing = listings[index];
                return InkWell(
                  onTap: () =>
                     Navigator.pushNamed(context,'/details',
                       arguments: listing.id
                      ),
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    margin: const EdgeInsets.only(bottom: defaultPadding * .3),
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(defaultPadding),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Hero(
                                tag: listing.id!,
                                child: const Icon(
                                  Icons.account_tree_outlined,
                                  size: 50,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: listing.title!,
                                child: Text(
                                  "${listing.title}",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: defaultPadding - 10),
                              Hero(
                                tag: listing.cost!,
                                child: Text(
                                  "${listing.cost}",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: defaultPadding - 6),
                              Hero(
                                tag: listing.seller!,
                                child: Text(
                                  "${listing.seller}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleSmall!,
                                ),
                              ),
                              const SizedBox(height: defaultPadding - 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,'/update',
                                      arguments: listing.id);
                                    },
                                    child: const Text('Edit'),
                                  ),
                                  const SizedBox(width: defaultPadding - 10),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context)
                                      { return AlertDialog(
                                          title: const Text('Delete'),
                                          content: const Text(
                                              'Do you want to delete this listing ?'),
                                          actions: [
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: Theme
                                                    .of(context)
                                                    .primaryColor,
                                                foregroundColor: Colors.white,
                                                side: BorderSide(color: Theme
                                                    .of(context)
                                                    .primaryColor),
                                              ),
                                              onPressed: () => Navigator.of(context).pop(),
                                              child: const Text('Cancel'),
                                            ),
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: Theme
                                                    .of(context)
                                                    .primaryColor,
                                                foregroundColor: Colors.white,
                                                side: BorderSide(color: Theme
                                                    .of(context)
                                                    .primaryColor),
                                              ),
                                              onPressed: () async {
                                                try {
                                                  Provider.of<
                                                      ListingRepository>(
                                                      context, listen: false)
                                                      .deleteDataById(listing
                                                      .id!);
                                                  Navigator.of(context).pop();
                                                }catch(error){
                                                  logger.e("Exception: $error");
                                                  _showSnackBar(context, 'Error deleting listing: $error');
                                                }
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        );
                                      }
                                      );
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } catch(error) {
              logger.e('Exception: $error');
              _showSnackBar(context, 'Error reading listings: $error');
              return const SizedBox();
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
