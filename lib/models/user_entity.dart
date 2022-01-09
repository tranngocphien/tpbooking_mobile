class UserEntity {
  final int id;
  final String username;
  final String token;

  UserEntity({required this.id, required this.username, required this.token});

  factory UserEntity.fromJson(Map<String, dynamic> json){
    return UserEntity(id: json['id'], username: json['username'], token: json['token']);
  }
}