import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/checkbox_button.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/common_widgets/widgets/expansion_tile_widget.dart';
import 'package:kvn_farm_rich/app/models/route_place_model.dart';

class RoutesPopup extends StatefulWidget {
  final List<Routes> children;
  final Function onClick;
  final bool isLoading;
  
  const RoutesPopup(
      {super.key,
      required this.children,
      required this.onClick,
      required this.isLoading,
     });

  @override
  State<StatefulWidget> createState() => AddRoutePopupState();
}

class AddRoutePopupState extends State<RoutesPopup>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.20,
                  left: size.width * 0.050,
                  right: size.width * 0.050,
                  bottom: size.height * 0.20,
                ),
                child: Container(
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.children.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ExpansionTileWidget(
                              label: widget.children[index].route.routename,
                              children: widget.children[index].places
                                  .map((e) => Obx(
                                        () => PlacesRow(
                                          label: e.name,
                                          onTap: () {
                                            e.isSelect.value =
                                                !e.isSelect.value;
                                          },
                                          selectItem: 
                                              e.isSelect.value,
                                        ),
                                      ))
                                  .toList(),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CommonButtonWidget(
                        label: 'OK',
                        borderRadius: 15,
                        isLoading: widget.isLoading,
                        height: MediaQuery.of(context).size.height * 0.05,
                        onClick: () {
                          widget.onClick();
                          Get.back();
                        },
                      )
                    ],
                  ).paddingAll(15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlacesRow extends StatelessWidget {
  final Function onTap;
  final bool selectItem;
  final String label;

  const PlacesRow(
      {super.key,
      required this.onTap,
      required this.selectItem,
      required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CheckBoxButton(
          act: () {
            onTap();
          },
          selectItem: selectItem,
        ),
        greyText(label, 12)
      ],
    ).paddingAll(10);
  }
}
