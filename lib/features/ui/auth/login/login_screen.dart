import 'package:ecommerce_app/core/utils/app_assets.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_routes.dart';
import 'package:ecommerce_app/core/utils/app_styles.dart';
import 'package:ecommerce_app/core/utils/validators.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/features/ui/auth/login/cubit/login_states.dart';
import 'package:ecommerce_app/features/ui/auth/login/cubit/login_view_model.dart';
import 'package:ecommerce_app/features/ui/widgets/custom_elevated_button.dart';
import 'package:ecommerce_app/features/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/cache/shared_prefrence.dart';
import '../../../../core/utils/dialogue_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenViewModel viewModel = getIt<LoginScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginScreenViewModel, LoginStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is LoginLoadingState) {
          DialogueUtils.showMessage(
              context: context, message: "Loading.......");
        } else if (state is LoginErrorState) {
          DialogueUtils.hideLoading(context);
          DialogueUtils.showMessage(
              context: context,
              message: state.error.errorMessage,
              title: "Error",
              posActionName: "OK");
        } else if (state is LoginSuccessState) {
          DialogueUtils.hideLoading(context);
          DialogueUtils.showMessage(
              context: context,
              message: "Register Successfully",
              title: "Success",
              posActionName: "OK",
              posAction: () {
                // todo: save token
                SharedPreferenceUtils.saveData(
                    key: "token", val: state.responseEntity.token);
                Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
              });
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  Image.asset(AppAssets.routeImageBlue),
                  SizedBox(
                    height: 75.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back To Route",
                        style: AppStyles.semi24White,
                      ),
                      Text(
                        "Please sign in with your mail",
                        style: AppStyles.light16White,
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      Text(
                        "Email",
                        style: AppStyles.medium18White,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextFormField(
                          controller: viewModel.emailController,
                          validator: AppValidators.validateEmail,
                          hintText: "enter your Email"),
                      SizedBox(
                        height: 35.h,
                      ),
                      Text(
                        "Password",
                        style: AppStyles.medium18White,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextFormField(
                          controller: viewModel.passwordController,
                          suffixIcon: Image.asset(AppAssets.hidePassIcon),
                          hintText: "enter your password"),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Forget Password", style: AppStyles
                                  .regular18White,)
                            ],),
                          SizedBox(height: 35.h,),
                          CustomElevatedButton(
                              text: "Log in",
                              onTap: () {
                                viewModel.login();
                              }),
                          SizedBox(height: 25.h,),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes
                                  .registerRoute);
                            },
                            child: RichText(text: TextSpan(
                                children: [
                                  TextSpan(text: "Don't Have an Account?",
                                      style: AppStyles.medium18White),
                                  TextSpan(text: "Create Account",
                                      style: AppStyles.medium18White)
                                ]
                            )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
          )),
    );
  }
}
