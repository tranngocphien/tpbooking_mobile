import 'package:tpbooking/models/hotel_entity.dart';

class BookingHistoryEntity {
  final int id;
  final int userId;
  final String roomId;
  final String hotelId;
  final String startDay;
  final String endDay;
  final int status;

  BookingHistoryEntity(
      {required this.id,
      required this.userId,
      required this.roomId,
      required this.hotelId,
      required this.startDay,
      required this.endDay,
      required this.status});

  factory BookingHistoryEntity.fromJson(Map<String, dynamic> json) {
    return BookingHistoryEntity(
        id: json['id'],
        userId: json['userId'],
        roomId: json['roomId'],
        hotelId: json['hotelId'],
        startDay: json['startDay'],
        endDay: json['endDay'],
        status: json['status']);
  }
}
