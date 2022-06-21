import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_e_com/screen/auth/sign_up_page.dart';

import '../../colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            Container(
              height: Dimensions.screenHeight * 0.20,
              child: Center(
                child: Image.asset(
                      "assets/images/logo.png",
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height30,
            ),

            /// hello text
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Hello",
                  style: TextStyle(fontSize: Dimensions.font20 * 3 + Dimensions.font20 / 2, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Welcome to the app",
                  style: TextStyle(fontSize: Dimensions.font20, color: Colors.grey[500]),
                ),
              ]),
            ),

            /// name
            SizedBox(
              height: Dimensions.height30,
            ),
            AppTextField(textEditingController: nameController, hintText: "Name", icon: Icons.person),

            /// password
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(textEditingController: passwordController, hintText: "Password", icon: Icons.lock),
            SizedBox(
              height: Dimensions.height20,
            ),

            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.only(right: Dimensions.width30),
                  child: RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                        text: "Sign into your account",
                        style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font20)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.height20 * 2,
            ),

            /// Sign in button
            Container(
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenHeight / 13,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius30), color: AppColors.mainColor),
              child: Center(
                  child: BigText(
                text: "Sign In",
                size: Dimensions.font20 + Dimensions.font20 / 2,
                color: Colors.white,
              )),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            RichText(
              text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>{
                      Get.to(SignUpPage())
                    },
                    text: "Create",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.font20
                    )
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
