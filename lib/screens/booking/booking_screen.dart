import 'package:flutter/material.dart';
import 'package:tpbooking/models/room_entity.dart';
import 'package:tpbooking/screens/booking/booking_controller.dart';
import 'package:tpbooking/screens/home/home_screen.dart';
import 'package:tpbooking/screens/login/login.dart';
import 'package:tpbooking/screens/login/login_controller.dart';
import 'package:tpbooking/screens/room/room_screen.dart';
import 'package:get/get.dart';
import 'package:tpbooking/utils/utils.dart';

class BookingScreen extends StatefulWidget {
  final RoomEntity roomEntity;
  const BookingScreen({required this.roomEntity, Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  final bookingController = Get.put(BookingController());

  _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null){
      bookingController.startDate.value = picked;
    }
  }
  _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null){
      bookingController.endDate.value = picked;

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(8),
            child: const Text(
          "ĐẶT PHÒNG",
          style: TextStyle(color: Color(0xFF18b57e), fontSize: 24),
        )),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);

        }, icon: const Icon(Icons.arrow_back, color: Color(0xFF18b57e),)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            ImageRoom(imgs: widget.roomEntity.imgs),
            const SizedBox(height: 16,),
            Text(
              widget.roomEntity.name,
              style: const TextStyle(color: Color(0xFF008a6c),
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16,),
            Text(
              '${widget.roomEntity.cost} đ',
              style: const TextStyle(color: Color(0xFFe33505),
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16,),
            const Divider(thickness: 1,),
            const Text(
              'Thời gian',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateTimeConverter.convertDateTime(bookingController.startDate.value), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                const SizedBox(width: 8,),
                InkWell(
                  onTap: (){
                    _selectStartDate(context);

                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Color(0xFF18b57e),
                        borderRadius: BorderRadius.all(Radius.circular(8))

                    ),
                    child: const Text("Chọn ngày bắt đầu"),
                  ),
                )
              ],
            ),),
            const SizedBox(height: 16,),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateTimeConverter.convertDateTime(bookingController.endDate.value), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                const SizedBox(width: 8,),
                InkWell(
                  onTap: (){
                    _selectEndDate(context);

                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Color(0xFF18b57e),
                        borderRadius: BorderRadius.all(Radius.circular(8))

                    ),
                    child: const Text("Chọn ngày kết thúc"),
                  ),
                )
              ],
            ),),
            const Divider(thickness: 1,),
            const SizedBox(height: 16,),
            InkWell(
              onTap: (){
                LoginController loginController = Get.find();
                if(loginController.isLogin.value){
                  bookingController.bookRoom(widget.roomEntity.id, loginController.user.value!.id);
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              Text('Đặt phòng thành công', style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePageScreen()), (route) => false);
                            },
                          ),
                        ],
                      );
                    },
                  );

                }
                else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                }

              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Color(0xFFed5c59),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Center(
                    child: Text(
                      'Đặt phòng',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
