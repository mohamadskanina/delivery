import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'food_page_body.dart';

class MainFoodpage extends StatefulWidget {
  const MainFoodpage({super.key});

  @override
  State<MainFoodpage> createState() => _MainFoodpageState();
}

class _MainFoodpageState extends State<MainFoodpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 45, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: "Bangladesh",
                        color: Color.fromARGB(122, 63, 129, 129),
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: "Narsingdi",
                            color: Colors.black54,
                          ),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      child: Icon(Icons.search, color: Colors.white),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFF89dad0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          FoodPageBody(),
        ],
      ),
    );
  }
}
