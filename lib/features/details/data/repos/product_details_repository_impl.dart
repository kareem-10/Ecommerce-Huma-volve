import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/error_handling.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/repos/product_details_repository.dart';

import '../../domain/entities/product_details_entity.dart';
import '../datasources/product_details_remote_data_source.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
    int productId,
  ) async {
    try {
      final product = await remoteDataSource.getProductDetails(productId);
      return Right(product);
    } catch (e) {
      return Left(ErrorHandler.handle(e.toString()));
    }
  }
}
