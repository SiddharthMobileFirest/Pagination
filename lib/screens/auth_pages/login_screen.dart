import 'package:bloc_project_using_event/res/assets/image_assets.dart';
import 'package:bloc_project_using_event/res/colors/app_color.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/login_bloc/login_bloc.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/login_bloc/login_event.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/login_bloc/login_state.dart';
import 'package:bloc_project_using_event/screens/auth_pages/sign_up_scren.dart';
import 'package:bloc_project_using_event/screens/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../../res/app_string/app_string.dart';
import '../../utils/utils.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  Utils utils = Utils();
  final box = GetStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    ScreenUtil.init(context, designSize: Size(width, height));
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageAssets.loginScreen), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 0.085.sw, top: 0.16.sh),
              child: const Text(
                AppStrings.headerText,
                style: TextStyle(color: AppColor.whiteColor, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 0.5.sh),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 0.085.sw, right: 0.085.sw),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            style: const TextStyle(color: AppColor.blackColor),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: AppStrings.emailHintText,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 0.037.sh,
                          ),
                          TextField(
                            controller: passwordController,
                            style: const TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: AppStrings.passwordHintText,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 0.047.sh,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  AppStrings.signIn,
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                BlocConsumer<LogInBloc, LogInState>(
                                  listener: (context, state) {
                                    if (state is LogInErrorState) {
                                      utils.showTostMessage(
                                          context: context,
                                          message: state.errorMessage,
                                          isError: true);
                                    } else if (state is LogInDoneState) {
                                      box.write("loged", "True");
                                      utils.showTostMessage(
                                        context: context,
                                        message: "LogIn successfully",
                                      );
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                          (route) => false);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is LogInLoadingState) {
                                      return const CircleAvatar(
                                          radius: 30,
                                          backgroundColor: AppColor.primerColor,
                                          child: CircularProgressIndicator());
                                    }
                                    return CircleAvatar(
                                      radius: 30,
                                      backgroundColor: AppColor.primerColor,
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            BlocProvider.of<LogInBloc>(context)
                                                .add(LogInEvent(
                                                    emailController.text,
                                                    passwordController.text));
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                          )),
                                    );
                                  },
                                )
                              ]),
                          SizedBox(
                            height: 0.048.sh,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScareen(),
                                      ));
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  AppStrings.signUp,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColor.primerColor,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
