import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/security/channels_view.dart';
import 'package:glive/modules/security/fingerprint_view.dart';
import 'package:glive/modules/signup/tabs/email_tab.dart';
import 'package:glive/modules/signup/tabs/password_tab.dart';
import 'package:glive/modules/signup/tabs/userinfo_tab.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/ToastHelper.dart';
import 'package:glive/widgets/AppPasswordInput.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/widgets/AppTextInput.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:glive/widgets/TextWidget.dart';
import 'tabs/interest_tab.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  int counter = 3;
  List list = [0, 1, 2, 3];

  List features = [
    'Verify Account',
    'Create Password',
    'Interest',
    'Account Registration',
  ];

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.gradiants,
            stops: const [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 30.sp,
                        width: 30.sp,
                        decoration: const BoxDecoration(
                            color: Colors.white38, shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    TextWidget(
                      text: features[registrationIndexPage],
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                    const SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: FlutterStepIndicator(
                      height: 28,
                      paddingLine: const EdgeInsets.symmetric(horizontal: 0),
                      positiveColor: const Color(0xFFC30FCC),
                      progressColor: Colors.white,
                      negativeColor: const Color(0xFFD5D5D5),
                      padding: const EdgeInsets.all(4),
                      list: list,
                      division: counter,
                      onChange: (i) {},
                      page: registrationIndexPage,
                      onClickItem: (p0) {
                        setState(() {
                          registrationIndexPage = p0;
                        });
                      },
                    ),
                  ),
                ),
                IndexedStack(
                  index: registrationIndexPage,
                  children: [
                    _emailTab(),
                    _passwordTab(),
                    _interestTab(),
                    const UserInfoTab(),
                    // ChannelsView(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController emailController = TextEditingController();

  bool isVerified = false;

  final _formKey1 = GlobalKey<FormState>();

  Widget _emailTab() {
    return isVerified
        ? verifiedWidget()
        : Form(
            key: _formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.sp,
                ),
                TextWidget(
                  text: 'Sign Up',
                  fontSize: 30.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                TextWidget(
                  text: 'Sign up with your email address',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 50.sp,
                ),
                AppTextInput(
                  width: 350.sp,
                  title: 'Email Address',
                  controller: emailController,
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.sp,
                ),
                ButtonWidget(
                  height: 55,
                  radius: 10,
                  width: 350.sp,
                  label: 'Verify Email',
                  onPressed: () {
                    if (_formKey1.currentState!.validate()) {
                      showVerificationDialog();
                      setState(() {
                        isVerified = true;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: 'Already have an account?',
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(RouteNames.login);
                      },
                      child: TextWidget(
                        text: 'Sign in',
                        fontSize: 14.sp,
                        color: AppColors.bluegreen,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50.sp,
                ),
                TextWidget(
                  text: 'Or sign in using',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: GestureDetector(
                          onTap: () {
                            Get.offNamed(RouteNames.security);
                          },
                          child: Container(
                            width: 55.sp,
                            height: 55.sp,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/${socialMediaImages[i]}.png',
                                height: 30.sp,
                                width: 30.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
  }

  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  Widget verifiedWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.sp,
        ),
        TextWidget(
          text: 'Verify Account',
          fontSize: 30.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 5.sp,
        ),
        TextWidget(
          text: 'Please enter the verification code\nsent to your email',
          fontSize: 12.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 50.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return Container(
              width: 60.sp,
              height: 60.sp,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.30),
                border: Border.all(color: Colors.white, width: 0.30),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                maxLength: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
                onChanged: (value) => _onSubmit(value, index),
              ),
            );
          }),
        ),
        SizedBox(
          height: 20.sp,
        ),
        ButtonWidget(
          height: 55,
          radius: 10,
          width: 350.sp,
          label: 'Verify',
          onPressed: () {
            setState(() {
              registrationIndexPage++;
            });
          },
        ),
      ],
    );
  }

  void _onSubmit(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.length == 1 && index == 5) {
      _focusNodes[index].unfocus();

      // Print all the values from the controllers
      String otp = _controllers.map((controller) => controller.text).join();
      print('Entered OTP: $otp');

      // Perform OTP verification here
    }
  }

  showVerificationDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/email_verification.png',
                  ),
                  SizedBox(
                    height: 25.sp,
                  ),
                  TextWidget(
                    text: '''
Verification Code
has been sent to your email
''',
                    fontSize: 14,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  const SpinKitCircle(
                    color: Color(0xFFC30FCC),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    await Future.delayed(
      const Duration(seconds: 3),
    );

    Navigator.pop(context);
  }

  // Password Tab

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget _passwordTab() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.sp,
              ),
              Center(
                child: TextWidget(
                  text: 'Create Password',
                  fontSize: 30.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Center(
                child: TextWidget(
                  text: 'Create your password',
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50.sp,
              ),
              Center(
                child: AppPasswordInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                        return 'Password must contain at least one letter';
                      }
                      if (!RegExp(r'\d').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }

                      return null;
                    },
                    width: 350.sp,
                    title: "Password",
                    controller: password,
                    icon: Icons.lock),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Center(
                child: AppPasswordInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                        return 'Password must contain at least one letter';
                      }
                      if (!RegExp(r'\d').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }

                      return null;
                    },
                    width: 350.sp,
                    title: "Confirm Password",
                    controller: confirmpassword,
                    icon: Icons.lock),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Center(
                child: ButtonWidget(
                  height: 55,
                  radius: 10,
                  width: 350.sp,
                  label: 'Save Password',
                  onPressed: () {
                    if (password.text == confirmpassword.text) {
                      if (_formKey2.currentState!.validate()) {
                        setState(() {
                          registrationIndexPage++;
                        });
                      }
                    } else {
                      ToastHelper.error('Password do not match!');
                    }
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return Dialog(
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Image.asset(
                    //             'assets/images/hand.png',
                    //             height: 250.sp,
                    //             width: 250.sp,
                    //           ),
                    //           TextWidget(
                    //             text: 'Add a Referral Code?',
                    //             fontSize: 24.sp,
                    //           ),
                    //           SizedBox(
                    //             height: 10.sp,
                    //           ),
                    //           ButtonWidget(
                    //             width: 200,
                    //             radius: 15,
                    //             color: const Color(0XFF0A9AAA),
                    //             label: 'Yes',
                    //             textColor: Colors.white,
                    //             onPressed: () {
                    //               Navigator.pop(context);
                    //               setState(() {
                    //                 registrationIndexPage++;
                    //               });
                    //             },
                    //           ),
                    //           SizedBox(
                    //             height: 20.sp,
                    //           ),
                    //           ButtonWidget(
                    //             width: 200,
                    //             radius: 15,
                    //             color: Colors.white,
                    //             label: 'No',
                    //             onPressed: () {

                    //             },
                    //           ),
                    //           SizedBox(
                    //             height: 20.sp,
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Your password must have:',
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5.sp,
                        ),
                        TextWidget(
                          text: '8 to 20 characters',
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5.sp,
                        ),
                        TextWidget(
                          text: 'Letters, numbers and special characters',
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Interest Tab

  TextEditingController refCode = TextEditingController();

  List interests = [
    'Animals',
    'Comedy',
    'Travel',
    'Food',
    'Sports',
    'Beauty & Style',
    'Art',
    'Gaming',
  ];

  Set<String> selectedInterests = {};

  @override
  Widget _interestTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.sp,
        ),
        TextWidget(
          align: TextAlign.start,
          text: 'Choose your\ninterest',
          fontSize: 30.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 5.sp,
        ),
        TextWidget(
          text: 'Get better video recommendations',
          fontSize: 12.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 50.sp,
        ),
        Wrap(
          children: [
            for (int i = 0; i < interests.length; i++)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedInterests.contains(interests[i])) {
                        selectedInterests.remove(interests[i]);
                      } else {
                        if (selectedInterests.length <= 2) {
                          selectedInterests.add(interests[i]);
                        }
                      }
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 40.sp,
                    decoration: !selectedInterests.contains(interests[i])
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.pink,
                          ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                              'assets/images/interest/${interests[i]}.png'),
                          SizedBox(
                            width: 10.sp,
                          ),
                          TextWidget(
                            text: interests[i],
                            fontSize: 14.sp,
                            color: selectedInterests.contains(interests[i])
                                ? Colors.white
                                : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 180.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  registrationIndexPage++;
                });
              },
              child: Container(
                height: 60.sp,
                width: 175.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.bluegreen,
                  ),
                ),
                child: Center(
                  child: TextWidget(
                    text: 'Skip',
                    fontSize: 16,
                    color: AppColors.bluegreen,
                  ),
                ),
              ),
            ),
            // ButtonWidget(

            //   radius: 10,
            //   width: 175.sp,
            //   textColor: Colors.white,
            //   color: Colors.grey,
            //   label: 'Skip',
            //   onPressed: () {
            //     // // Collect OTP from the controllers and perform verification
            //     // String otp =
            //     //     _controllers.map((controller) => controller.text).join();
            //     // print("Entered OTP: $otp");

            //   },
            // ),
            ButtonWidget(
              width: 175.sp,
              radius: 10,
              textColor: Colors.white,
              color: const Color(0XFF0A9AAA),
              label: 'Continue',
              onPressed: () async {
                // authchack(context);

                setState(() {
                  registrationIndexPage++;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 50.sp,
        ),
      ],
    );
  }
}
