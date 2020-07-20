part of 'album_bloc.dart';

@immutable
abstract class AlbumEvent extends Equatable {
  const AlbumEvent();
}

//eventos que serão enviados para a entrada do bloc

class LoadingSucessAlbumEvent extends AlbumEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class GetAlbumEvent extends AlbumEvent {
  final int id;
  const GetAlbumEvent(this.id);
  @override
  List<Object> get props => [];
}

class CreateAlbumEvent extends AlbumEvent {
  final Album album;
  const CreateAlbumEvent(this.album);

  @override
  List<Object> get props => [album];
}

class UpdateAlbumEvent extends AlbumEvent {
  final Album album;
  const UpdateAlbumEvent(this.album);

  @override
  List<Object> get props => [album];
}

class DeleteAlbumEvent extends AlbumEvent {
  final Album album;

  const DeleteAlbumEvent(this.album);

  @override
  List<Object> get props => [album];
}

class NetworkErrorEvent extends Error {}
