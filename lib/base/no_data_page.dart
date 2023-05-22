import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgpath;
  const NoDataPage({Key? key,required this.text,this.imgpath="assets/image/empty-cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgpath,
          height: MediaQuery.of(context).size.height*0.22,
          width: MediaQuery.of(context).size.height*0.22,
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Text(
            text,
            style:TextStyle(
                fontSize:MediaQuery.of(context).size.height*0.0275,
                color: Theme.of(context).shadowColor),
                textAlign: TextAlign.center,


        ),
      ],
    );
  }
}
