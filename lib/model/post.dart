import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  const Post({this.id, this.title, this.body});

  @override
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() => 'Post { id: $id }';
}
