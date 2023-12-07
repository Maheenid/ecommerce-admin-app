import 'package:eco_admin_panel/models/category_model.dart';
import 'package:uuid/uuid.dart';

List<CategoryModel> categoryList = [
  CategoryModel(
    id: const Uuid().v4(),
    title: 'Watches',
    image: 'assets/Watches.jpg',
  ),
  CategoryModel(
    id: const Uuid().v4(),
    title: 'Shoes',
    image: 'assets/shoes.png',
  ),
  CategoryModel(
    id: const Uuid().v4(),
    title: 'Accessories',
    image: 'assets/Accessories.jpeg',
  ),
  CategoryModel(
    id: const Uuid().v4(),
    title: 'Electronics',
    image: 'assets/Electronics.jpg',
  ),
  CategoryModel(
    id: const Uuid().v4(),
    title: 'Clothes',
    image: 'assets/Clothes.jpg',
  ),
  CategoryModel(
    id: const Uuid().v4(),
    title: 'Books',
    image: 'assets/Books.jpg',
  ),
  CategoryModel(
    id: const Uuid().v4(),
    title: 'Cosmetics',
    image: 'assets/Cosmetics.jpg',
  ),
  CategoryModel(
    id: const Uuid().v4(),
    title: 'Phones',
    image: 'assets/Phones.jpg',
  ),
  CategoryModel(
    id: const Uuid().v4(),
    title: 'Laptops',
    image: 'assets/Laptops.jpg',
  ),
];
