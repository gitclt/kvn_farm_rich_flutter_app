import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/product_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/product_popup.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(pattern: [
          const WovenGridTile(
            1,
            // crossAxisRatio: 0.9,
          ),
          const WovenGridTile(
            8 / 8,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.topCenter,
          )
        ], crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
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
