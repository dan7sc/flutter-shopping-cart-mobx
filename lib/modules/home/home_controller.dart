import 'package:carrinho_de_compras/shared/models/product_model.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

enum AppStatus { success, loading, error, empty }

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  AppStatus appStatus = AppStatus.empty;

  List<ProductModel> products = <ProductModel>[];

  @action
  Future<void> getProducts() async {
    try {
      appStatus = AppStatus.loading;
      products = await Future.delayed(Duration(seconds: 2)).then(
        (value) => List.generate(
          50,
          (index) => ProductModel(
            name: "Produto $index ",
            price: 1.0 * index,
          ),
        ),
      );
      appStatus = products.isNotEmpty ? AppStatus.success: AppStatus.empty;
    } catch (e) {
      appStatus = AppStatus.error;
      appStatus.message();
    }
  }
}

extension stateMessage on AppStatus {
  String message() {
    if (this == AppStatus.error) {
      return "Ops! Algo deu errado";
    }
    return "";
  }
}
