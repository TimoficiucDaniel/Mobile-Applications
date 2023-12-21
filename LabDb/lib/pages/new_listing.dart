import 'package:flutter/material.dart';
import 'package:flutterui/repositories/listing_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import '../model/listing.dart';

class NewListing extends StatelessWidget {
  NewListing({super.key});

  final _formKey = GlobalKey<FormState>();
  final _unfocusNode = FocusNode();

  final _titleController = TextEditingController();
  final _costController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sellerController = TextEditingController();

  RxBool loading = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
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
              child: const Text(
                'Create new listing',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
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
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Container(
                      height: double.infinity,
                      child: const Icon(Icons.title),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            obscureText: false,
                            controller: _titleController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) return "The title is required";
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Title',
                              hintText: 'title...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  ListTile(
                    leading: Container(
                      height: double.infinity,
                      child: const Icon(Icons.monetization_on_outlined),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            obscureText: false,
                            controller: _costController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) return "The cost is required";
                              if (int.tryParse(value) == null) return "The cost has to be numeric";
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Cost',
                              hintText: 'cost...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  ListTile(
                    leading: Container(
                      height: double.infinity,
                      child: const Icon(Icons.description_outlined),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            obscureText: false,
                            controller: _descriptionController,
                            style: const TextStyle(fontSize: 18),
                            minLines: 5,
                            maxLength: 250,
                            maxLines: 8,
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value!.length > 250) return "The description is too long";
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Description',
                              hintText: 'description...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  ListTile(
                    leading: Container(
                      height: double.infinity,
                      child: const Icon(Icons.person),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            obscureText: false,
                            controller: _sellerController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) return "The seller is required";
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Seller',
                              hintText: 'seller...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2 * defaultPadding),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Listing listing = Listing(
                            title: _titleController.text,
                            cost: int.tryParse(_costController.text),
                            description: _descriptionController.text,
                            seller: _sellerController.text,
                          );
                          _titleController.text = '';
                          _costController.text = '0';
                          _descriptionController.text = '';
                          _sellerController.text = '';
                          try {
                            Provider.of<ListingRepository>(
                                context, listen: false).insertData(listing);
                          } catch(error){
                            final logger = Logger();
                            logger.e('Exception: $error');
                            _showSnackBar(context, 'Error adding listing: $error');
                          }
                         Navigator.pop(context);
                        }
                      },
                      icon: Obx(() {
                        return !loading.value
                            ? const Icon(
                                Icons.save_rounded,
                                size: 20,
                              )
                            : const SizedBox.shrink();
                      }),
                      label: Obx(() {
                        return !loading.value
                            ? const Text('Save')
                            : const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ],
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
