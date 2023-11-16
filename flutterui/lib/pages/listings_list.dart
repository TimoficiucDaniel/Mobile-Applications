import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/listing_controller.dart';
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
      body: GetBuilder(
        init: ListingListController(),
        builder: (controller) => ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: 2 * defaultPadding,
          ),
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            Listing listing = controller.users[index];
            return InkWell(
              onTap: () => Get.to(
                () => ListingDetails(listing: listing),
                transition: Transition.rightToLeftWithFade,
              ),
              child: Container(
                padding: const EdgeInsets.all(defaultPadding),
                margin: const EdgeInsets.only(bottom: defaultPadding * .3),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
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
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
                          ),
                          const SizedBox(height: defaultPadding - 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(
                                    () => UpdateListing(listing: listing),
                                    transition: Transition.rightToLeftWithFade,
                                  );
                                },
                                child: const Text('Edit'),
                              ),
                              const SizedBox(width: defaultPadding - 10),
                              TextButton(
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: const Text('Delete'),
                                      content: const Text('Do you want to delete this listing ?'),
                                      actions: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Theme.of(context).primaryColor,
                                            foregroundColor: Colors.white,
                                            side: BorderSide(color: Theme.of(context).primaryColor),
                                          ),
                                          onPressed: () => Get.back(),
                                          child: const Text('Cancel'),
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Theme.of(context).primaryColor,
                                            foregroundColor: Colors.white,
                                            side: BorderSide(color: Theme.of(context).primaryColor),
                                          ),
                                          onPressed: () async {
                                            Get.put(HandleListingController());
                                            await Get.find<HandleListingController>().deleteListing(listing.id!);
                                            Get.back();
                                            await controller.getAllListings();
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
        onPressed: () {
          Get.to(
            () => NewListing(),
            transition: Transition.rightToLeftWithFade,
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
