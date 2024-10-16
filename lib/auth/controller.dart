import 'package:get/get.dart';
import 'package:project/auth/model.dart';
// import 'api_service.dart';


class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {

  }
}
