import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class CartItemCard extends StatelessWidget {
  final String image;
  final String name, code, qty;
  final Function ontap;
  const CartItemCard({
    Key? key,
    required this.image,
    required this.name,
    required this.code,
    required this.qty,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                image,
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              blackText(name, 14, fontWeight: FontWeight.w600),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  greyText('Mrp :', 12,
                                      fontWeight: FontWeight.w400),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  greyText(code, 12,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                ontap();
                              },
                              icon:
                                  svgWidget("assets/svg/delete.svg", size: 25))
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          greyText('Qty:', 12, fontWeight: FontWeight.w400),
                          blackText(qty, 12, fontWeight: FontWeight.w600),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
      ),
      child: SizedBox(
        child: IconButton(
            onPressed: () {},
            icon: svgWidget("assets/svg/delete.svg", size: 15)),
      ),
    );
  }
}
