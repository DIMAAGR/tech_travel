import 'package:equatable/equatable.dart';
import 'package:tech_travel/src/core/interfaces/json_convertible.dart';

abstract class CommentsEntity extends Equatable implements JsonConvertible {
  const CommentsEntity({
    required this.id,
    required this.comment,
    required this.date,
    required this.user,
    required this.movie,
  });

  final String? id;
  final String? comment;
  final DateTime? date;
  final ComentsUserEntity? user;
  final String? movie;

  @override
  List<Object?> get props => [
        id,
        comment,
        date,
        user,
        movie,
      ];
}

abstract class ComentsUserEntity extends Equatable implements JsonConvertible {
  const ComentsUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.firebaseUid,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? firebaseUid;
  final dynamic photoUrl;

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        firebaseUid,
      ];
}
