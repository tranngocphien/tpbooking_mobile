import 'package:tpbooking/models/booking_history_entity.dart';
import 'package:tpbooking/models/comment_entity.dart';
import 'package:tpbooking/models/hotel_entity.dart';
import 'package:tpbooking/models/user_entity.dart';
import 'package:tpbooking/routes/api_routes.dart';
import 'package:tpbooking/services/dio/dio_service.dart';

class HotelServices {
  static var dio = DioService.instance.get();

  HotelServices._();

  static final HotelServices instance = HotelServices._();

  Future<List<Hotel>> fetchHotels() async{
    var response = await dio.get("${APIConfig.baseUrl}home");
    print(response);
    if(response.statusCode == 200){
      return response.data["data"].map<Hotel>((json) => Hotel.fromJson(json)).toList();
    }
    return List<Hotel>.empty(growable: true);

  }

  static Future<List<Hotel>> searchHotels(String key) async{
    var data = {
      "page": 0,
      "text": key
    };
    var response = await dio.post("${APIConfig.baseUrl}home/search", data: data);
    if(response.statusCode == 200){
      print("a");
      return response.data["data"].map<Hotel>((json) => Hotel.fromJson(json)).toList();

    }
    return List<Hotel>.empty(growable: true);
  }

  Future<UserEntity> login(String username, String password) async {
    var data = {
      "username": username,
      "password": password
    };
    var response = await dio.post("${APIConfig.baseUrl}api/auth/login", data: data);
    if(response.statusCode == 200){
      return UserEntity.fromJson(response.data);
    }
    else {
      throw "Can not login";
    }
  }

  Future<BookingHistoryEntity> bookRoom(String roomId, int userId, String startDay, String endDay) async{
    var data = { "user_id": userId, "room_id": roomId, "start_day": formatDate(startDay), "end_day": formatDate(endDay) };
    print(data.toString());
    var response = await dio.post("${APIConfig.baseUrl}booking/add/room", data: data);
    if(response.statusCode == 200){
      return BookingHistoryEntity.fromJson(response.data['data']);
    }
    else {
      throw "Can not book";
    }


  }



  Future<List<BookingHistoryEntity>> getListBooking(int user_id) async{
    var data = {
      "user_id": user_id
    };
    var response = await dio.post("${APIConfig.baseUrl}booking/list/room", data: data);
    if(response.statusCode == 200){
      return response.data["data"].map<BookingHistoryEntity>((json) => BookingHistoryEntity.fromJson(json)).toList();
    }
    else {
      throw "Can get list booking";
    }

  }

  Future<bool> cancelBooking(int reservationID) async{
    var data = {
      "reservation_id": reservationID
    };
    var response = await dio.post("${APIConfig.baseUrl}booking/cancel/room", data: data);
    if(response.statusCode == 200){
      return true;
    }
    else {
      return false;
    }


  }

  Future<Hotel> getHotelById(String id) async{
    var response = await dio.get("${APIConfig.baseUrl}hotel/$id");
    if(response.statusCode == 200){
      return Hotel.fromJson(response.data["data"]);
    }
    else {
      throw "Can get hotel by id";
    }

  }


  Future<List<CommentEntity>> getCommentByHotelId(String hotelId) async {
    var response = await dio.get("${APIConfig.baseUrl}hotel/comment/$hotelId");
    if(response.statusCode == 200){
      print(response);
      return response.data["data"].map<CommentEntity>((json) => CommentEntity.fromJson(json)).toList();
    }
    else {
      throw "Can get comment hotel by id";
    }
  }

  Future<CommentEntity> createComment(int userId, String hotelId,String content) async {
    var data = {
      "user_id": userId,
      "hotel_id": hotelId,
      "title": "Tuyệt vời",
      "content": content
    };
    var response = await dio.post("${APIConfig.baseUrl}hotel/comment/add", data: data);
    if(response.statusCode == 200){
      print(response.data);
      return CommentEntity.fromJson(response.data['data']);
    }
    else {
      throw "Can not comment";
    }

  }

  String formatDate(String date){
    return date.replaceAll("-", "/");
  }



}