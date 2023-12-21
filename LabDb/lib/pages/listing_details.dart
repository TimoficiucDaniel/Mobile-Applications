import 'package:flutter/material.dart';
import 'package:flutterui/repositories/listing_repository.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

class ListingDetails extends StatelessWidget {
  ListingDetails({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int;
    final listing = Provider.of<ListingRepository>(context).readDataById(id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
              ),
              Text(
                "Back",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
        leadingWidth: 100,
        bottom: PreferredSize(
          preferredSize: const Size(
            double.infinity,
            100,
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Hero(
              tag: 'title',
              child: Text(
                'Detail',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 2 * defaultPadding),
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: kPrimaryColor,
                        width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child:ListTile(
                leading: Container(
                  height: double.infinity,
                  child: Hero(tag: id, child: const Icon(Icons.title)),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: listing.title!,
                        child: Text(
                          listing.title!,
                          style: Theme.of(context).textTheme.titleMedium!,
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: kPrimaryColor,
                        width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child:ListTile(
                leading: Container(
                  height: double.infinity,
                  child: const Icon(Icons.monetization_on_outlined),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: listing.cost!,
                        child: Text(listing.cost.toString(), style: Theme.of(context).textTheme.titleSmall!),
                      ),
                    ),
                  ],
                ),
              ),
              ),
              const SizedBox(height: defaultPadding),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: kPrimaryColor,
                        width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child:ListTile(
                leading: Container(
                  height: double.infinity,
                  child: const Icon(Icons.description_outlined),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: listing.description!,
                        child: Text(listing.description!, style: Theme.of(context).textTheme.titleSmall!),
                      ),
                    ),
                  ],
                ),
              ),
              ),
              const SizedBox(height: 2 * defaultPadding),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: kPrimaryColor,
                        width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child:ListTile(
                leading: Container(
                  height: double.infinity,
                  child: const Icon(Icons.person),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: listing.seller!,
                        child: Text(listing.seller!, style: Theme.of(context).textTheme.titleSmall!),
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

