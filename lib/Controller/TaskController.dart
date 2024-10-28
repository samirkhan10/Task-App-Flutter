import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Models/TaskModels.dart';

class Taskcontroller extends ChangeNotifier {
  List<Taskmodels> _oftask = [];

  List<Taskmodels> get oftask => _oftask;

  Taskcontroller() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      List<dynamic> tasksJson = jsonDecode(tasksString);
      _oftask = tasksJson.map((task) => Taskmodels.fromJson(task)).toList();
      notifyListeners();
    }
  }

  Future<void> addTask(Taskmodels task) async {
    _oftask.add(task);
    await saveTasks(); // Save tasks after adding
    notifyListeners();
  }

  Future<void> removeTask(Taskmodels task) async {
    _oftask.remove(task);
    await saveTasks(); // Save tasks after removing
    notifyListeners();
  }

  Future<void> updateTask(Taskmodels oldTask, String newTitle, String newDescription) async {
    final index = _oftask.indexOf(oldTask);
    if (index != -1) {
      _oftask[index] = Taskmodels(
        title: newTitle,
        descriptions: newDescription,
        date: oldTask.date, // Keep the old date
        time: oldTask.time, // Keep the old time
      );
      await saveTasks(); // Save tasks after updating
      notifyListeners();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    // Corrected this line to save the list of tasks properly
    List<Map<String, dynamic>> tasksJson = _oftask.map((task) => task.toJson()).toList();
    await prefs.setString('tasks', jsonEncode(tasksJson)); // Save the list as a JSON string
  }
}