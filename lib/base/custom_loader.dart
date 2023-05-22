import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height20 * 5,
        width: Dimensions.width20 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20 * 5 / 2),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 213, 178, 143),
        ),
      ),
    );
  }
}
