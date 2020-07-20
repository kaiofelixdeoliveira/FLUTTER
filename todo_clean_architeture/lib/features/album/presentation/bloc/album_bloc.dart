import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/core/error/failure.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart';

import 'package:todo_bloc/features/album/domain/repositories/album_repository.dart';
import 'package:todo_bloc/features/album/domain/usecases/createAlbum.dart';
import 'package:todo_bloc/features/album/domain/usecases/deleteAlbum.dart';
import 'package:todo_bloc/features/album/domain/usecases/getAlbum.dart';
import 'package:todo_bloc/features/album/domain/usecases/getAlbums.dart';
import 'package:todo_bloc/features/album/domain/usecases/updateAlbum.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
//  final AlbumRepository repository;
  final GetAlbums getAlbums;
  final GetAlbum getAlbum;
  final UpdateAlbum updateAlbum;
  final DeleteAlbum deleteAlbum;
  final CreateAlbum createAlbums;

  AlbumBloc({
    final GetAlbums receivedGetAlbums,
    final GetAlbum receivedGetAlbum,
    final UpdateAlbum receivedUpdateAlbum,
    final DeleteAlbum receivedDeleteAlbum,
    final CreateAlbum receivedCreateAlbums,
  })  : assert(receivedGetAlbums != null),
        assert(receivedGetAlbum != null),
        assert(receivedUpdateAlbum != null),
        assert(receivedDeleteAlbum != null),
        assert(receivedCreateAlbums != null),
        getAlbums = receivedGetAlbums,
        getAlbum = receivedGetAlbum,
        updateAlbum = receivedUpdateAlbum,
        deleteAlbum = receivedDeleteAlbum,
        createAlbums = receivedCreateAlbums;

  @override
  AlbumState get initialState => LoadingState();

  @override
  Stream<AlbumState> mapEventToState(
    AlbumEvent event,
  ) async* {
    // Emitting a state from the asynchronous generator
    // Branching the executed logic by checking the event type
    LoadingState();
    if (event is LoadingSucessAlbumEvent) {
      yield* _mapAlbumsLoadedToState();
    } else if (event is CreateAlbumEvent) {
      yield* _mapAlbumAddedToState(event);
    } else if (event is UpdateAlbumEvent) {
      yield* _mapAlbumUpdatedToState(event);
    } else if (event is DeleteAlbumEvent) {
      yield* _mapAlbumDeletedToState(event);
    }
  }

  Stream<AlbumState> _mapAlbumsLoadedToState() async* {
    try {
      var albums = (await this.getAlbums());

      yield albums.fold(
        (failure) => ErrorState("error loading Albums"),
        (albums) => LoadedSucessState(albums),
      );
    } catch (error) {
      yield ErrorState("error loading Albums" + error.toString());
    }
  }

  Stream<AlbumState> _mapAlbumAddedToState(CreateAlbumEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        var newAlbum = (await this.createAlbums(event.album));

        if (newAlbum != null) {
          yield newAlbum.fold(
            (failure) => ErrorState("error fold Albums"),
            (albums) => LoadedSucessState(
              List<Album>.from((state as LoadedSucessState).album)..add(albums),
            ),
          );
        } else {
          LoadedSucessState(
            List<Album>.from((state as LoadedSucessState).album),
          );
        }
      }
    } catch (error) {
      yield ErrorState("error Add Album" + error.toString());
    }
  }

  Stream<AlbumState> _mapAlbumUpdatedToState(UpdateAlbumEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        var updatedAlbum = (await this.updateAlbum(event.album));

        if (updatedAlbum != null) {
          yield updatedAlbum.fold(
            (failure) => ErrorState("error loading Albums"),
            (albums) => LoadedSucessState(
                (state as LoadedSucessState).album.map((album) {
              return album.id == albums.id ? albums : album;
            }).toList()),
          );
        } else {
          LoadedSucessState((state as LoadedSucessState).album);
        }
      }
    } catch (error) {
      yield ErrorState("error update album" + error.toString());
    }
  }

  Stream<AlbumState> _mapAlbumDeletedToState(DeleteAlbumEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        await this.deleteAlbum(event.album.id);
        final deletelbum = (state as LoadedSucessState)
            .album
            .where((album) => album.id != event.album.id)
            .toList();
        yield LoadedSucessState(deletelbum);
      }
    } catch (error) {
      yield ErrorState("error delete album" + error.toString());
    }
  }
}
