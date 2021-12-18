import 'package:tpbooking/models/near_entity.dart';
import 'package:tpbooking/models/room_entity.dart';
import 'package:tpbooking/models/service_entity.dart';

class Hotel {
  String name;
  List<String> imgs;
  String city;
  String address;
  String description;
  double score;
  int scoreCount;
  double scoreClean;
  double scoreConvenient;
  double scoreLocation;
  double scoreService;
  double scoreWorthTheMoney;
  List<RoomEntity> rooms;
  List<NearEntity> nears;
  List<ServiceEntity> services;

  Hotel(
      {required this.name,
      required this.imgs,
      required this.city,
      required this.address,
      required this.description,
      required this.score,
      required this.scoreCount,
      required this.scoreClean,
      required this.scoreConvenient,
      required this.scoreLocation,
      required this.scoreService,
      required this.scoreWorthTheMoney,
      required this.rooms, required this.nears,
      required this.services
      });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json["name"],
      imgs: List<String>.from(json["imgs"].map((x) => x)),
      city: json["city"],
      address: json["address"],
      description: json["description"],
      score: json["reviewScore"]["score"],
      scoreCount: json["reviewScore"]["count"],
      scoreClean: json["reviewScore"]["clean"],
      scoreConvenient: json["reviewScore"]["convenient"],
      scoreLocation: json["reviewScore"]["location"],
      scoreService: json["reviewScore"]["service"],
      scoreWorthTheMoney: json["reviewScore"]["worthTheMoney"],
      rooms: List<RoomEntity>.from(
          json["rooms"].map((x) => RoomEntity.fromJson(x))),
      nears: List<NearEntity>.from(
          json["nears"].map((x) => NearEntity.fromJson(x))),
      services: List<ServiceEntity>.from(
          json["services"].map((x) => ServiceEntity.fromJson(x)))
    );
  }
}
