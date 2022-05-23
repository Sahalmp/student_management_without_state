import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentmanagement/db/dbfunctions/db_functions.dart';
import 'package:studentmanagement/db/model/data_model.dart';

import 'package:studentmanagement/screens/screenfunctions/scrnfunctions.dart';

class UpdateStudentWidget extends StatefulWidget {
  final index;
  var _image;
  UpdateStudentWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<UpdateStudentWidget> createState() => _UpdateStudentWidgetState();
}

class _UpdateStudentWidgetState extends State<UpdateStudentWidget> {
  final _namecontroller = TextEditingController();

  final _agecontroller = TextEditingController();

  final _placecontroller = TextEditingController();

  final _gendercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              onsavebuttonclicked(context);
            },
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: studentList,
          builder: (BuildContext ctx, List<StudentModel> studentList,
              Widget? child) {
            _namecontroller.text = studentList[widget.index].name;
            _agecontroller.text = studentList[widget.index].age;
            _gendercontroller.text = studentList[widget.index].gender;
            _placecontroller.text = studentList[widget.index].place;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 197, 250, 225),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: widget._image == null
                            ? BoxDecoration(
                                image: DecorationImage(
                                    image: checkimage(studentList),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              )
                            : BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(File(widget._image)),
                                    fit: BoxFit.cover),
                              ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              var image = await imageSelect();
                              setState(() {
                                widget._image = image;
                              });
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const CircleBorder()),
                            ),
                            child: const Icon(Icons.photo_camera),
                          ),
                        ),
                      ),
                      headtitle('Edit Student'),
                      const SizedBox(height: 20),
                      txtfieldedit('Name', TextInputType.name, _namecontroller),
                      const SizedBox(height: 20),
                      txtfieldedit('Age', TextInputType.number, _agecontroller),
                      const SizedBox(height: 20),
                      txtfieldedit(
                          'Gender', TextInputType.name, _gendercontroller),
                      const SizedBox(height: 20),
                      txtfieldedit('Place', TextInputType.streetAddress,
                          _placecontroller),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  onsavebuttonclicked(BuildContext context) async {
    final _name = _namecontroller.text.trim();
    final _age = _agecontroller.text.trim();
    final _place = _placecontroller.text.trim();
    final _gender = _gendercontroller.text.trim();
    if (_name.isEmpty || _age.isEmpty || _gender.isEmpty || _place.isEmpty) {
      return;
    }

    final _student = StudentModel(
        name: _name,
        age: _age,
        place: _place,
        gender: _gender,
        image: widget._image);

    updatestudent(_student, widget.index);
    Navigator.of(context).pop();
    const snackBar = SnackBar(
      content: Text('Student Updated'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  checkimage(studentList) {
    if (studentList[widget.index].image == null) {
      return const AssetImage('assets/images/avatar.png');
    } else {
      return FileImage(File(studentList[widget.index].image));
    }
  }
}
