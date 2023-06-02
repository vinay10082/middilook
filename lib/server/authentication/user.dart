import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? name;
  String? uid;
  String? image;
  String? phone;
  String? email;
  String? password;

  // int? totalPurchaseLinkVisited;

  User({
    this.name,
    this.uid,
    this.image,
    this.phone,
    this.email,
    this.password,

    // this.totalPurchaseLinkVisited,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "image": image,
        "phone": phone,
        "email": email,
        "password": password,

        // "totalPurchaseLinkVisited": totalPurchaseLinkVisited,
      };

  static User fromSnap(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      name: dataSnapshot["name"],
      uid: dataSnapshot["uid"],
      image: dataSnapshot["image"],
      phone: dataSnapshot["phone"],
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],

      // totalPurchaseLinkVisited: dataSnapshot["totalPurchaseLinkVisited"],
    );
  }
}
