import 'package:ecommerce_app_huma_volve/features/details/domain/use_cases/get_product_details_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/cubit/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase)
    : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    final result = await getProductDetailsUseCase(productId);
    result.fold(
      (failure) => emit(ProductDetailsError(failure.failureMessage)),
      (product) => emit(ProductDetailsSuccess(product)),
    );
  }
}
