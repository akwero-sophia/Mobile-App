import 'package:flutter/material.dart';

void main() {
  runApp(StudyTrackerApp());
}

/// Root of the application
class StudyTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudyHomePage(),
    );
  }
}

/// Model class representing a study task
class StudyTask {
  String title;
  bool isCompleted;

  StudyTask({required this.title, this.isCompleted = false});
}

/// Main Home Page (Stateful because data changes)
class StudyHomePage extends StatefulWidget {
  @override
  _StudyHomePageState createState() => _StudyHomePageState();
}

class _StudyHomePageState extends State<StudyHomePage> {

  // List to store tasks
  List<StudyTask> tasks = [];

  // Controller to read text input
  final TextEditingController _controller = TextEditingController();

  /// Function to add a new task
  void addTask(String title) {
    if (title.isNotEmpty) {
      setState(() {
        tasks.add(StudyTask(title: title));
      });
      _controller.clear();
    }
  }

  /// Function to toggle completion
  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  /// Function to delete a task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  /// Function to count completed tasks
  int completedCount() {
    return tasks.where((task) => task.isCompleted).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study Tracker"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          // Input field and button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Enter study task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => addTask(_controller.text),
                  child: Text("Add"),
                )
              ],
            ),
          ),

          // Display task statistics
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Completed: ${completedCount()} / ${tasks.length}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          // Task list
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tasks[index].title,
                    style: TextStyle(
                      decoration: tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (value) => toggleTask(index),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
