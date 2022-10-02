import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
}

class EmployeesCollection extends StatefulWidget {
  const EmployeesCollection({Key? key}) : super(key: key);

  @override
  State<EmployeesCollection> createState() => _EmployeesCollectionState();
}

class _EmployeesCollectionState extends State<EmployeesCollection> {
  final controller = TextEditingController();

  Future createUser({required String name}) async {
    // Reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final user = User(
      id: docUser.id,
      name: name,
      age: 21,
      birthday: DateTime(2001, 7, 8),
    );
    final json = user.toJson();
    await docUser.set(json);
  }

  //   final json = {
  //     'name': name,
  //     'age': 21,
  //     'birthday': DateTime(2001, 7, 28),
  //   };
  //
  //   /// Create document and write data to Firebase
  //   await docUser.set(json);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextField(
            controller: controller,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final name = controller.text;
                createUser(name: name);
              },
            ),
          ]),
    );
  }
}
