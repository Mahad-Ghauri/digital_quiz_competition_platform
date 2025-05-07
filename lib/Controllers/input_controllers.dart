// import 'package:auth_screens/Model/product_model.dart';
import 'package:flutter/material.dart';

class InputControllers {
  //  Variables
  // final List<Product> cartItems = [];
  String sortOption = 'Default';
  //  TEXT INPUT CONTROLLERS
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    descriptionController.dispose();
    messageController.dispose();
    searchController.dispose();
  }
}
