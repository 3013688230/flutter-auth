import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user_entity.dart';
import 'firebase_remote_data_source.dart';
import 'models/user_model.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore? fireStore;
  final FirebaseAuth? auth;
  final GoogleSignIn? googleSignIn;

  String _verificationId = "";

  FirebaseRemoteDataSourceImpl(this.fireStore, this.auth, this.googleSignIn);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = fireStore?.collection("users");
    final uid = await getCurrentUId();
    userCollection?.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        name: user.name,
        uid: uid,
        phoneNumber: user.phoneNumber,
        email: user.email,
        dob: user.dob,
        gender: user.gender,
      ).toDocument();
      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
        return;
      } else {
        userCollection.doc(uid).update(newUser);
        print("user already exist");
        return;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<String> getCurrentUId() async => auth!.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth!.currentUser?.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String pinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: pinCode);
    await auth?.signInWithCredential(authCredential);
  }

  @override
  Future<void> signOut() async {
    await auth?.signOut();
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential authCredential) {
      print("phone is verified : token ${authCredential.token}");
    };
    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException authCredential) {
      print("phone failed ${authCredential.message},${authCredential.code}");
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      this._verificationId = verificationId;
      print("time out $verificationId");
    };
    final PhoneCodeSent phoneCodeSent =
        (String verificationID, [int? forceResendingToken]) {
      this._verificationId = verificationID;
      print("sendPhoneCode $verificationID");
    };

    auth?.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  @override
  Future<void> googleAuth() async {
    final usersCollection = fireStore?.collection("users");

    try {
      final GoogleSignInAccount? account = await googleSignIn?.signIn();
      final GoogleSignInAuthentication googleAuth =
          await account!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final information = (await auth?.signInWithCredential(credential))?.user;
      usersCollection?.doc(auth?.currentUser!.uid).get().then((user) async {
        if (!user.exists) {
          var uid = auth?.currentUser!.uid;
          //TODO Initialize currentUser if not exist record
          var newUser = UserModel(
                  name: information!.displayName!,
                  email: information.email!,
                  phoneNumber: information.phoneNumber == null
                      ? ""
                      : information.phoneNumber!,
                  profileUrl:
                      information.photoURL == null ? "" : information.photoURL!,
                  dob: "",
                  gender: "",
                  uid: information.uid)
              .toDocument();

          usersCollection.doc(uid).set(newUser);
        }
      }).whenComplete(() {
        print("New User Created Successfully");
      }).catchError((e) {
        print("getInitializeCreateCurrentUser ${e.toString()}");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    await auth?.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signIn(UserEntity user) async {
    await auth?.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  @override
  Future<void> signUp(UserEntity user) async {
    await auth?.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  @override
  Future<void> getUpdateUser(UserEntity user) async {
    Map<String, dynamic> userInformation = Map();
    print(user.name);
    final userCollection = fireStore?.collection("users");

    if (user.phoneNumber != null && user.phoneNumber != "") {
      userInformation["phoneNumber"] = user.phoneNumber;
    }
    if (user.name != null && user.name != "") {
      userInformation["name"] = user.name;
    }

    userCollection?.doc(user.uid).update(userInformation);
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }
}
