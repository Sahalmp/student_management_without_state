import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentmanagement/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentList = ValueNotifier([]);

void addstudent(StudentModel value) async {
  final studentdb = await Hive.openBox<StudentModel>('student_db');
  final _id = await studentdb.add(value);
  value.id = _id;
  studentList.value.add(value);
  studentList.notifyListeners();
}

Future<void> getallstudents() async {
  final studentdb = await Hive.openBox<StudentModel>('student_db');
  studentList.value.clear();
  studentList.value.addAll(studentdb.values);
  studentList.notifyListeners();
}

Future<void> deletestudent(int id) async {
  final studentdb = await Hive.openBox<StudentModel>('student_db');
  var key = studentdb.keyAt(id);
  await studentdb.delete(key);
  getallstudents();
}

updatestudent(StudentModel value, i) async {
  final studentdb = await Hive.openBox<StudentModel>('student_db');
  studentdb.putAt(i, value);
  getallstudents();
}

Future<String> imageSelect() async {
  XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
  return img!.path;
}
