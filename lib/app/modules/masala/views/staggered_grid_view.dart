import 'package:kvn_farm_rich/app/common_widgets/card/product_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/product_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(pattern: [
          const WovenGridTile(1),
          const WovenGridTile(
            8 / 7,
            //  crossAxisRatio: 0.5,
            alignment: AlignmentDirectional.centerEnd,
          )
        ], crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 12),
        // itemBuilder: (context, index) {
        //   return ProductCard(
        //       artNo: 'GP4300',
        //       brandName: 'Gents Coverings',
        //       image: "",
        //       // "https://icon2.cleanpng.com/20180323/eaq/kisspng-slipper-footwear-shoe-sandal-flip-flops-men-shoes-5ab57871171a07.8676672615218422890946.jpg",
        //       mrp: '350',
        //       onTap: () {
        //         Get.toNamed(Routes.PRODUCTDETAILS);
        //       },
        //       colors: Color(0xFFCF2812),
        //       color: Color(0xFFE45A5A));
        // },
        childrenDelegate: SliverChildBuilderDelegate((context, index) {
          return ProductCard(
            iteam: 'SAMBAR POWDER',
            code: '#6302',
            image: "assets/image/powder.png",
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => const ProductPopup(
                  image: "assets/image/largeproduct.png",
                  code: '#6302',
                  name: "TURMERIC POWDER",
                ),
              );
            },
          );
        }, childCount: 6),
      ),
    );
  }
}
