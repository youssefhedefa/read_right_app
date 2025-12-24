import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_right/features/app_auth/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final String _userCollection = 'users';
  AuthDataSource({required this.firebaseAuth});

  Future<UserCredential> login(
      {required String email, required String password}) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Future<UserCredential> register(
      {required String email, required String password}) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  CollectionReference<UserModel> getUserCollection() {
    var reference =
    FirebaseFirestore.instance.collection(_userCollection).withConverter(
      fromFirestore: (snapshot, options) {
        Map<String, dynamic>? doc = snapshot.data();
        return UserModel.fromMap(doc!);
      },
      toFirestore: (user, options) {
        return user.toMap();
      },
    );
    return reference;
  }

  Future createNewUser({required UserModel user})async{
    var userCollection = getUserCollection();
    var docReference = userCollection.doc(user.id);
    await docReference.set(user);
  }

  Future<UserModel?> getUser(String userId) async {
    var userCollection = getUserCollection();
    var docReference = userCollection.doc(userId);
    var snapshot = await docReference.get();
    var user = snapshot.data();
    return user;
  }

  Future<void> updateUserWords({required int correctWords,required int wrongWords}) async {
    var userCollection = getUserCollection();
    var user = firebaseAuth.currentUser;
    var docReference = userCollection.doc(user!.uid);
    var snapshot = await docReference.get();
    var data = snapshot.data();
    var newTotalWords = data!.totalWords + correctWords + wrongWords;
    var newCorrectWords = data.correctWords + correctWords;
    var newWrongWords = data.wrongWords + wrongWords;
    var words = {
      'correct_words': newCorrectWords,
      'wrong_words': newWrongWords,
      'total_words': newTotalWords
    };
    await docReference.update(words);
  }

  Future<List<dynamic>> updateUserSavedBooks({required int bookId}) async {
    var userCollection = getUserCollection();
    var user = firebaseAuth.currentUser;
    var docReference = userCollection.doc(user!.uid);
    var snapshot = await docReference.get();
    var data = snapshot.data();
    var savedBooks = data!.myBooks;
    savedBooks.add(bookId);
    var books = {
      'saved_books': savedBooks
    };
    await docReference.update(books);
    return savedBooks;
  }

  Future<List> getUserSavedBooks() async {
    var userCollection = getUserCollection();
    var user = firebaseAuth.currentUser;
    var docReference = userCollection.doc(user!.uid);
    var snapshot = await docReference.get();
    var data = snapshot.data();
    return data!.myBooks;
  }

  Future<List> deleteBookFromSavedBooks({required int bookId}) async {
    var userCollection = getUserCollection();
    var user = firebaseAuth.currentUser;
    var docReference = userCollection.doc(user!.uid);
    var snapshot = await docReference.get();
    var data = snapshot.data();
    var savedBooks = data!.myBooks;
    savedBooks.remove(bookId);
    var books = {
      'saved_books': savedBooks
    };
    await docReference.update(books);
    return savedBooks;
  }

  // create funstion to take email and look up if the email exists in firebase authentication
  Future<bool> checkIfEmailExists({required String email}) async {
    var userCollection = getUserCollection();
    var querySnapshot = await userCollection
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }
}
