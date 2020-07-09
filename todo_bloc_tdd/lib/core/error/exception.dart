class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
  List<Object> get props => [message];
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
  List<Object> get props => [message];
}
