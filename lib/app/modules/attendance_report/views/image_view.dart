import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class CustomImageAlertBox extends StatelessWidget {
  final String image;
  const CustomImageAlertBox({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetAnimationCurve: Curves.linear,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Colors.transparent,
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            //  height: 500,
            child: ListView.builder(
                itemCount: image.split(',').length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Image.network(
                    image.split(',')[i],
                    fit: BoxFit.contain,
                    errorBuilder: (context, exception, stackTrack) => Column(
                      children: [
                        const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        blackText('Sorry! Image not found', 15,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  );
                }),
          ),
          Positioned(
            top: -40,
            right: -10,
            child: SizedBox(
              //  width: 280,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).paddingOnly(top: MediaQuery.sizeOf(context).height * 0.05);
  }
}
