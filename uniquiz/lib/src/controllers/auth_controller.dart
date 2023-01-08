import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uniquiz/src/firebase/firebase_ref.dart';
import 'package:uniquiz/src/models/user_model.dart';
import 'package:uniquiz/src/screens/home/home_screen.dart';
import 'package:uniquiz/src/screens/introduction/introduction_screen.dart';
import 'package:uniquiz/src/utils/logger.dart';

class AuthController extends GetxController{
  @override
  void onReady(){
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    isLoggedIn() ? navigateToHome() : navigateToIntroduction();
  }

  Future<void> signInWithGoogle() async{
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try{
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null){
        final _gAuthentication = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _gAuthentication.idToken,
          accessToken: _gAuthentication.accessToken
        );
        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHome();
      }
    } on Exception catch (error) {
      AppLogger.e(error);
    }
  }

  Future<void> signOut() async {
    AppLogger.d("Sign out");
    try{
      await _auth.signOut();
      navigateToIntroduction();
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  Future<void> saveUser(GoogleSignInAccount account) async {
    final user = Users(
      id: account.email,
      email: account.email,
      name: account.displayName??'',
      profilepic: account.photoUrl,
      totalPoints: 0
    );
    try {
      final docUser = await userRF.doc(user.email).get();
      final user2 = Users.fromSnapshot(docUser);
      user.totalPoints = user2.totalPoints;
    }catch (e){
      AppLogger.e(e);
    }
    userRF
        .doc(user.email)
        .set({"email": user.email, "name": user.name,"profilepic": user.profilepic, "totalPoints": user.totalPoints});
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  void navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void navigateToIntroduction() {
    Get.offAllNamed(IntroductionScreen.routeName);
  }
}