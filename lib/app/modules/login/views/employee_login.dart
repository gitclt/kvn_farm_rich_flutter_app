import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/logintextfeild.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/login_text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

import '../controllers/login_controller.dart';

// class EmployeeLoginView extends GetView<LoginController> {
//   const EmployeeLoginView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: SingleChildScrollView(
//           child: Container(
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width,
//               maxHeight: MediaQuery.of(context).size.height,
//             ),
//             decoration: const BoxDecoration(gradient: primaryColor),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Center(
//                             child: SizedBox(
//                                 child:
//                                     Image.asset("assets/logo/kvn_logo.png"))),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(
//                         bottom:
//                             MediaQuery.of(context).viewInsets.bottom * 0.10),
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(32),
//                         topRight: Radius.circular(32),
//                       ),
//                       color: scaffoldBgColor,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.04,
//                           ),
//                           const LoginText(
//                             text: "Employee Login",
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.04,
//                           ),
//                           LoginTextField(
//                             hintText: 'Enter your Phone Number',
//                             prefixIcon: Padding(
//                               padding: const EdgeInsets.all(15),
//                               child: svgWidget(
//                                 'assets/svg/Call.svg',
//                               ),
//                             ),
//                             // suffixIcon: SvgPicture.asset('assets/svg/call.svg')
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.04,
//                           ),
//                           CommonButtonWidget(
//                             label: "GET OTP",
//                             onClick: () {
//                               Get.toNamed(Routes.OTP);
//                             },
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.04,
//                           ),

//                           // )
//                         ],
//                       ),
//                     ),
//                   )
//                 ]),
//           ),
//         ));
//   }
// }

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height,
              ),
              decoration: const BoxDecoration(gradient: primaryColor),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Center(
                                child: Image.asset("assets/logo/kvn_logo.png")),
                          ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom * 0.15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            const LoginText(
                              text: "Employee Login",
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            LoginTextField(
                              keytype: TextInputType.number,
                              hintText: 'Mobile Number',
                              textEditingController:
                                  controller.userNameController,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(15),
                                child: svgWidget(
                                  'assets/svg/Call.svg',
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Your Mobile number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Obx(
                              () => LoginTextField(
                                  keytype: TextInputType.text,
                                  obscureText: controller.isObscureText.value,
                                  hintText: 'Password',
                                  textEditingController:
                                      controller.passWordController,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: svgWidget(
                                      'assets/svg/LockClosed.svg',
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Your Password';
                                    }
                                    return null;
                                  },
                                  suffixIcon: controller.isObscureText.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  suffixIconClick: () {
                                    controller.isObscureText.value =
                                        !controller.isObscureText.value;
                                  }),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                            Obx(() => CommonButtonWidget(
                                  label: "LOGIN",
                                  isLoading: controller.isLoading.value,
                                  onClick: () {
                                    FocusScope.of(context).unfocus();
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.login();
                                    }
                                  },
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }
}
