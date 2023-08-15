import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:middilook/main.dart';

import '../../global.dart';
import 'user.dart' as userModel;

class AuthenticationController extends GetxController {

  static AuthenticationController instanceAuth = Get.find();

  String userVerificationID = "";
  bool isUserFound = false;

  void verifyPhoneNumber(String phoneNumber) async
  {
    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
      Get.snackbar('Verification Completed', "phone number is verfied");

    }
    verificationFailed(FirebaseAuthException exception) async {
      Get.snackbar('Verification Failed', exception.toString());

    }

    

    codeSent(String verificationID, int? forceResendingtoken) async {
      Get.snackbar('Verification Code', "verification code sent to the phone number.");

      userVerificationID = verificationID;
    }
    codeAutoRetrievalTimeout(String verificationId) async {
      Get.snackbar('Time Out', "");

    }
    try 
    {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted, 
        verificationFailed: verificationFailed, 
        codeSent: codeSent, 
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } 
    catch (errorMsg) 
    {
      Get.snackbar("Enter Valid Phone Number",
          "Error Occured while creating account. Try Again.");
    }
  }


  void signinWithPhoneNumber(String smsCode, String phoneNumber) async
  {
    try 
    {
      AuthCredential credential = PhoneAuthProvider.credential(verificationId: userVerificationID, smsCode: smsCode);
      // await FirebaseAuth.instance.signInWithCredential(credential);


      //1. Create user in the firebase authentication
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);


      DocumentSnapshot snapshotUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user!.uid)
        .get();
      
      userModel.User user;

      if(!snapshotUser.exists)
      {
    // save user data to the firebase database
      user = userModel.User(
        name: "",
        email: "",
        password: "",
        image: "",
        phone: phoneNumber,
        uid: userCredential.user!.uid,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(user.toJson());
      }
      

      Get.snackbar("Logged-in Successful", "you're logged-in successfully");

      Get.offAll(const HomePage());

      showProgressBar = false;
    } 
    catch (error) 
    {
      Get.snackbar("Login Unsuccessful", "Error Occured during signin authentication.");
      Get.offAll(const HomePage());
      showProgressBar = false;
    }
  }
}
