import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/utils/utilities.dart';

class FirebaseMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  //user class
  User user = User();

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication = await _signInAccount.authentication;

    final AuthCredential credential =
        GoogleAuthProvider.getCredential(accessToken: _signInAuthentication.accessToken, idToken: _signInAuthentication.idToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    return result.user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore.collection("users").where("email", isEqualTo: user.email).getDocuments();
    final List<DocumentSnapshot> docs = result.documents;

    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(FirebaseUser cUser) async {
    String userName = Utils.getUsername(user.email);
    user = User(
      uid: cUser.uid,
      email: cUser.email,
      name: cUser.displayName,
      profilePhoto: cUser.photoUrl,
      username: userName,
    );

    firestore.collection("users").document(user.uid).setData(user.toMap(user));
  }
}
