import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService {
  final FirebaseFirestore _firestore;

  CommentService(this._firestore);

  Future<Map<String, dynamic>?> getLastComment(String movieId) async {
    try {
      final query = await _firestore.collection('comments').where('movie', isEqualTo: int.parse(movieId)).limit(1).get();

      if (query.docs.isNotEmpty) {
        return query.docs.first.data();
      }
      return {};
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllComments(String movieId) async {
    try {
      final query = await _firestore.collection('comments').where('movie', isEqualTo: int.parse(movieId)).get();

      return query.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addComment({
    required String comment,
    required String movieId,
    required Map<String, dynamic> user,
  }) async {
    try {
      await _firestore.collection('comments').add({
        "id": _firestore.collection('comments').doc().id,
        "comment": comment,
        "date": DateTime.now().toUtc().toIso8601String(),
        "user": user,
        "movie": movieId,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
