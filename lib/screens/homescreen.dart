import 'package:flutter/material.dart';
import 'package:studentmanagement/screens/addstudentwidget.dart';
import 'package:studentmanagement/screens/screenfunctions/searchbar.dart';

import 'liststudentwidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Mysearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: const SafeArea(child: ListStudentWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const AddStudentWidget()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
