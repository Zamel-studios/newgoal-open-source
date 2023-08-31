import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui/theme.dart';

import '../../constants/colors.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final Widget? widget;

  const InputField({
    required this.title,
    this.controller,
    required this.hint,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleTextStle,
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 14.0),
              height: 52,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: false,
                      cursorColor:
                          Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
                      readOnly: widget == null ? false : true,
                      controller: controller,
                      style: subTitleTextStle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: subTitleTextStle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                        // enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: context.theme.backgroundColor,
                        //     width: 0,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  widget == null ? Container() : widget!,
                ],
              ),
            )
          ],
        ));
  }
}

class InputField2 extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final Widget? widget;
  final TextInputType type;
  final Color color;
  const InputField2(
      {required this.title,
      this.controller,
      required this.hint,
      this.widget,
      required this.type,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 19),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 14.0),
              height: 52,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: color,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: type,
                      autofocus: false,
                      cursorColor: Color.fromARGB(255, 255, 255, 255),
                      readOnly: widget == null ? false : true,
                      controller: controller,
                      style:
                          TextStyle(color: Color.fromARGB(255, 240, 239, 239)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: subTitleTextStle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                        // enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: context.theme.backgroundColor,
                        //     width: 0,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  widget == null ? Container() : widget!,
                ],
              ),
            )
          ],
        ));
  }
}

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextInputType type;
  final Color color;
  final TextEditingController controller;
  final String? Function(String?) valid;
  final bool isPassword;

  const CustomTextFormField({
    Key,
    required this.hint,
    required this.type,
    required this.color,
    required this.controller,
    required this.valid,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      width: context.width,
      height: context.height * 0.07,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        obscureText: isPassword,
        validator: valid,
        keyboardType: type,
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        // keyboardType: type,
        decoration: InputDecoration(
            suffixIcon: isPassword == true
                ? InkWell(
                    child: Icon(Icons.lock),
                    onTap: () {
                      isPassword == false;
                    },
                  )
                : SizedBox(),
            contentPadding: const EdgeInsets.all(15),
            border: InputBorder.none,
            hintText: hint,
            hintStyle:
                TextStyle(color: hint_text_color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
