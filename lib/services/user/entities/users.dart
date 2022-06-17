import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? id;
  String? name;
  String? email;

  Users({
    this.id,
    this.name,
    this.email,
  });

  Users.fromMap(DocumentSnapshot data){
    id = data.id;
    name = data["Full Name"];
    email = data["Email"];
  }
}