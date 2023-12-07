import 'package:eco_admin_panel/models/product_model.dart';
import 'package:eco_admin_panel/providers/product_provider.dart';
import 'package:eco_admin_panel/widgets/view_product_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({
    super.key,
  });

  @override
  State<ViewProductScreen> createState() => _ViewProductScreen();
}

class _ViewProductScreen extends State<ViewProductScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  List<ProductModel> searchList = [];
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return StreamBuilder<Object>(
        stream: productProvider.fetchDataStream(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Search',
                style: TextStyle(
                  color: Color.fromARGB(255, 22, 22, 22),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _textController.clear();
                          });
                        },
                        child: const Icon(Icons.clear),
                      ),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        searchList = productProvider.gitSearchList(
                            searchText: _textController.text);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: _textController.text.isNotEmpty
                        ? searchList.length
                        : productProvider.products.length,
                    itemBuilder: (context, index) => ViewProductWidget(
                      productModel: _textController.text.isNotEmpty
                          ? searchList[index]
                          : productProvider.products[index],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
