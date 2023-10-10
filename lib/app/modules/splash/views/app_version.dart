import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/modules/splash/controllers/splash_controller.dart';

class AppVersionCheckView extends GetView<SplashController> {
  const AppVersionCheckView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Image.asset(
                "assets/logo/impex_logo.png",
                width: size.width / 2,
              ),
            ),
            SizedBox(
              height: size.height / 6,
            ),
            headerText("New Version Available"),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: size.width / 3,
              child: CommonButtonWidget(
                label: "Update Now",
                onClick: () {
                  controller.checkForUpdate();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Text headerText(String label) {
  return Text(label,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15));
}
