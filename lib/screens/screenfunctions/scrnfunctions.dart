import 'package:flutter/material.dart';

import '../../db/dbfunctions/db_functions.dart';

txtfield({required label, required type, required getcontrol}) {
  return TextFormField(
    controller: getcontrol,
    decoration: InputDecoration(
      fillColor: Colors.white,
      label: Text(label),
      border: const OutlineInputBorder(),
    ),
    keyboardType: type,
  );
}

txtfieldeditname(label, type, getcontrol) {
  return TextFormField(
    controller: getcontrol,
    decoration: InputDecoration(
      label: Text(label),
      border: const OutlineInputBorder(),
    ),
    keyboardType: type,
  );
}

txtfieldedit(label, type, getcontrol) {
  return TextFormField(
    controller: getcontrol,
    decoration: InputDecoration(
      label: Text(label),
      border: const OutlineInputBorder(),
    ),
    keyboardType: type,
  );
}

headtitle(title) {
  return SizedBox(
    width: double.infinity,
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.teal,
        fontSize: 28,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

deletedialogbox(BuildContext context, index) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete this item'),
          actions: [
            ElevatedButton.icon(
                onPressed: () {
                  deletestudent(index);

                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete')),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.cancel),
                label: const Text('Cancel'))
          ],
        );
      });
}
