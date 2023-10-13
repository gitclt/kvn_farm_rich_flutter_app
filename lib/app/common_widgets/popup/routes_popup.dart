import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/checkbox_button.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/common_widgets/widgets/expansion_tile_widget.dart';
import 'package:kvn_farm_rich/app/models/route_place_model.dart';

class RoutesPopup extends StatefulWidget {
  final List<Routes> children;
  const RoutesPopup({super.key, required this.children});

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
                  top: size.height * 0.30,
                  left: size.width * 0.050,
                  right: size.width * 0.050,
                  bottom: size.height * 0.40,
                ),
                child: Container(
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      itemCount: widget.children.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTileWidget(
                          label: widget.children[index].route.routename,
                          children: widget.children[index].places
                              .map((e) => placeRow(() {
                                    e.isSelect.value = !e.isSelect.value;
                                  }, e.isSelect.value, e.name))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget placeRow(Function ontap, var selectItem, String label) {
  return Row(
    children: [
      CheckBoxButton(
        height: 18,
        width: 18,
        act: () {
          ontap();
        },
        selectItem: selectItem,
      ),
      greyText(label, 12)
    ],
  ).paddingAll(10);
}
