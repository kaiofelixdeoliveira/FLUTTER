import 'package:todo_bloc/features/album/domain/entities/album.dart';

class AlbumModel extends Album {
  final int userId;
  final int id;
  final String title;

  AlbumModel({this.userId, this.id, this.title})
      : super(userId: userId, id: id, title: title);

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      userId: (json['userId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      title: json['title'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title};
  }

  @override
  String toString() {
    return 'AlbumModel{id: $id, userId: $userId, title: $title}';
  }

  @override
  List<Object> get props => [
        userId,
        id,
        title,
      ];
}
