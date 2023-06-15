import 'package:bloc_project_using_event/res/assets/image_assets.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:bloc_project_using_event/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../../res/app_string/app_string.dart';
import '../../res/colors/app_color.dart';
import '../../widgets/my_textfield.dart';
import 'login_screen.dart';

class SignUpScareen extends StatefulWidget {
  const SignUpScareen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScareenState createState() => _SignUpScareenState();
}

class _SignUpScareenState extends State<SignUpScareen> {
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty
        ? !regex.hasMatch(value)
            ? AppStrings.emailValidatorError
            : null
        : AppStrings.emailValidatorNullError;
  }

  Utils utils = Utils();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    ScreenUtil.init(context, designSize: Size(width, height));
    return Form(
      key: _key,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageAssets.signUpScreen), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 0.080.sw, top: 0.11.sw).r,
                child: Text(
                  AppStrings.createAccount,
                  style: TextStyle(color: Colors.white, fontSize: 33.sp),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 0.28.sh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 0.080.sw, right: 0.080.sw).r,
                        child: Column(
                          children: [
                            MyTextField(
                              validator: (value) {
                                if (value == "" || value!.isEmpty) {
                                  return AppStrings.nameValidatorError;
                                }
                                return null;
                              },
                              controller: nameController,
                              hint: AppStrings.nameHintText,
                            ),
                            SizedBox(
                              height: 0.037.sh,
                            ),
                            MyTextField(
                              validator: (value) => validateEmail(value),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              hint: AppStrings.emailHintText,
                            ),
                            SizedBox(
                              height: 0.037.sh,
                            ),
                            MyTextField(
                              validator: (value) {
                                if (value == "" || value!.isEmpty) {
                                  return AppStrings.passwordValidatorError;
                                }
                                return null;
                              },
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              hint: AppStrings.passwordHintText,
                            ),
                            SizedBox(
                              height: 0.050.sh,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  AppStrings.signUp,
                                  style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                BlocConsumer<SignUpBloc, SignUpState>(
                                  listener: (context, state) {
                                    if (state is SignUpErrorState) {
                                      utils.showTostMessage(
                                          context: context,
                                          message: state.errorMessage,
                                          isError: true);
                                    } else if (state is SignUpSignUpDoneState) {
                                      utils.showTostMessage(
                                        context: context,
                                        message: "Register successfully",
                                      );
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const MyLogin(),
                                          ),
                                          (route) => false);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is SignUpLoadingState) {
                                      return const CircleAvatar(
                                          radius: 30,
                                          backgroundColor: AppColor.primerColor,
                                          child: CircularProgressIndicator());
                                    }
                                    return CircleAvatar(
                                        radius: 30,
                                        backgroundColor: AppColor.primerColor,
                                        child: IconButton(
                                            color: AppColor.whiteColor,
                                            onPressed: () {
                                              if (_key.currentState!
                                                  .validate()) {
                                                BlocProvider.of<SignUpBloc>(
                                                        context)
                                                    .add(SignUpEvent(
                                                        emailController.text,
                                                        passwordController
                                                            .text));
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward,
                                            )));
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 0.03.sh,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const MyLogin(),
                                        ));
                                  },
                                  style: const ButtonStyle(),
                                  child: const Text(
                                    AppStrings.signIn,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppColor.whiteColor,
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
      ),
    );
  }
}
