import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_datasource.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_datasource_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repositories/home_repository_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repositories/home_repository.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/home_category_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/home_product_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme.dart';
import '../../cart/screens/cart_screen.dart';
import '../../home/presentation/view/home_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  late final ApiClient apiClient;
  late final HomeRemoteDatasource homeRemoteDatasource;
  late final HomeRepository homeRepository;
  late final HomeProductUsecase homeProductUsecase;
  late final HomeCategoryUsecase homeCategoryUsecase;
  late final HomeCubit homeCubit;

  @override
  void initState() {
    apiClient = ApiClient();
    homeRemoteDatasource = HomeRemoteDatasourceImp(apiClient);
    homeRepository = HomeRepositoryImp(homeRemoteDatasource);
    homeProductUsecase = HomeProductUsecase(homeRepository);
    homeCategoryUsecase = HomeCategoryUsecase(homeRepository);
    homeCubit = HomeCubit(
      homeCategoryUsecase: homeCategoryUsecase,
      homeProductUsecase: homeProductUsecase,
    );
    super.initState();
  }

  @override
  void dispose() {
    homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      BlocProvider.value(value: homeCubit, child: const HomeScreen()),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: AppTheme.primary,
            unselectedItemColor: Colors.grey.shade400,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.home_filled, size: 28),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.home_filled, size: 32),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.shopping_cart_outlined, size: 28),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.shopping_cart, size: 32),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.person_outline, size: 28),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.person, size: 32),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
