import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/categories_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/products_model.dart';

class HomeService {
  ApiClient apiClient;

  HomeService(this.apiClient);

  Future<List<CategoriesModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categories);
    return (response.data as List)
        .map((e) => CategoriesModel.fromJson(e))
        .toList();
  }

  Future<List<ProductsModel>> getProducts(num? categoryId) async {
    final response = await apiClient.dio.get(
      "${ApiEndpoints.categories}/$categoryId/${ApiEndpoints.products}",
    );
    return (response.data as List)
        .map((e) => ProductsModel.fromJson(e))
        .toList();
  }
}
