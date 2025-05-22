// test/data/repositories/comments_repository_impl_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tech_travel/src/core/errors/comments_failure.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/data/models/comments_model.dart';
import 'package:tech_travel/src/core/services/comments_serivce.dart';
import 'package:tech_travel/src/data/repositories/comments_repository_impl.dart';

import 'comments_repository_test.mocks.dart';

@GenerateMocks([CommentService])
void main() {
  late MockCommentService mockService;
  late CommentsRepositoryImpl repository;

  setUp(() {
    mockService = MockCommentService();
    repository = CommentsRepositoryImpl(mockService);
  });

  group('getComments', () {
    final List<Map<String, dynamic>> rawJsonList = [
      {
        'id': '1',
        'comment': 'Test comment',
        'date': '2025-01-01T12:00:00Z',
        'user': {
          'id': 42,
          'name': 'Alice',
          'email': 'alice@example.com',
          'firebaseUid': 'uid-xyz',
          'photoUrl': null,
        },
        'movie': 'm123',
      },
    ];

    test('returns Right(List<CommentsEntity>) on success', () async {
      when(mockService.getAllComments('m1')).thenAnswer((_) async => rawJsonList);

      final result = await repository.getComments('m1');

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('esperava Right'),
        (list) {
          expect(list, isA<List<CommentsEntity>>());
          expect(list.length, 1);
          expect(list.first.comment, 'Test comment');
        },
      );
    });

    test('returns Left(CommentsFailure) on exception', () async {
      when(mockService.getAllComments('m1')).thenThrow(Exception('fail'));

      final result = await repository.getComments('m1');

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<CommentsFailure>()),
        (_) => fail('esperava Left'),
      );
    });
  });

  group('addComment', () {
    final model = CommentsModel(
      id: '1',
      comment: 'Test',
      date: DateTime.parse('2025-01-01T00:00:00Z'),
      user: const UserModel(
        email: 'boob@email.com',
        name: 'Bob',
        id: 123,
        photoUrl: 'url',
        firebaseUid: 'uuid',
      ),
      movie: 'm1',
    );

    test('returns Right(null) on success', () async {
      when(mockService.addComment(
        comment: model.comment!,
        movieId: model.movie!,
        user: model.user!.toJson(),
      )).thenAnswer((_) async => Future.value(true));

      final result = await repository.addComment(model);

      expect(result.isRight(), isTrue);
    });

    test('returns Left(CommentsFailure) on exception', () async {
      when(mockService.addComment(
        comment: model.comment!,
        movieId: model.movie!,
        user: model.user!.toJson(),
      )).thenThrow(Exception('fail'));

      final result = await repository.addComment(model);

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<CommentsFailure>()),
        (_) => fail('esperava Left'),
      );
    });
  });

  group('getLastComment', () {
    final rawJson = {
      'id': '1',
      'comment': 'Test comment',
      'date': '2025-01-01T12:00:00Z',
      'user': {
        'id': 42,
        'name': 'Alice',
        'email': 'alice@example.com',
        'firebaseUid': 'uid-xyz',
        'photoUrl': null,
      },
      'movie': 'm123',
    };

    test('returns Right(CommentsEntity) when data is non-null', () async {
      when(mockService.getLastComment('m2')).thenAnswer((_) async => rawJson);

      final result = await repository.getLastComment('m2');

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('esperava Right'),
        (entity) {
          expect(entity, isA<CommentsEntity>());
          expect(entity.comment, 'Test comment');
        },
      );
    });

    test('returns Right(CommentsEntity) when service returns null (fallback to empty map)', () async {
      when(mockService.getLastComment('m2')).thenAnswer((_) async => null);

      final result = await repository.getLastComment('m2');

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('esperava Right'),
        (entity) {
          // fromJson({}) deve produzir entidade com campos default ou nullables
          expect(entity, isA<CommentsEntity>());
        },
      );
    });

    test('returns Left(CommentsFailure) on exception', () async {
      when(mockService.getLastComment('m2')).thenThrow(Exception('fail'));

      final result = await repository.getLastComment('m2');

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<CommentsFailure>()),
        (_) => fail('esperava Left'),
      );
    });
  });
}
