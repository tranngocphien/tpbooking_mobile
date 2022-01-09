import 'package:get/get.dart';
import 'package:tpbooking/screens/history_booking/history_booking_controller.dart';
import 'package:tpbooking/services/hotel_service.dart';

class BookingController extends GetxController {
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;
  final _hotelService = HotelServices.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> bookRoom(String idRoom, int userId) async{
    _hotelService.bookRoom(idRoom, userId, startDate.toString(), endDate.toString());
    HistoryBookingController historyBookingController = Get.find();
    await historyBookingController.getListBooking();

  }


}