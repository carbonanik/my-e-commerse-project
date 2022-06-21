import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_e_com/base/show_custom_snack_bar.dart';
import 'package:my_e_com/colors.dart';
import 'package:my_e_com/controller/auth_controllde.dart';
import 'package:my_e_com/model/signup_body_model.dart';
import 'package:my_e_com/utils/dimensions.dart';
import 'package:my_e_com/widgets/app_text_field.dart';
import 'package:my_e_com/widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _registration(){
    var authController = Get.find<AuthController>();
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if(name.isEmpty){
      showCustomSnackBar("Type in your name", title: "Name");
    } else if (email.isEmpty){
      showCustomSnackBar("Type in your email", title: "Email");
    } else if (!GetUtils.isEmail(email)){
      showCustomSnackBar("Type in a valid email", title: "Email");
    } else if(phone.isEmpty){
      showCustomSnackBar("Type in your phone number", title: "Phone Number");
    } else if(password.isEmpty){
      showCustomSnackBar("Type in your password", title: "Password");
    } else if(password.length < 6){
      showCustomSnackBar("Password cant be less than six character", title: "Password");
    } else {
      showCustomSnackBar("All went well", title: "Perfect");
      SignUpBody signUpBody = SignUpBody(name: name,
          email: email,
          phone: phone,
          password: password);

      authController.registration(signUpBody).then((status) {
        if(status.isSuccess){

        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            Container(
              height: Dimensions.screenHeight * 0.20,
              child: Image.asset("assets/images/logo.png")
            ),

            /// name
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(textEditingController: nameController, hintText: "Name", icon: Icons.person),

            /// email
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(textEditingController: emailController, hintText: "Email", icon: Icons.email),

            /// phone
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(textEditingController: phoneController, hintText: "Phone", icon: Icons.phone),

            /// password
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(textEditingController: passwordController, hintText: "Password", icon: Icons.lock),
            SizedBox(
              height: Dimensions.height20 * 2,
            ),
            GestureDetector(
              onTap: (){
                _registration();
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius30), color: AppColors.mainColor),
                child: Center(
                    child: BigText(
                  text: "Sign Up",
                  size: Dimensions.font20 + Dimensions.font20 / 2,
                  color: Colors.white,
                )),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: "Have an account already?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20
                )
              ),
            ),
            SizedBox(height: Dimensions.screenHeight * 0.05,),
            RichText(text: TextSpan(
              text: "Sign up using one of the following method",
              style: TextStyle(
                color: Colors.grey[500],

              )
            ))
          ],
        ),
      ),
    );

  }


}
