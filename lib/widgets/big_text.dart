import 'package:flutter/cupertino.dart';
import 'package:my_e_com/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  TextOverflow overflow;

  BigText(
      {Key? key,
      required this.text,
      this.color = const Color(0xff332d2d),
      this.size = 0,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: size == 0 ? Dimensions.font20 : size),
    );
  }
}
