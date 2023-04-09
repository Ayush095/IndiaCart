import 'package:flutter/material.dart';
import 'package:india_cart_app/core/store.dart';
import 'package:india_cart_app/models/cart.dart';
import 'package:india_cart_app/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.make(),
      ),
      body: Column(children: [
        _CartList().p32().expand(),
        Divider(),
        _CartTotal(),
      ]),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxConsumer(
              builder: (context, store, status) {
                return "\$${_cart.totalPrice}"
                    .text
                    .xl5
                    .color(Colors.black)
                    .make();
              },
              mutations: {RemoveMutation}),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: "Buying not supported".text.make()));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black)),
            child: "Buy".text.white.make(),
          ).w24(context)
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  final _cart = (VxState.store as MyStore).cart;
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    return (_cart.items.length == 0)
        ? "Nothing to show".text.xl3.make().centered()
        : ListView.builder(
            itemCount: _cart.items.length,
            itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.done),
                  title: _cart.items[index].name.text.make(),
                  trailing: IconButton(
                      onPressed: () {
                        RemoveMutation(_cart.items[index]);
                      },
                      icon: Icon(Icons.remove_circle_outline)),
                ));
  }
}
