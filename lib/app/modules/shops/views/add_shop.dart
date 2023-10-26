import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/common_textfield.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/dropdown_textfield.dart';
import 'package:kvn_farm_rich/app/modules/shops/controllers/shops_controller.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class AddShops extends GetView<ShopsController> {
  const AddShops({super.key});

  @override
  Widget build(BuildContext context) {
    final size = SizedBox(height: MediaQuery.of(context).size.height * 0.02);
    return Scaffold(
      appBar: const CommonAppBar(label: 'Add Shop',  visibility: false,),
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
                  labelText: 'Enter Customer Name',
                  textEditingController: controller.namecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Customer Name';
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
                  hintText: 'Customer Code',
                  labelText: 'Enter Customer Code',
                  textEditingController: controller.cuCodecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Current Customer Code';
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
          label: 'SUBMIT',
          isLoading: controller.isLoading.value,
          onClick: () async {
            FocusScope.of(context).unfocus();
            if (controller.formKey.currentState!.validate()) {
              await controller.addShops();
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
