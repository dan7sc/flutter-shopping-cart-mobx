import 'package:carrinho_de_compras/shared/models/cart_item_model.dart';
import 'package:carrinho_de_compras/shared/models/product_model.dart';
import 'package:mobx/mobx.dart';

part 'cart_controller.g.dart';

class CartController = _CartControllerBase with _$CartController;

abstract class _CartControllerBase with Store {
  late CartItemModel cartItem;

  @observable
  ObservableList<CartItemModel> list = ObservableList.of(<CartItemModel>[]);

  @action
  void addItem(ProductModel product) {
    if (list.any((item) => item.product.id == product.id)) {
      incrementItem(product);
    } else {
      cartItem = CartItemModel(product: product, quantity: 1);
      list.add(cartItem);
    }
  }

  @action
  void removeItem(ProductModel product) {
    list.forEach((item) {
      if (item.product.id == product.id) {
        list.remove(item);
      }
    });
  }

  @action
  void incrementItem(ProductModel product) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].product.id == product.id) {
        final cartItem = list[i];
        list[i] = cartItem.copyWith(quantity: cartItem.quantity + 1);
      }
    }
  }

  @action
  void decrementItem(ProductModel product) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].product.id == product.id) {
        final cartItem = list[i];
        if (cartItem.quantity - 1 == 0) {
          removeItem(cartItem.product);
        } else {
          list[i] = cartItem.copyWith(quantity: cartItem.quantity - 1);
        }
      }
    }
  }
}
