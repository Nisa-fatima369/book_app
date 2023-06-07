import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String? registration;

  Future<String?> addUser({
    required String? regNo,
    required String? name,
    required String? dpt,
    required String? semestr,
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(registration).set({
        'reg_no': regNo,
        'full_name': name,
        'department': dpt,
        'semester': semestr,
      });
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<String?> getUser(String email) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.doc(registration).get();
      final data = snapshot.data() as Map<String, dynamic>;
      return data['full_name'];
    } catch (e) {
      return 'Error fetching user';
    }
  }
}
