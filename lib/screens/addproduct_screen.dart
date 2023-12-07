import 'dart:io';
import 'package:eco_admin_panel/data/category_list.dart';
import 'package:eco_admin_panel/services/upload_user_information_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreen();
}

class _AddProductScreen extends State<AddProductScreen> {
  final _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _selectedImage;
  bool isloading = false;
  String? userImageUrl;
  String? _category;

  void _valid() async {
    final isValid = _formkey.currentState!.validate();
    if (_selectedImage == null) {
      showDialog(
        context: context,
        builder: (ctx) => const AlertDialog(
          title: Text('please add image'),
        ),
      );
      return;
    }
    if (_category == null) {
      showDialog(
        context: context,
        builder: (ctx) => const AlertDialog(
          title: Text('please select category'),
        ),
      );
      return;
    }
    if (isValid) {
      setState(() {
        isloading = true;
      });

      final uid = const Uuid().v4();
      final ref =
          FirebaseStorage.instance.ref().child('products').child('$uid.jpg');
      await ref.putFile(
        File(_selectedImage!.path),
      );
      userImageUrl = await ref.getDownloadURL();

      await UploadProduct().uploadProduct(
        productId: uid,
        productTitle: _titleController.text,
        productPrice: _priceController.text,
        productCategory: _category,
        productImage: userImageUrl,
        productDescription: _descriptionController.text,
        productQuantity: _quantityController.text,
      );
      setState(() {
        isloading = false;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('product has been added'),
          ),
        );
        _titleController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _quantityController.clear();
        setState(() {
          _selectedImage = null;
        });
        setState(() {
          _category == null;
        });
      }
    }
  }

  pickCameraImage() async {
    final cameraImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (cameraImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(cameraImage.path);
    });
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  pickGalleryImage() async {
    final cameraImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (cameraImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(cameraImage.path);
    });
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  removeImage() async {
    setState(() {
      _selectedImage = null;
    });
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = categoryList;
    if (isloading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Upload Product',
                style: TextStyle(
                  color: Color.fromARGB(255, 22, 22, 22),
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          Center(
                            child: TextButton(
                              onPressed: pickCameraImage,
                              child: const Text(
                                'Camera',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: pickGalleryImage,
                              child: const Text(
                                'Gallery',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: removeImage,
                              child: const Text(
                                'remove',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const AssetImage('assets/image/addimage.png')
                              as ImageProvider,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: 180,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration.collapsed(hintText: ''),
                  hint: const Text('Choose a Category'),
                  items: [
                    for (final data in categoryData)
                      DropdownMenuItem(
                        value: data.title,
                        child: Text(data.title),
                      ),
                  ],
                  onChanged: (value) {
                    _category = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please add a valid category';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'product title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please add a valid title';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'price',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            controller: _priceController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}'),
                              ),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please add a valid price';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'quantity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            controller: _quantityController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please add a valid quantity';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      controller: _descriptionController,
                      maxLines: 20,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please add a valid description';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 22, 22, 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                ),
                onPressed: _valid,
                child: const Text(
                  'Upload',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
