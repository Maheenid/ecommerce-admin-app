import 'package:eco_admin_panel/screens/addproduct_screen.dart';
import 'package:eco_admin_panel/screens/vieworder_screen.dart';
import 'package:eco_admin_panel/screens/viewproduct_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Color.fromARGB(255, 22, 22, 22),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const AddProductScreen(),
                  ),
                );
              },
              child: ListTile(
                leading: Image.asset(
                  'assets/image/addproduct.png',
                ),
                title: const Text(
                  'Add Product',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const ViewProductScreen()));
              },
              child: ListTile(
                leading: Image.asset(
                  'assets/image/searchproduct.png',
                ),
                title: const Text(
                  'View Products',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const ViewOrderScreen()),
                );
              },
              child: ListTile(
                leading: Image.asset(
                  'assets/image/vieworder.jpg',
                  height: 50,
                ),
                title: const Text(
                  'View Orders',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
