import 'package:ecommerce_app/core/utils/app_routes.dart';
import 'package:ecommerce_app/core/utils/app_theme.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/features/ui/auth/login/login_screen.dart';
import 'package:ecommerce_app/features/ui/auth/register/register_screen.dart';
import 'package:ecommerce_app/features/ui/pages/home_screen/home_screen.dart';
import 'package:ecommerce_app/features/ui/pages/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/bloc_observer.dart';

void main(){
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routes: {
            AppRoutes.registerRoute : (context) => RegisterScreen(),
            AppRoutes.loginRoute : (context) => LoginScreen(),
            AppRoutes.homeRoute: (context) => HomeScreen(),
            AppRoutes.productDetailsRoute: (context) => ProductDetailsScreen(),
          },
          initialRoute: AppRoutes.homeRoute,
        );
      },
    );
  }
}
