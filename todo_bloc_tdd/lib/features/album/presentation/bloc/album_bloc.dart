import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/core/error/failure.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart';

import 'package:todo_bloc/features/album/domain/repositories/album_repository.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc({@required this.repository});
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
      var albums = (await this.repository.getAllAlbums());

      yield albums.fold(
        (failure) => ErrorState("error loading Albums"),
        (albums) => LoadedSucessState(albums),
      );
    } catch (_) {
      yield ErrorState("error loading Albums");
    }
  }

  Stream<AlbumState> _mapAlbumAddedToState(CreateAlbumEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        var newAlbum = (await this.repository.createAlbum(event.album));

        yield newAlbum.fold(
          (failure) => ErrorState("error fold Albums"),
          (albums) => LoadedSucessState(
            List<Album>.from((state as LoadedSucessState).album)..add(albums),
          ),
        );
      }
    } catch (_) {
      yield ErrorState("error Add Album");
    }
  }

  Stream<AlbumState> _mapAlbumUpdatedToState(UpdateAlbumEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        var updatedAlbum = (await this.repository.updateAlbum(event.album));

        yield updatedAlbum.fold(
          (failure) => ErrorState("error loading Albums"),
          (albums) =>
              LoadedSucessState((state as LoadedSucessState).album.map((album) {
            return album.id == albums.id ? albums : album;
          }).toList()),
        );
      }
    } catch (_) {
      yield ErrorState("error update album");
    }
  }

  Stream<AlbumState> _mapAlbumDeletedToState(DeleteAlbumEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        await this.repository.deleteAlbum(event.album.id);
        final deletelbum = (state as LoadedSucessState)
            .album
            .where((album) => album.id != event.album.id)
            .toList();
        yield LoadedSucessState(deletelbum);
      }
    } catch (_) {
      yield ErrorState("error delete album");
    }
  }
}
