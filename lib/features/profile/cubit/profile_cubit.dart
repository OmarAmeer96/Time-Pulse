import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  ProfileCubit(this._auth, this._firestore) : super(ProfileInitial());

  Future<void> fetchUserData() async {
    emit(ProfileLoading());
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await _firestore
            .collection('employees')
            .where('ID', isEqualTo: user.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = querySnapshot.docs[0];
          emit(ProfileLoaded(userDoc.data() as Map<String, dynamic>));
          return;
        }
      }
      emit(ProfileError('User data not found.'));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
