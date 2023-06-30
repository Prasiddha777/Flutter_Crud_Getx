import 'dart:convert';
import 'dart:math';

import 'package:crud_api/models/tood_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {
  var TodoList = RxList<TodoModel>();

  @override
  void onInit() {
    super.onInit();
    getTodos();
  }

  Future<RxList<TodoModel>> getTodos() async {
    final response = await http.get(
        Uri.parse('https://649afaadbf7c145d0239cfc9.mockapi.io/api/todolist'));
    if (response.statusCode == 200) {
      print(response.statusCode);
      var decodedResp = jsonDecode(
        response.body.toString(),
      );
      for (Map<String, dynamic> element in decodedResp) {
        TodoList.add(
          TodoModel.fromJson(element),
        );
      }
      return TodoList;
    } else {
      log(response.statusCode);
    }
    return TodoList;
  }

  //for post
  Future<void> postTodo(String title) async {
    print('Enter Post');
    final resp = await http.post(
      Uri.parse('https://649afaadbf7c145d0239cfc9.mockapi.io/api/todolist'),
      // headers: {'Content-Type': 'application/json'},
      body: {
        "title": title,
      },
    );
    if (resp.statusCode == 201) {
      print('Success');
      TodoList.clear();
      getTodos();
    } else {
      print('UnSuccess');
    }
  }
}
