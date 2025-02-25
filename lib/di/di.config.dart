// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/api/api_manager.dart' as _i108;
import '../data/data_source/remote_data_source/auth_remote_data_source_impl.dart'
    as _i175;
import '../data/data_source/remote_data_source/cart_remote_data_source_impl.dart'
    as _i267;
import '../data/data_source/remote_data_source/home_remote_data_source_impl.dart'
    as _i604;
import '../data/repositories/auth_repository_impl.dart' as _i74;
import '../data/repositories/cart_repository_impl.dart' as _i230;
import '../data/repositories/home_repository_impl.dart' as _i158;
import '../domain/repositories/cart/cart_repository.dart' as _i953;
import '../domain/repositories/data_source/auth_remote_data_source/auth_remote_data_source.dart'
    as _i273;
import '../domain/repositories/data_source/auth_remote_data_source/cart_remote_data_source.dart'
    as _i35;
import '../domain/repositories/data_source/auth_remote_data_source/home_remote_data_source.dart'
    as _i188;
import '../domain/repositories/repository/auth_repository.dart' as _i555;
import '../domain/repositories/repository/home_repository.dart' as _i745;
import '../domain/usecase/add_to_cart_use_case.dart' as _i127;
import '../domain/usecase/delete_items_in_cart_use_case.dart' as _i769;
import '../domain/usecase/get_all_brands_use_case.dart' as _i417;
import '../domain/usecase/get_all_categories_use_case.dart' as _i241;
import '../domain/usecase/get_all_products_use_case.dart' as _i867;
import '../domain/usecase/get_items_in_cart_use_case.dart' as _i188;
import '../domain/usecase/login_use_case.dart' as _i374;
import '../domain/usecase/register_use_case.dart' as _i491;
import '../domain/usecase/update_count_in_cart_use_case.dart' as _i291;
import '../features/ui/auth/login/cubit/login_view_model.dart' as _i1040;
import '../features/ui/auth/register/cubit/register_screen_view_model.dart'
    as _i271;
import '../features/ui/pages/cart_screen/cubit/cart_view_model.dart' as _i65;
import '../features/ui/pages/home_screen/tabs/home_tab/home_tab_cubit/home_tab_view_model.dart'
    as _i184;
import '../features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_view_model.dart';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i108.ApiManager>(() => _i108.ApiManager());
    gh.factory<_i273.AuthRemotelyDataSource>(() =>
        _i175.AuthRemotelyDataSourceImpl(apiManager: gh<_i108.ApiManager>()));
    gh.factory<_i555.AuthRepository>(() => _i74.AuthRepositoryImpl(
        authRemotelyDataSource: gh<_i273.AuthRemotelyDataSource>()));
    gh.factory<_i188.HomeRemoteDataSource>(() =>
        _i604.HomeRemoteDataSourceImpl(apiManager: gh<_i108.ApiManager>()));
    gh.factory<_i35.CartRemoteDataSource>(() =>
        _i267.CartRemoteDataSourceImpl(apiManager: gh<_i108.ApiManager>()));
    gh.factory<_i745.HomeRepository>(() => _i158.HomeRepositoryImpl(
        homeRemoteDataSource: gh<_i188.HomeRemoteDataSource>()));
    gh.factory<_i374.LoginUseCase>(
        () => _i374.LoginUseCase(authRepository: gh<_i555.AuthRepository>()));
    gh.factory<_i491.RegisterUseCase>(() =>
        _i491.RegisterUseCase(authRepository: gh<_i555.AuthRepository>()));
    gh.factory<_i1040.LoginScreenViewModel>(() =>
        _i1040.LoginScreenViewModel(loginUseCase: gh<_i374.LoginUseCase>()));
    gh.factory<_i127.AddToCartUseCase>(() =>
        _i127.AddToCartUseCase(homeRepository: gh<_i745.HomeRepository>()));
    gh.factory<_i417.GetAllBrandsUseCase>(() =>
        _i417.GetAllBrandsUseCase(homeRepository: gh<_i745.HomeRepository>()));
    gh.factory<_i241.GetAllCategoriesUseCase>(() =>
        _i241.GetAllCategoriesUseCase(
            homeRepository: gh<_i745.HomeRepository>()));
    gh.factory<_i867.GetAllProductsUseCase>(() => _i867.GetAllProductsUseCase(
        homeRepository: gh<_i745.HomeRepository>()));
    gh.factory<_i271.RegisterViewModel>(() =>
        _i271.RegisterViewModel(registerUseCase: gh<_i491.RegisterUseCase>()));
    gh.factory<ProductTabViewModel>(() => ProductTabViewModel(
          getAllProductsUseCase: gh<_i867.GetAllProductsUseCase>(),
          addToCartUseCase: gh<_i127.AddToCartUseCase>(),
        ));
    gh.factory<_i184.HomeTabViewModel>(() => _i184.HomeTabViewModel(
          getAllCategoriesUseCase: gh<_i241.GetAllCategoriesUseCase>(),
          getAllBrandsUseCase: gh<_i417.GetAllBrandsUseCase>(),
        ));
    gh.factory<_i953.CartRepository>(() => _i230.CartRepositoryImpl(
        cartRemoteDataSource: gh<_i35.CartRemoteDataSource>()));
    gh.factory<_i188.GetItemsInCartUseCase>(() => _i188.GetItemsInCartUseCase(
        cartRepository: gh<_i953.CartRepository>()));
    gh.factory<_i769.DeleteItemsInCartUseCase>(() =>
        _i769.DeleteItemsInCartUseCase(
            cartRepository: gh<_i953.CartRepository>()));
    gh.factory<_i291.UpdateCountInCartUseCase>(() =>
        _i291.UpdateCountInCartUseCase(
            cartRepository: gh<_i953.CartRepository>()));
    gh.factory<_i65.CartViewModel>(() => _i65.CartViewModel(
          getItemsInCartUseCase: gh<_i188.GetItemsInCartUseCase>(),
          deleteItemsInCartUseCase: gh<_i769.DeleteItemsInCartUseCase>(),
          updateCountInCartUseCase: gh<_i291.UpdateCountInCartUseCase>(),
        ));
    return this;
  }
}
