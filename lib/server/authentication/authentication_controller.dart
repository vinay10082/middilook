import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/authentication_page/signup_page.dart';
import 'package:middilook/pages/home_page.dart';

import '../../global.dart';
import 'user.dart' as userModel;

class AuthenticationController extends GetxController {

  static AuthenticationController instanceAuth = Get.find();

  // late Rx<File?> _pickedFile;
  // File? get profileImage => _pickedFile.value;

  // void chooseImageFromGallery() async {
  //   final pickedImageFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (pickedImageFile != null) {
  //     Get.snackbar("profile Image",
  //         "You have successfully selected your profile image.");
  //   }

  //   _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  // }

  // void captureImageWithCamera() async {
  //   final pickedImageFile =
  //       await ImagePicker().pickImage(source: ImageSource.camera);

  //   if (pickedImageFile != null) {
  //     Get.snackbar("profile Image",
  //         "You have successfully capture image from your camera.");
  //   }

  //   _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  // }

  void createAccountForNewUser(
      // File imageFile,
      String userName,
      String userEmail,
      String userPassword) async {
    try {
      //1. Create user in the firebase authentication
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      // 2. Save the user profile image to firebase storage
      String imageDownloadUrl = "";
      // String imageDownloadUrl = await uploadImageToStorage(imageFile);

      //3. save user data to the firestore database
      userModel.User user = userModel.User(
        name: userName,
        email: userEmail,
        image: imageDownloadUrl,
        uid: credential.user!.uid,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toJson());

      Get.snackbar(
          "Account Created", "Congratulations, your account has been created");

      Get.offAll(MyHome());

      showProgressBar = false;
    } catch (error) {
      Get.snackbar("Account Creation Unsuccessful",
          "Error Occured while creating account. Try Again.");

      Get.to(MySignupAuth());

      showProgressBar = false;
    }
  }

  // Future<String> uploadImageToStorage(File imageFile) async {
  //   Reference reference = FirebaseStorage.instance
  //       .ref()
  //       .child("Profile Images")
  //       .child(FirebaseAuth.instance.currentUser!.uid);

  //   UploadTask uploadTask = reference.putFile(imageFile);
  //   TaskSnapshot taskSnapshot = await uploadTask;

  //   String downloadUrlOfUploadedImage = await taskSnapshot.ref.getDownloadURL();

  //   return downloadUrlOfUploadedImage;
  // }

  void loginUserNow(String userEmail, String userPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      Get.snackbar("Logged-in Successful", "you're logged-in successfull.");

      Get.offAll(MyHome());

      showProgressBar = false;
    } catch (error) {
      Get.snackbar(
          "Login Unsuccessful", "Error Occured during signin authentication.");

      Get.to(MySignupAuth());

      showProgressBar = false;
    }
  }

  void verifyPhoneNumber(String phoneNumber) async
  {
    PhoneVerificationCompleted verificationCompleted = 
    (PhoneAuthCredential phoneAuthCredential) async {
      Get.snackbar('Verification Completed', "phone number is verfied");

    };
    PhoneVerificationFailed verificationFailed = 
    (FirebaseAuthException exception) async {
      Get.snackbar('Verification Failed', exception.toString());

    };
    PhoneCodeSent codeSent = 
    (String verificationID, int? forceResendingtoken) async {
      Get.snackbar('Verification Code', "verification code set to the phone number.");

    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = 
    (String verificationId) async {
      Get.snackbar('Time Out', "");

    };
    try 
    {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted, 
        verificationFailed: verificationFailed, 
        codeSent: codeSent, 
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

    //save user data to the firebase database
      // userModel.User user = userModel.User(
      //   phone: phoneNumber
      //   uid: credential.user!.uid,
      // );

      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(credential.user!.uid)
      //     .set(user.toJson());
    } 
    catch (errorMsg) 
    {
      Get.snackbar("Enter Valid Phone Number",
          "Error Occured while creating account. Try Again.");
    }
  }
}
