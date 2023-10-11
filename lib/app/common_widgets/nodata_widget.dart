import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String? lable;
  const NoDataWidget({Key? key, this.lable = 'No Data Found'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lottie.asset(
          //   'assets/svg/nodata.json',
          //   width: 200,
          //   height: 200,
          //         fit: BoxFit.fill,
          // ),
          Image.asset(
            'assets/image/no_data.gif',
            width: MediaQuery.of(context).size.width * .5,
            height: MediaQuery.of(context).size.width * .5,
          ),
          Text(
            lable!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Sorry, we couldn't find your data's yet",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
