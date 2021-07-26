import 'package:carrinho_de_compras/modules/cart/cart_controller.dart';
import 'package:carrinho_de_compras/shared/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CartPage extends StatefulWidget {
  final CartController controller;
  CartPage({Key? key, required this.controller}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: widget.controller.list.isEmpty
          ? Center(child: Text("OPS! Seu carrinho está vazio"))
          : Observer(builder: (_) {
              return ListView.builder(
                itemCount: widget.controller.list.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text(widget.controller.list[index].product.name),
                  trailing: // Text(widget.controller.list[index].product.price.reais()),
                    Text("${widget.controller.list[index].product.price.reais()}     qtde: ${widget.controller.list[index].quantity.toString()}"),
                      // Text(widget.controller.list[index].quantity.toString()),
                  onTap: () {
                    widget.controller.incrementItem(widget.controller.list[index].product);
                    print(
                        "${widget.controller.list[index].product.name}: ${widget.controller.list[index].quantity}");
                  },
                  onLongPress: () {
                    widget.controller.decrementItem(widget.controller.list[index].product);
                    print(
                      "${widget.controller.list[index].product.name}: ${widget.controller.list[index].quantity}"
                    );
                  },
                ),
              );
            }),
    );
  }
}
