import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/small_text.dart';

class Icon2AndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconcolor;
  const Icon2AndTextWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconcolor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconcolor, size: Dimensions.iconSize13),
        SizedBox(
          width: 4,
        ),
        SmallText(
          text: text,
        ),
      ],
    );
  }
}
