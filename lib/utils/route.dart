import 'package:crud_api/pages/todo_page.dart';
import 'package:get/get.dart';

var allPages = [
  GetPage(
    name: '/',
    page: () => TodoPage(),
  ),
];
