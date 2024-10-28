import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task/Controller/TaskController.dart';
import 'package:task/View/AddTodo.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // Access the task controller
    final taskController = Provider.of<Taskcontroller>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodo()));
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(
          "WebReinvent Task",
          style: GoogleFonts.robotoCondensed(
              textStyle: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: taskController.oftask.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/notfound.png', // Replace with your image path
                        height: 150,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'No tasks found',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: taskController.oftask.length,
                  itemBuilder: (context, index) {
                    final task = taskController.oftask[index]; // Get task
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              TextEditingController titleController =
                                  TextEditingController(text: task.title);
                              TextEditingController descController =
                                  TextEditingController(text: task.descriptions);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog.adaptive(
                                      title: Text("Do you want to Update Your Note!"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                              controller: titleController,
                                              decoration: InputDecoration(labelText: 'Title')),
                                          TextField(
                                              controller: descController,
                                              decoration: InputDecoration(labelText: 'Description')),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              taskController.updateTask(
                                                  task,
                                                  titleController.text,
                                                  descController.text);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Update"))
                                      ],
                                    );
                                  });
                            },
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.add_box_outlined,
                            label: 'Update',
                          ),
                          // SizedBox(
                          //   height:100,
                          //   width:100,
                          //
                          //   child: Checkbox(value: false, onChanged: (v){
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text('Note Complete!'),
                          //         duration: Duration(seconds: 2),
                          //       ),
                          //     );
                          //   }),
                          // ),
                          SlidableAction(
                            onPressed: (context) {
                              // isChecked = true;
                              setState(() {
                                isChecked =!isChecked;
                                if(isChecked){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Note Complete!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Note Not Complete!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              });
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: Text('Note Complete!'),
                              //     duration: Duration(seconds: 2),
                              //   ),
                              // );
                            },
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon:!isChecked? Icons.check_box_outline_blank_outlined:Icons.check_box,
                            label: 'Done',
                          ),
                        ],
                      ),
                      startActionPane: ActionPane(
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              taskController.removeTask(taskController.oftask[index]);
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ExpansionTile(
                        title: Text("${task.title ?? ''}",
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.description_outlined,
                              color: Colors.green,
                            ),
                            title: Text("Description : ${task.descriptions ?? ''}",
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 21,
                                )),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.date_range_outlined,
                              color: Colors.green,
                            ),
                            title: Text("Date : ${task.date ?? ''}",
                                style: TextStyle(fontSize: 21)),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.access_time_outlined,
                              color: Colors.green,
                            ),
                            title: Text("Time : ${task.time ?? ''}",
                                style: TextStyle(fontSize: 21)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        )
      ]),
    );
  }
}
