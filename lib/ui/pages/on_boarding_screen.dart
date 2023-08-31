import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/on_boarding_controller.dart';
import '../../constants/colors.dart';
import '../widgets/input_field.dart';
import '../../constants/habits_fields.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  final _controller = OnBoardingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _tallController = TextEditingController();
  final _weightController = TextEditingController();
  String selectedHabit = habits[0];
  String selectedField = lifeFields[0];

  late AnimationController animationController;
  late Animation animation;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(period: Duration(seconds: 3));
    // USWE ANIMATON WITH TWEEN AS GENERIC CLASS ...HERE WE SPECIFY THE SIZE AS GENERIC CLASS
    //AND USE BEGIN AND END AS PARAMETERS ACCEPTING ONLY SIZE WIDGET
    animation = Tween<double>(begin: 0.2, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
      reverseCurve: Curves.ease,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _tallController.dispose();
    _weightController.dispose();
    animationController.dispose();
  }

  int page_index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: white,
        onPressed: () {
          //    index, String name, double age, double weight, double tall,
          // String field, String habit
          _controller.forward(
              page_index,
              _nameController.text,
              (_ageController.text),
              (_weightController.text),
              (_tallController.text),
              selectedField,
              selectedField,
              context);
        },
        child: Icon(
          Icons.arrow_forward_ios,
          color: Color.fromRGBO(147, 54, 180, 1),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(64, 18, 139, 1),
          Color.fromRGBO(147, 54, 180, 1)
        ])),
        child: PageView.builder(
            // allowImplicitScrolling: true,
            physics: BouncingScrollPhysics(),
            controller: _controller.pageController,
            onPageChanged: _controller.onPageIndex,
            itemCount: _controller.onBoardingPages.length,
            itemBuilder: (context, index) {
              page_index = index;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.25,
                    ),
                    Text(
                      _controller.onBoardingPages[index].question,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: white),
                    ),
                    SizedBox(height: size.height * 0.01),
                    //TITLE
                    Text(
                      _controller.onBoardingPages[index].description_question,
                      style: TextStyle(color: white),
                    ).paddingOnly(left: 20, right: 20, top: 10, bottom: 10),

                    index != 2
                        ? Container(
                            width: size.width * 0.9,
                            child: Column(
                              children: [
                                Package(
                                  index,
                                  "top",
                                ),
                                Package(
                                  index,
                                  "bottom",
                                )
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Text('Choose habit',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: white_c))
                                    .paddingOnly(top: size.height * 0.05),
                                SelectionForm("top", size, animation)
                                    .paddingOnly(top: size.height * 0.01),
                                Text('Choose field',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: white))
                                    .paddingOnly(top: size.height * 0.03),
                                SelectionForm("bottom", size, animation)
                                    .paddingOnly(top: size.height * 0.01),
                              ],
                            ),
                          ),
                    SizedBox(height: 20),

                    // Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                          _controller.onBoardingPages.length,
                          (index) => Obx(() {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color:
                                          _controller.onPageIndex.value == index
                                              ? Colors.black
                                              : Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                );
                              })),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                  ],
                ),
              );
            }),
      ),
    ));
  }

  Widget Package(
    index,
    type,
  ) {
    if (type == "top")
      return Padding(
        padding: const EdgeInsets.all(5),
        child: InputField2(
          color: white,
          type: index == 0 ? TextInputType.name : TextInputType.number,
          hint: index == 0 ? "Name" : "Tall",
          title: index == 0 ? "Your name" : "Your tall",
          controller: index == 0
              ? _nameController
              : index == 1
                  ? _tallController
                  : null,
        ),
      );

    //else means type is the bottom form
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InputField2(
        color: white,
        type: TextInputType.number,
        hint: index == 0 ? "Age" : "Weight",
        title: index == 0 ? "Your age" : "Your weight",
        controller: index == 0
            ? _ageController
            : index == 1
                ? _weightController
                : null,
      ),
    );
  }

  Widget SelectionForm(type, size, animation) {
    if (type == "top")
      return FadeTransition(
        opacity: animation,
        child: Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
              border: Border.all(color: white, width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(20),
              padding: EdgeInsets.all(5),
              // dropdownColor: pinkClr,
              icon: Icon(
                Icons.add_chart,
                color: white,
              ),
              value: selectedHabit,
              onChanged: (newValue) {
                setState(() {
                  selectedHabit = newValue!;
                });
              },
              items: habits.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    return FadeTransition(
      opacity: animation,
      child: Container(
        width: size.width * 0.6,
        decoration: BoxDecoration(
            border: Border.all(color: white, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedField,
            padding: EdgeInsets.all(5),
            icon: Icon(
              Icons.science,
              color: white,
            ),
            onChanged: (newValue) {
              setState(() {
                selectedField = newValue!;
              });
            },
            items: lifeFields.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
