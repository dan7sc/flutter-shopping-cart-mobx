import 'dart:ui';

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
                itemBuilder: (_, index) => Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.controller.list[index].product.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.controller.list[index].product.price.reais(),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => widget.controller.decrementItem(widget.controller.list[index].product),
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            widget.controller.list[index].quantity.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () => widget.controller.incrementItem(
                                widget.controller.list[index].product),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => widget.controller.removeItem(
                          widget.controller.list[index].product),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            }),
    );
  }
}
