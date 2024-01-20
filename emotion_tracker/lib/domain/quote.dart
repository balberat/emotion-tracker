import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String author;
  final String body;

  const Quote({
    required this.author,
    required this.body,
  });

  @override
  List<Object?> get props => [author, body];

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      author: map["author"] as String,
      body: map["body"] as String,
    );
  }
}
