import 'package:carrinho_de_compras/shared/models/cart_item_model.dart';
import 'package:carrinho_de_compras/shared/models/product_model.dart';
import 'package:mobx/mobx.dart';

part 'cart_controller.g.dart';

class CartController = _CartControllerBase with _$CartController;

abstract class _CartControllerBase with Store {
  final List<CartItemModel> list = <CartItemModel>[];
  late CartItemModel cartItem;

  @observable
  String listLength = "0";

  @action
  void addItem(ProductModel product) {
    if (list.any((item) => item.product.id == product.id)) {
      cartItem.setProduct(product);
      cartItem.increment();
    } else {
      cartItem = CartItemModel();
      cartItem.setProduct(product);
      cartItem.increment();
      list.add(cartItem);
      listLength = list.length.toString();
    }
  }

  @action
  void removeItem(ProductModel product) {
    list.forEach((item) {
      if (item.product.id == product.id) {
        list.remove(item);
      }
      listLength = list.length.toString();
    });
  }

  @action
  void incrementItem(ProductModel product) {
    list.forEach((item) {
      if (item.product.id == product.id) {
        item.increment();
      }
      listLength = list.length.toString();
    });
  }

  @action
  void decrementItem(ProductModel product) {
    list.forEach((item) {
      if (item.product.id == product.id) {
        item.increment();
      }
      listLength = list.length.toString();
    });
  }
}
