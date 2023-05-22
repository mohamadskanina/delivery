import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({
    super.key,
    this.color = const Color(0xFF332d2b),
    this.size = 0,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.font20 - 2 : size,
          fontFamily: 'Amiri',
          fontWeight: FontWeight.w400),
    );
  }
}
