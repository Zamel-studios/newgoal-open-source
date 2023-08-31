import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/validations.dart'; 
import '../../constants/colors.dart';
import '../../controllers/login_page_controller.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class Login extends StatelessWidget {
  // Login({ });

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    LoginController login_controller = Get.find();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                Center(
                  child: Image.asset(
                    "images/new_me_logo.png",
                    width: size.width * 0.6,
                    fit: BoxFit.cover,
                    height: size.height * 0.2,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  "1".tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ).paddingOnly(left: 30, right: 30),
                CustomTextFormField(
                        isPassword: false,
                        controller: _emailController,
                        hint: "2".tr,
                        valid: (valid) {
                          return validateInput(valid!, 10, 50, "email");
                        },
                        type: TextInputType.emailAddress,
                        color: email_field_color)
                    .paddingOnly(left: 20, top: 30, right: 20, bottom: 10),
                CustomTextFormField(
                  hint: '3'.tr,
                  isPassword: true,
                  controller: _passwordController,
                  type: TextInputType.emailAddress,
                  color: email_field_color,
                  valid: (valid) {
                    return validateInput(valid!, 8, 20, "password");
                  },
                ).paddingOnly(left: 20, right: 20, bottom: 10, top: 0),
                Container(
                  width: size.width,
                  // height: s,
                  child: MyButton(
                    // size: size,
                    label: "Login",

                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        login_controller.onSubmitLogin(
                            _emailController.text, _passwordController.text);
                      }
                    },
                    // color: green_c
                  ).paddingOnly(left: 20, right: 20, bottom: 10, top: 10),
                ),
                TextButton(
                  onPressed: () async => Get.toNamed("/signup"),
                  child: Text(
                    "6".tr,
                    style: TextStyle(
                        color: pupple_c,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ).paddingOnly(left: 20, top: 20, right: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
