import 'package:ecommerce_app_huma_volve/features/home/cubit/home_state.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitial());

  void getCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await homeService.getCategories();
      emit(CategoriesSuccess(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void getProducts(num? categoryId) async {
    emit(ProductsLoading());
    try {
      final products = await homeService.getProducts(categoryId);
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
