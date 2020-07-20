import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart';
import 'package:todo_bloc/features/album/domain/repositories/album_repository.dart';
import 'package:todo_bloc/features/album/domain/usecases/getAlbums.dart';

class MockAlbumRepository extends Mock implements AlbumRepository {}

void main() {
  GetAlbums usecase;
  MockAlbumRepository mockAlbumRepository;

  setUp(() {
    mockAlbumRepository = MockAlbumRepository();
    usecase = GetAlbums(repository: mockAlbumRepository);
  });

  final albums = [
    Album(id: 1, title: "test 1", userId: 1),
    Album(id: 2, title: "test 2", userId: 2),
    Album(id: 3, title: "test 3", userId: 3),
  ];

  test(
    'should get albums from the repository',
    () async {
      when(mockAlbumRepository.getAllAlbums())
          .thenAnswer((_) async => Right(albums));

      final result = await usecase();

      expect(result, Right(albums));
      // Verify that the method has been called on the Repository
      verify(mockAlbumRepository.getAllAlbums());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockAlbumRepository);
    },
  );
}
