import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentmanagement/db/dbfunctions/db_functions.dart';
import 'package:studentmanagement/db/model/data_model.dart';

import 'package:studentmanagement/screens/screenfunctions/scrnfunctions.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({Key? key}) : super(key: key);

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _namecontroller = TextEditingController();

  final _agecontroller = TextEditingController();
  final _placecontroller = TextEditingController();
  final _gendercontroller = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var _image;

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
      body: Padding(
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
                  headtitle('Add Student'),
                  const SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: _image == null
                        ? const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/avatar.png'),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          )
                        : BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(File(_image)),
                                fit: BoxFit.cover),
                          ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          var image = await imageSelect();
                          setState(() {
                            _image = image;
                          });
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                        ),
                        child: const Icon(Icons.photo_camera),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  txtfield(
                      label: 'Name',
                      type: TextInputType.name,
                      getcontrol: _namecontroller),
                  const SizedBox(height: 20),
                  txtfield(
                      label: 'Age',
                      type: TextInputType.number,
                      getcontrol: _agecontroller),
                  const SizedBox(height: 20),
                  txtfield(
                      label: 'Gender',
                      type: TextInputType.name,
                      getcontrol: _gendercontroller),
                  const SizedBox(height: 20),
                  txtfield(
                      label: 'Place',
                      type: TextInputType.streetAddress,
                      getcontrol: _placecontroller),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
          // })
          ),
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
        name: _name, age: _age, image: _image, place: _place, gender: _gender);

    addstudent(_student);
    Navigator.of(context).pop();
    const snackBar = SnackBar(
      content: Text('Student Added'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
