// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import '../../core/constants/categories.dart';
// import '../../data/models/category_model.dart';

// class CategoryProvider extends ChangeNotifier {
//   final Box _box = Hive.box('categories');

//   List<CategoryModel> get all {
//     final custom = _box.values
//         .map((e) => CategoryModel.fromMap(Map<String, dynamic>.from(e)))
//         .toList();

//     final defaults = categories
//         .map(
//           (c) => CategoryModel(
//             name: c.name,
//             colorValue: c.color.value,
//             icon: c.icon,
//           ),
//         )
//         .toList();

//     return [...defaults, ...custom];
//   }

//   void addCategory(CategoryModel category) {
//     _box.put(category.name, category.toMap());
//     notifyListeners();
//   }
// }
