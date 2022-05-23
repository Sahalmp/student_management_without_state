import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentmanagement/db/dbfunctions/db_functions.dart';
import 'package:studentmanagement/screens/screenfunctions/scrnfunctions.dart';
import 'package:studentmanagement/screens/viewstudentwidget.dart';

import '../db/model/data_model.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getallstudents();
    return ValueListenableBuilder(
      valueListenable: studentList,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ViewStudentWidget(
                          index: index,
                        )));
              },
              title: Text(data.name),
              subtitle: Text(data.gender),
              trailing: IconButton(
                onPressed: () {
                  deletedialogbox(context, index);
                },
                icon: const Icon(Icons.delete),
              ),
              leading: getimage(data),
            );
          },
          separatorBuilder: ((ctx, index) => const Divider()),
          itemCount: studentList.length,
        );
      },
    );
  }

  getimage(data) {
    if (data.image == null) {
      return const CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
      );
    } else {
      return CircleAvatar(
        backgroundImage: FileImage(File(data.image)),
      );
    }
  }
}
