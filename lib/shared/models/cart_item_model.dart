import 'package:carrinho_de_compras/shared/models/product_model.dart';

class CartItemModel {
  late ProductModel product;
  int quantity = 0;

  CartItemModel();

  void setProduct(ProductModel product) {
    this.product = product;
  }

  void increment() {
    this.quantity += 1;
  }

  void decrement() {
    this.quantity -= 1;
  }
}
