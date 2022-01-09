import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpbooking/models/user_entity.dart';
import 'package:tpbooking/screens/history_booking/history_booking_controller.dart';
import 'package:tpbooking/services/hotel_service.dart';

class LoginController extends GetxController{
  final user = Rx<UserEntity?>(null);
  final _hotelService = HotelServices.instance;
  final isLogin = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> login(String username, String password) async{
    user.value = await _hotelService.login(username, password);
    if(user.value != null){
      final prefs = await SharedPreferences.getInstance();
      // set value
      prefs.setInt('userId', user.value!.id );
      isLogin.value = true;
    }
    HistoryBookingController historyBookingController = Get.put(HistoryBookingController());
  }

}