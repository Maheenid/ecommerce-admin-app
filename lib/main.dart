import 'package:eco_admin_panel/firebase_options.dart';
import 'package:eco_admin_panel/providers/favorite_provider.dart';
import 'package:eco_admin_panel/providers/order_provider.dart';
import 'package:eco_admin_panel/providers/product_provider.dart';
import 'package:eco_admin_panel/screens/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EcoAdminPanelApp());
}

class EcoAdminPanelApp extends StatelessWidget {
  const EcoAdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (contex) {
          return ProductProvider();
        }),
        ChangeNotifierProvider(create: (contex) {
          return FavoriteProvider();
        }),
        ChangeNotifierProvider(create: (contex) {
          return OrderProvider();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        home: const DashboardScreen(),
      ),
    );
  }
}
