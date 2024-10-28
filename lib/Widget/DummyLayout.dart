import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({super.key});

  @override
  State<AddTasks> createState() => AddyTasksState();
}

class AddyTasksState extends State<AddTasks> {
  List AllTodoData = [];

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: Text("Do you want to Update Your Note!"),
                        content: Text("Update Your Notes"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {}, child: Text("Update"))
                        ],
                      );
                    });
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.add_box_outlined,
              label: 'Update',
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.done_all_outlined,
              label: 'Done',
            ),
          ],
        ),
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
          ),
          height: 100,
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Title : This is first TODO",
                style: GoogleFonts.iceberg(
                    textStyle:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              ),
              Text(
                "Description : it's a description",
                style: GoogleFonts.iceberg(textStyle: TextStyle(fontSize: 21)),
              )
            ],
          ),
        ));
  }
}
