import 'package:flutter/material.dart';
import 'package:tpbooking/models/hotel_entity.dart';
import 'package:tpbooking/screens/hotel/hotel_screen.dart';

class HotelItem extends StatelessWidget {
  final Hotel hotel;
  final String imageUrl;
  final String name;
  final String address;
  final double score;
  const HotelItem({
    Key? key,
    required this.name,
    required this.address,
    required this.score,
    required this.imageUrl,
    required this.hotel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelDetail(hotel: hotel),
            ));
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(imageUrl)),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow),
                height: 200,
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Text(
                            address,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(score.toString()),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
