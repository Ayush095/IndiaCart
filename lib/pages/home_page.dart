// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:india_cart_app/core/store.dart';
import 'package:india_cart_app/models/cart.dart';
import 'package:india_cart_app/pages/home_widgets/catalog_header.dart';
import 'package:india_cart_app/pages/home_widgets/catalog_list.dart';
import 'package:india_cart_app/utils/routes.dart';
import 'package:india_cart_app/widgets/drawer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:india_cart_app/models/catalog.dart';
import 'package:india_cart_app/widgets/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productData = decodedData["products"];
    CatalogModel.items =
        List.castFrom(productData).map((item) => Item.formMap(item)).toList();
    setState(() {});
  }

  final int days = 30;

  final String name = "India Cart";

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      appBar: AppBar(
        title: "India Cart".text.xl.bold.color(MyTheme.darkBluishColor).make(),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: VxBuilder(
        mutations: {RemoveMutation, AddMutation},
        builder: (context, store, status) => FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, MyRoutes.cartPage),
          backgroundColor: MyTheme.darkBluishColor,
          child: Icon(CupertinoIcons.cart),
        ).badge(
            color: Vx.red500,
            size: 22,
            count: _cart.items.length,
            textStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: MyTheme.creamColor,
      body: SafeArea(
        child: Container(
            padding: Vx.m32,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList().py16().expand()
              else
                CircularProgressIndicator().centered().expand(),
            ])),
      ),
      drawer: MyDrawer(),
    );
  }
}
