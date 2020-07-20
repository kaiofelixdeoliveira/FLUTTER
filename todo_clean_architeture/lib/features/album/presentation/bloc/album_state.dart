part of 'album_bloc.dart';

@immutable
abstract class AlbumState extends Equatable {
  const AlbumState();
}

//eventos que sairão do bloc

class EmptyState extends AlbumState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class InitialState extends AlbumState {
  const InitialState();
  @override
  List<Object> get props => [];
}

class LoadingState extends AlbumState {
  const LoadingState();
  @override
  List<Object> get props => [];
}

class LoadedSucessState extends AlbumState {
  final List<Album> album;
  const LoadedSucessState(this.album);
  @override
  List<Object> get props => [album];
}

class ErrorState extends AlbumState {
  final String message;
  const ErrorState(this.message);
  @override
  List<Object> get props => [message];
}
