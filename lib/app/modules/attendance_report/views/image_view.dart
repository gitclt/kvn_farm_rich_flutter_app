import 'package:flutter/material.dart';

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
            height: 500,
            child: ListView.builder(
                itemCount: image.split(',').length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Image.network(image.split(',')[i]);
                }),
          ),
          Positioned(
            top: -50,
            right: 0,
            child: SizedBox(
              width: 280,
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
    );
  }
}
