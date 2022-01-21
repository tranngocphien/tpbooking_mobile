import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpbooking/screens/history_booking/history_booking_controller.dart';
import 'package:tpbooking/screens/history_booking/history_booking_screen.dart';
import 'package:tpbooking/screens/home/home_controller.dart';
import 'package:tpbooking/screens/list_hotel/list_hotel.dart';
import 'package:tpbooking/screens/login/login.dart';
import 'package:tpbooking/screens/login/login_controller.dart';

import 'components/hotel_list_item.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    LoginController loginController = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFF6F7FF),
        iconTheme: const IconThemeData(color: Colors.green),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welome to tpbooking",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF18b57e)),
            ),
            Text(
              "Chọn khách sạn đi nào",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.3)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: const Color(0x55434343),
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Tìm kiếm khách sạn, địa điểm...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (value){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListHotelScreen(searchKey: value)),);
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Khách sạn hàng đầu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Obx(
              () => homeController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView(
                          children: homeController.listHotel
                              .map((element) => HotelItem(
                                    name: element.name,
                                    address: element.address,
                                    score: element.score,
                                    imageUrl: "https://" + element.imgs[0],
                                    hotel: element,
                                  ))
                              .toList()),
                    ),
            ),
            // GetX<HomeController>(builder: (controller) {
            //   return Expanded(
            //     child: ListView(
            //         children: controller.listHotel
            //             .map((element) => HotelItem(
            //                   name: element.name,
            //                   address: element.address,
            //                   score: element.score,
            //                   imageUrl: "https://" + element.imgs[0],
            //                   hotel: element,
            //                 ))
            //             .toList()),
            //   );
            // }),
          ],
        ),
      ),
      drawer: Drawer(
        child: Obx(() => ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(

                ),
                child: Image.asset('assets/images/TPBOOKING.png')),
            ListTile(
              title: const Text("Lịch sử đặt phòng"),
              onTap: (){
                if(loginController.isLogin.value){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingHistrory()),);
                }
                else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                }

              },
            ),
            loginController.isLogin.value ? Container(): ListTile(
                title: const Text("Đăng nhập"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
                }
            ),
            loginController.isLogin.value ? ListTile(
              title: const Text("Đăng xuất"),
              onTap: (){
                LoginController loginController = Get.find();
                loginController.user.value = null;
                loginController.isLogin.value = false;
                HistoryBookingController historyBooking = Get.find();
                historyBooking.listBooking.clear();

              },
            ): Container()
          ],
        )),
      ),
    );
  }
}

class Places extends StatelessWidget {
  const Places({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://file3.qdnd.vn/data/images/0/2021/10/06/vuongthuy/15092021vthuy556.jpg?dpi=150&quality=100&w=870"),
            radius: 40,
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://file3.qdnd.vn/data/images/0/2021/10/06/vuongthuy/15092021vthuy556.jpg?dpi=150&quality=100&w=870"),
            radius: 40,
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://file3.qdnd.vn/data/images/0/2021/10/06/vuongthuy/15092021vthuy556.jpg?dpi=150&quality=100&w=870"),
            radius: 40,
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://file3.qdnd.vn/data/images/0/2021/10/06/vuongthuy/15092021vthuy556.jpg?dpi=150&quality=100&w=870"),
            radius: 40,
          )
        ],
      ),
    );
  }
}
