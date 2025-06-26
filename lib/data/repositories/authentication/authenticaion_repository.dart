import 'package:clima_news/features/authentication/screen/signup/widgets/verify_email_screen.dart';
import 'package:clima_news/features/authentication/screen/login/login_screen.dart';
import 'package:clima_news/features/authentication/screen/onboarding/onboarding_screen.dart';
import 'package:clima_news/features/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:clima_news/features/utils/exceptions/firebase_exceptions.dart';
import 'package:clima_news/features/utils/exceptions/format_exceptions.dart';
import 'package:clima_news/features/utils/exceptions/platform_exceptions.dart';
import 'package:clima_news/navigationmenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  //-- variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  //-- called from main.dart on app launch\
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenDirect();
  }

  //-- function to show relevant screen
  Future<void> screenDirect() async {
    //-- check the user email verified if he logined
    User? user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        return Get.offAll(() => const NavigationMenu());
      } else {
        return Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      //-- local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => LoginPage())
          : Get.offAll(() => OnBoardingScreen());
    }
  }

  /*----------------------email and password sign in-----------------*/
  //-- email authentication (sign in)

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.toString()).message.toString();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException {
      throw const AppFormatException();
    } catch (e) {
      throw 'Something went wrong, Please try againg';
    }
  }

  //-- eamil auhtentication (register)
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.toString()).message.toString();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException {
      throw const AppFormatException();
    } catch (e) {
      throw 'Something went wrong, Please try againg';
    }
  }

  //-- send email verification
  Future<void> sendEmailVerification() async {
    try {
      return _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.toString()).message.toString();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } on FormatException {
      throw const AppFormatException();
    } catch (e) {
      throw 'Something went wrong, Please try againg';
    }
  }
}
