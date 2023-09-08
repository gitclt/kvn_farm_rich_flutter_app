
import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class AttendanceDatePicker extends StatelessWidget {
  final String date;
  final Function? changeDate;
  final Function increment;
  final Function decrement;
  const AttendanceDatePicker(
      {super.key,
      required this.date,
      this.changeDate,
      required this.increment,
      required this.decrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 241, 235, 235),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            onPressed: () {
              decrement();
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: dateArrowColor,
          ),
          TextButton(
            onPressed: changeDate == null
                ? null
                : () {
                    changeDate!();
                  },
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 17, color: redColor),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              increment();
            },
            icon: const Icon(Icons.arrow_forward_ios),
            color: dateArrowColor,
          )
        ]),
      ),
    );
  }
}
