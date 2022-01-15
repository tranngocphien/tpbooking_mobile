import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpbooking/models/comment_entity.dart';
import 'package:tpbooking/services/hotel_service.dart';

class HotelCommentController extends GetxController {
  final String hotelId;
  final List<CommentEntity> comments = List<CommentEntity>.empty().obs;
  final hotelService = HotelServices.instance;

  HotelCommentController(this.hotelId);

  @override
  void onInit() async {
    // TODO: implement onInit
    await getComments(hotelId);
    super.onInit();
  }

  Future<void> getComments(String hotelId) async{
    comments.clear();
    comments.addAll(await hotelService.getCommentByHotelId(hotelId) );
  }

  Future<void> addComments(String content) async{
    final prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('userId') ?? 0;

    CommentEntity commentEntity = await hotelService.createComment(userId, hotelId, content);
    comments.add(commentEntity);


  }


}