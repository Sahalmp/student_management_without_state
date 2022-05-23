import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentmanagement/db/dbfunctions/db_functions.dart';
import 'package:studentmanagement/db/model/data_model.dart';
import 'package:studentmanagement/screens/updatestudentwidget.dart';

class ViewStudentWidget extends StatelessWidget {
  final index;
  const ViewStudentWidget({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentList,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Students'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => UpdateStudentWidget(
                              index: index,
                            )));
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 197, 250, 225),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: studentList[index].image == null
                          ? const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/avatar.png'),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            )
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      FileImage(File(studentList[index].image)),
                                  fit: BoxFit.cover),
                            ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(studentList[index].name,
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.teal,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w900,
                        )),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          studentList[index].place,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              child: Row(children: [
                                const Text(
                                  "Age: ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  studentList[index].age,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ]),
                            ),
                            Container(
                              color: Colors.black45,
                              height: 50,
                              width: 2,
                            ),
                            SizedBox(
                              child: Row(children: [
                                const Text(
                                  "Gender: ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  studentList[index].gender,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ]),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
