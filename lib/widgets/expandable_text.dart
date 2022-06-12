import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_e_com/colors.dart';
import 'package:my_e_com/utils/dimensions.dart';
import 'package:my_e_com/widgets/small_text.dart';

class ExpendableText extends StatefulWidget {
  final String text;

  const ExpendableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpendableText> createState() => _ExpendableTextState();
}

class _ExpendableTextState extends State<ExpendableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              color: AppColors.paraColor,
              size: Dimensions.font16,
              height: 1.8,
            )
          : Column(
              children: [
                SmallText(
                    color: AppColors.paraColor,
                    size: Dimensions.font16,
                    height: 1.8,
                    text: hiddenText
                        ? ('$firstHalf...')
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: 'Show more',
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
