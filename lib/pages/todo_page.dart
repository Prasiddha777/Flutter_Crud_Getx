import 'package:crud_api/controller/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.put(TodoController());
    TextEditingController ctr = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('T O D O'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: 'Enter New Task',
            content: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: ctr,
                        decoration: InputDecoration(
                          hintText: 'Enter Task',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.back();
                        ctr.clear();
                      },
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        todoController.postTodo(ctr.text.toString());
                        Get.back();
                        ctr.clear();
                        //add data;
                      },
                      child: const Text('Save'),
                    )
                  ],
                )
              ],
            ),
          );
        },
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Container(
                width: Get.width,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Center(
                  child: Text(
                    "All Todo's",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),

            FutureBuilder(
              future: todoController.getTodos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('data ');
                  return Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: todoController.TodoList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final iIndex = todoController.TodoList[index];
                        return ListTile(
                          title: Text(
                            iIndex.title.toString(),
                          ),
                        );
                      },
                    );
                  });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: todoController.TodoList.length,
            //   itemBuilder: (context, index) {
            //     final fIndex = todoController.TodoList[index];
            //     return Obx(() {
            //       return Column(
            //         children: todoController.TodoList.map(
            //           (element) => Container(
            //             padding: const EdgeInsets.all(10),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(7),
            //               color: Colors.grey.shade200,
            //             ),
            //             child: Column(
            //               children: [
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                   children: [
            //                     const Icon(
            //                       Icons.add_circle,
            //                     ),
            //                     const SizedBox(
            //                       width: 15,
            //                     ),
            //                     Text(element.title.toString()),
            //                     IconButton(
            //                         onPressed: () {
            //                           Get.defaultDialog();
            //                         },
            //                         icon: const Icon(Icons.edit)),
            //                     const SizedBox(
            //                       width: 15,
            //                     ),
            //                     IconButton(
            //                         onPressed: () {},
            //                         icon: const Icon(Icons.delete)),
            //                   ],
            //                 )
            //               ],
            //             ),
            //           ),
            //         ).toList(),
            //       );
            //     });
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
