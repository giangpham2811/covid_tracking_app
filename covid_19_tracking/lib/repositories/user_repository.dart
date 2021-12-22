import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  UserRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FacebookLogin? facebookLogin,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: <String>[
                'email',
                'https://www.googleapis.com/auth/contacts.readonly',
              ],
            ),
        _facebookLogin = facebookLogin ?? FacebookLogin();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  Future<Future<void>> signInWithEmailAndPassword(String email, String password) async {
    return _firebaseAuth
        .signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        )
        .then((value) => null)
        .catchError((e) {});
  }

  Future<User?> signInWithFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await _facebookLogin.logIn(['email']);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final credential = FacebookAuthProvider.credential(result.accessToken.token);
      final user = (await _firebaseAuth.signInWithCredential(credential)).user;
      return user;
    }
    if (result.status == FacebookLoginStatus.error) {
      print('Something went wrong with the login process. The error Facebook gave us: ${result.errorMessage}');
    }
    if (result.status == FacebookLoginStatus.cancelledByUser) {
      print('Login cancelled by the user.');
    }
  }

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    final result = await _firebaseAuth.signInWithCredential(credential);
    return result.user;
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  Future<void> resetPasswordLink(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([
      FirebaseAuth.instance.signOut(),
      _googleSignIn.signOut(),
      _facebookLogin.logOut(),
    ]);
  }

  Future<User?>? getUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }
}
