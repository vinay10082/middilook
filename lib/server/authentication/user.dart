import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  String? name;
  String? uid;
  String? image;
  String? email;
  String? password;

  User({
    this.name,
    this.uid,
    this.image,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "image": image,
    "email": email,
    "password": password
  };

  static User fromSnap(DocumentSnapshot snapshot)
  {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      name: dataSnapshot["name"],
      uid: dataSnapshot["uid"],
      image: dataSnapshot["image"],
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
    );
  }
}