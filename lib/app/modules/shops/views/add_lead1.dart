import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/common_textfield.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/dropdown_textfield.dart';
import 'package:kvn_farm_rich/app/modules/shops/controllers/shops_controller.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class AddLeads1 extends GetView<ShopsController> {
  const AddLeads1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizedBox(height: MediaQuery.of(context).size.height * 0.02);
    return Scaffold(
      appBar: const CommonAppBar(label: 'Add Leads'),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeaderWidget(
                      number: "1",
                      color: Color(0xffD80005),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.red.withOpacity(0.3),
                      thickness: 2,
                    )),
                    HeaderWidget(
                        number: "2",
                        color: const Color(0xffD80005).withOpacity(0.3)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextFeild(
                  readonly: true,
                  hintText: 'Date',
                  labelText: 'Select Date',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Select Date';
                    }
                    return null;
                  },
                  textEditingController: controller.datecontroller,
                  onTap: () async {
                    controller.invoiceDate.value = "";
                    FocusManager.instance.primaryFocus?.unfocus();
                    return showModalBottomSheet(
                        context: context,
                        backgroundColor: Get.isDarkMode
                            ? const Color(0xff1F1F1F)
                            : Colors.white,
                        elevation: 10.0,
                        isDismissible: true,
                        shape: bootomSheetShapeType2(),
                        builder: (BuildContext context) {
                          return SizedBox(
                            child: TableCalendar(
                                shouldFillViewport: true,
                                calendarStyle: const CalendarStyle(
                                    selectedTextStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    todayTextStyle: TextStyle(
                                      color: redColor,
                                    ),
                                    selectedDecoration: BoxDecoration(
                                        color: redColor,
                                        shape: BoxShape.circle)),
                                daysOfWeekVisible: true,
                                daysOfWeekHeight: 40,
                                headerStyle: const HeaderStyle(
                                  leftChevronVisible: true,
                                  rightChevronVisible: true,
                                  titleTextStyle: TextStyle(
                                      color: redColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  titleCentered: true,
                                  formatButtonVisible: false,
                                ),
                                onDaySelected: (date, focusday) {
                                  controller.invoiceDate.value =
                                      DateFormat("yyyy-MM-dd").format(date);
                                  controller.invDate =
                                      controller.invoiceDate.toString();
                                  controller.selectfrom = focusday;
                                  controller.datecontroller.text =
                                      controller.invDate;
                                  Get.back();
                                },
                                selectedDayPredicate: (day) =>
                                    isSameDay(day, controller.selectfrom),
                                firstDay: DateTime.utc(2010, 10, 16),
                                lastDay: DateTime.utc(2030, 3, 14),
                                focusedDay: controller.invoiceDate.value == ""
                                    ? DateTime.now()
                                    : DateTime.parse(
                                        controller.selectfrom.toString())),
                          );
                        });
                  },
                  suffixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: redColor,
                  ),
                ),
                size,
                DrowpDownButton(
                  hintText: 'Select Branch',
                  label: 'Select Branch',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    controller.branchoptioncontroller.text = value.toString();
                  },
                  iteams: controller.branchTypes
                      .map((label) => DropdownMenuItem(
                            value: label.id.toString(),
                            child: Text(label.name),
                          ))
                      .toList(),
                ),
                size,
                DrowpDownButton(
                  hintText: 'Lead Source',
                  label: 'Lead Source',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    controller.leadsourcecontroller.text = value.toString();
                  },
                  iteams: controller.sourceoption
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label.toString()),
                          ))
                      .toList(),
                ),
                size,
                CommonTextFeild(
                  readonly: true,
                  hintText: 'State',
                  labelText: 'Select State',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Select State';
                    }
                    return null;
                  },
                  textEditingController: controller.statecontroller,
                  onTap: () async {
                    controller.locationcontroller.clear();
                    final state = await Get.toNamed(Routes.STATE);
                    if (state != null) {
                      controller.statecontroller.text = state.name;
                      controller.stateid = state.id.toString();
                    }
                  },
                  suffixIcon: const Icon(
                    Icons.expand_more_outlined,
                    size: 25,
                    color: redColor,
                  ),
                ),
                size,
                CommonTextFeild(
                  readonly: true,
                  hintText: 'Place',
                  labelText: 'Select Place',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Select Place';
                    }
                    return null;
                  },
                  textEditingController: controller.locationcontroller,
                  onTap: () async {
                    final place = await Get.toNamed(Routes.PLACE,
                        arguments: controller.stateid.toString());
                    if (place != null) {
                      controller.locationcontroller.text = place;
                    }
                  },
                  // ignore: prefer_const_constructors
                  suffixIcon: Icon(
                    Icons.expand_more_outlined,
                    size: 25,
                    color: redColor,
                  ),
                ),
                size,
                CommonTextFeild(
                  hintText: 'Name',
                  labelText: 'Enter Name',
               
                  textEditingController: controller.namecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Name';
                    }
                    return null;
                  },
                ),
                size,
                CommonTextFeild(
                  hintText: 'Address',
                  labelText: 'Enter Address',
                  textEditingController: controller.addresscontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Address';
                    }
                    return null;
                  },
                ),
                size,
                CommonTextFeild(
                  hintText: 'Email',
                  labelText: 'Enter Email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: controller.emailcontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Email';
                    } else if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please Enter a valid Email';
                    } else {
                      return null;
                    }
                  },
                ),
                size,
                CommonTextFeild(
                  inputFormate: true,
                  hintText: 'Pincode',
                  labelText: 'Enter Pincode',
                  textInputType: TextInputType.number,
                  maxLengthLimit: 6,
                  textEditingController: controller.pincodecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Pincode';
                    } else if (!RegExp(r"^[0-9]{6}$").hasMatch(value)) {
                      return 'Please Enter a valid Pincode';
                    } else {
                      return null;
                    }
                  },
                ),
                size,
                CommonTextFeild(
                  hintText: 'Contact Person',
                  labelText: 'Enter Contact Person',
                  textEditingController: controller.contactPersoncontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Contact Person';
                    }
                    return null;
                  },
                ),
                size,
                CommonTextFeild(
                  hintText: 'Contact Number',
                  labelText: 'Enter Contact Number',
                  textInputType: TextInputType.number,
                  textEditingController: controller.contactNumbercontroller,
                  maxLengthLimit: 10,
                  inputFormate: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Contact Number';
                    } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                        .hasMatch(value)) {
                      return 'Please Enter a valid Contact Number';
                    } else {
                      return null;
                    }
                  },
                ),
                size,
                CommonTextFeild(
                  hintText: 'Current Grade',
                  labelText: 'Enter Grade',
                  textEditingController: controller.currentGradecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Current Grade';
                    }
                    return null;
                  },
                ),
                size,
                CommonTextFeild(
                    hintText: 'Current Production Capacity',
                    labelText: 'Enter  Production Capacity',
                    textInputType: TextInputType.number,
                    textEditingController:
                        controller.productioncapacitycontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Production Capacity';
                      } else {
                        return null;
                      }
                    }),
                size,
                CommonTextFeild(
                  hintText: 'CU Code',
                  labelText: 'Enter CuCode',
                  textEditingController: controller.cuCodecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Current CuCode';
                    }
                    return null;
                  },
                ),
                size,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CommonButtonWidget(
          label: 'NEXT',
          onClick: () async {
            FocusScope.of(context).unfocus();
            if (controller.formKey.currentState!.validate()) {
             // await controller.getTeam();
             // Get.to(const NextAddLeads());
            }
          },
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String label;
  const Option({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String number;
  final Color color;
  const HeaderWidget({super.key, required this.number, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 28,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(width: 1.5, color: color)),
      child: Center(
        child: Container(
          height: 22,
          width: 22,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

RoundedRectangleBorder bootomSheetShapeType2() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
  );
}

