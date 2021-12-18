import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:tpbooking/models/hotel_entity.dart';
import 'package:tpbooking/models/room_entity.dart';

class HotelDetail extends StatelessWidget {
  final Hotel hotel;
  const HotelDetail({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageHotel(imgs: hotel.imgs,),
              BaseInformation(hotel: hotel),
              Score(hotel: hotel),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Danh sách phòng",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      )),
                    SizedBox(height: 8,),
                    Column(
                      children: hotel.rooms.map((e) => Room(room: e)).toList(),
                    )
                  ],
                ),
              )
            ],

          ),
        ),
      ),

    );
  }
}

class Room extends StatelessWidget {
  final RoomEntity room;
  const Room({
    Key? key, required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://${room.imgs[0]}"))),

          ),
          SizedBox(width: 4,),
          Container(
            width: size.width - 140 - 16- 16 - 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(room.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: room.benefit.map((e) => Text(e)).toList(),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${room.adults} người lớn"),
                        Text("${room.children} trẻ nhỏ")
                      ],
                    ),
                    Text(room.cost.toString())
                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}

class Score extends StatelessWidget {
  const Score({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Đánh giá tống thể",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Text(hotel.score.toString(),
                        style: const TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  Text("${hotel.scoreCount} đánh giá"),

                ],
              ),

              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text("Độ sạch sẽ"),
                      ),
                      Container(
                        width: 50,
                        child: Text(hotel.scoreClean.toString()),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text("Vị trí"),
                      ),
                      Container(
                        width: 50,
                        child: Text(hotel.scoreClean.toString()),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text("Dịch vụ"),
                      ),
                      Container(
                        width: 50,
                        child: Text(hotel.scoreClean.toString()),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text("Tiện nghi"),
                      ),
                      Container(
                        width: 50,
                        child: Text(hotel.scoreClean.toString()),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text("Đáng giá tiền"),
                      ),
                      Container(
                        width: 50,
                        child: Text(hotel.scoreClean.toString()),
                      )
                    ],
                  )
                ]
              )

            ],
          )

        ],
      ),

    );
  }
}

class BaseInformation extends StatelessWidget {
  const BaseInformation({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hotel.name,
            style: TextStyle(
              fontSize: 20
            ),
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(hotel.address)
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(hotel.score.toString()),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    ],
                  ))

            ],
          ),
          Divider(thickness: 1,)

        ],
      ),
    );
  }
}

class ImageHotel extends StatelessWidget {
  final List<String> imgs;
  const ImageHotel({
    Key? key, required this.imgs
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity ,
      child: ImageSlideshow(children: imgs.map((e) => Image.network("https://${e}")).toList()),
    );
  }
}
