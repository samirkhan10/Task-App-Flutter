import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/Exports/MyExports.dart';

import '../Controller/TaskController.dart';
import '../Models/TaskModels.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => AddTodoState();
}

class AddTodoState extends State<AddTodo> {
  String? title;
  String? descriptions;
  String? date;
  String? time;

  Time? _time; // Changed to nullable
  bool iosStyle = true;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController _timeCont = TextEditingController();
  TextEditingController _date = TextEditingController();

  DateTime pickedTime = DateTime.now();

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime; // Update the time
    });
  }

  String formatTime(Time? time) {
    if (time == null)
      return 'Select Time'; // Placeholder when no time is selected
    DateTime dateTime =
        DateTime(2023, 1, 1, time.hour, time.minute); // Arbitrary date
    return DateFormat('hh:mm a').format(dateTime);
  }

  pickMyDate() async {
    DateTime? pickMyDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1990),
        lastDate: DateTime(DateTime.now().year + 15));

    if (pickMyDate != null) {
      pickedTime = pickMyDate;
      _date.text = DateFormat('dd-MM-yyyy').format(pickMyDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayTime = formatTime(_time);
    // Access the provider
    final taskController = Provider.of<Taskcontroller>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Notes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Enter Task',
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.note_add_outlined,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Note Title';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    title = value;
                    if (key.currentState!.validate()) {
                      setState(() {});
                    }
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Enter Note',
                    fillColor: Colors.white,
                    prefixIcon:
                        Icon(Icons.description_outlined, color: Colors.green),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    descriptions = value;
                    if (key.currentState!.validate()) {
                      setState(() {});
                    }
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Date",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _date,
                  onTap: () {
                    pickMyDate();
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Select Date',
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.date_range, color: Colors.green),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {});
                      return 'Please choose a date'; // Adjusted error message
                    }
                    return null; // Return null if the value is valid
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Time",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _timeCont,
                  onTap: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _time ??
                            Time(
                                hour: DateTime.now().hour,
                                minute: DateTime.now()
                                    .minute), // Default to noon if null
                        sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                        sunset: TimeOfDay(hour: 18, minute: 0), // optional
                        // onChange: onTimeChanged,
                        onChange: (newTime) {
                          onTimeChanged(newTime);
                          _timeCont.text =
                              formatTime(newTime); // Update the controller text
                          if (key.currentState!.validate()) {
                            setState(
                                () {}); // Refresh the widget to remove the error
                          }
                        },
                      ),
                    );
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Select Time',
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.timer_outlined, color: Colors.green),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please choose a time'; // Adjusted error message
                    }
                    return null; // Return null if the value is valid
                  },
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      print("Button pressed");
                      if (key.currentState!.validate()) {
                        if (title != null && descriptions != null) {
                          final newTask = Taskmodels(
                            title: title!,
                            descriptions: descriptions!,
                            date: _date.text,
                            time: _timeCont.text,
                          );
                          Provider.of<Taskcontroller>(context, listen: false)
                              .addTask(newTask);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyHome()),
                            (Route<dynamic> route) =>
                                false, // Removes all previous routes
                          );
                        } else {}
                      }
                    },
                    child: Text(
                      "Add Task",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
