import 'package:flutter/material.dart';
import 'package:india_cart_app/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class catalogImage extends StatelessWidget {
  final String image;

  const catalogImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .rounded
        .p8
        .color(MyTheme.creamColor)
        .make()
        .p16()
        .w40(context);
  }
}
