import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class ExpansionTileWidget extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const ExpansionTileWidget({super.key, required this.label, required this.children});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: blackText(label, 15),
      children: children,);
  }
}
