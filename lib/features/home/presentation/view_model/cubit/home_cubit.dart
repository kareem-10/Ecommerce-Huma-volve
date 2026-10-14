import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/home_category_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/home_product_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeCategoryUsecase homeCategoryUsecase;
  final HomeProductUsecase homeProductUsecase;
  HomeCubit({
    required this.homeCategoryUsecase,
    required this.homeProductUsecase,
  }) : super(HomeInitial());

  void getCategories() async {
    emit(CategoriesLoading());
    final categories = await homeCategoryUsecase.call();
    categories.fold(
      (failure) => emit(CategoriesError(failure.failureMessage)),
      (success) => emit(CategoriesSuccess(success)),
    );
    // try {
    //   final categories = await homeService.getCategories();
    //   emit(CategoriesSuccess(categories));
    // } catch (e) {
    //   emit(CategoriesError(e.toString()));
    // }
  }

  void getProducts(int? categoryId) async {
    emit(ProductsLoading());

    final products = await homeProductUsecase.call(categoryId);
    products.fold(
      (failure) => emit(ProductsError(failure.failureMessage)),
      (success) => emit(ProductsSuccess(success)),
    );

    //   try {
    //     final products = await homeService.getProducts(categoryId);
    //     emit(ProductsSuccess(products));
    //   } catch (e) {
    //     emit(ProductsError(e.toString()));
    //   }
  }
}
