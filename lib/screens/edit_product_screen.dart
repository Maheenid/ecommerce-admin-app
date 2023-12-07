import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_admin_panel/data/category_list.dart';
import 'package:eco_admin_panel/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.productModel});
  final ProductModel? productModel;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _titleController,
      _priceController,
      _quantityController,
      _descriptionController;
  File? _selectedImage;
  String? category;
  bool isloading = false;
  String? userImageUrl;

  @override
  void initState() {
    category = widget.productModel?.productCategory;
    _titleController =
        TextEditingController(text: widget.productModel?.productTitle);
    _priceController =
        TextEditingController(text: widget.productModel?.productPrice);
    _quantityController =
        TextEditingController(text: widget.productModel?.productQuantity);
    _descriptionController =
        TextEditingController(text: widget.productModel?.productDescription);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _valid() async {
    final isValid = _formkey.currentState!.validate();
    if (_selectedImage == null && widget.productModel?.productImage == null) {
      showDialog(
        context: context,
        builder: (ctx) => const AlertDialog(
          title: Text('please add image'),
        ),
      );
      return;
    }
    if (isValid) {
      setState(() {
        isloading = true;
      });
      userImageUrl = widget.productModel!.productImage;
      if (_selectedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('products')
            .child('${widget.productModel!.productId}.jpg');
        await ref.putFile(
          File(_selectedImage!.path),
        );
        userImageUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.productModel!.productId)
          .update({
        'productId': widget.productModel!.productId,
        'productTitle': _titleController.text,
        'productPrice': _priceController.text,
        'productCategory': category,
        'productDescription': _descriptionController.text,
        'productImage': userImageUrl,
        'productQuantity': _quantityController.text,
      });
    }
    setState(() {
      isloading = false;
    });
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('product has been updated'),
        ),
      );
    }
  }

  pickCameraImage() async {
    final cameraImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
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

  pickGalleryImage() async {
    final cameraImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
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
  Widget build(BuildContext context) {
    final categoryData = categoryList;
    if (isloading) {
      const Scaffold(
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
                'Edit Product',
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
                  height: 250,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : NetworkImage(
                              widget.productModel?.productImage != null
                                  ? widget.productModel!.productImage
                                  : '') as ImageProvider,
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
                width: 160,
                child: DropdownButtonFormField(
                  value: category,
                  decoration: const InputDecoration.collapsed(hintText: ''),
                  items: [
                    for (final data in categoryData)
                      DropdownMenuItem(
                        value: data.title,
                        child: Text(data.title),
                      ),
                  ],
                  onChanged: (value) {
                    category = value;
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
                  'Update',
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
