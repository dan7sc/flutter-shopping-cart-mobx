import 'package:carrinho_de_compras/modules/cart/cart_controller.dart';
import 'package:carrinho_de_compras/modules/cart/cart_page.dart';
import 'package:carrinho_de_compras/modules/home/home_controller.dart';
import 'package:carrinho_de_compras/shared/models/product_model.dart';
import 'package:carrinho_de_compras/state_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final cartController = CartController();

  @override
  void initState() {
    controller.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CartPage(
                              controller: cartController,
                            )));
              },
              icon: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: StateBuilder<List<ProductModel>>(
                        builder: (_, state) => CircleAvatar(
                              radius: 9,
                              child: Text(
                                state.length.toString(),
                                style: TextStyle(fontSize: 8),
                              ),
                            ),
                        controller: cartController),
                  )
                ],
              ))
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.appStatus == AppStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.appStatus == AppStatus.success &&
              controller.products.isNotEmpty) {
            return ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (_, index) => ListTile(
                title: Text(controller.products[index].name),
                trailing: Text(controller.products[index].price.toString()),
                onTap: () {
                  cartController.addItem(controller.products[index]);
                },
              ),
            );
          } else if (controller.appStatus == AppStatus.empty) {
            return EmptyState();
          } else if (controller.appStatus == AppStatus.error){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Houve um problema",
                    style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .apply(color: Colors.red),
                  ),
                  Text(controller.appStatus.message()),
                ],
              ),
            );
          }
          return EmptyState();
        },
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Produtos indisponíveis no momento!",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
