import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import '../models/product_details_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails(int productId);
}

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final ApiClient apiClient;

  ProductDetailsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ProductDetailsModel> getProductDetails(int productId) async {
    final response = await apiClient.dio.get('/products/$productId');
    return ProductDetailsModel.fromJson(response.data);
  }
}
