class CommentEntity {
  final int id;
  final int userId;
  final String userName;
  final String hotelId;
  final String content;
  final String time;

  CommentEntity(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.hotelId,
      required this.content,
      required this.time});

  factory CommentEntity.fromJson(Map<String, dynamic> json) {
    return CommentEntity(
        id: json['id'],
        userId: json['user']['id'],
        userName: json['user']['userName'],
        hotelId: json['hotelId'],
        content: json['content'],
        time: json['time']);
  }
}
