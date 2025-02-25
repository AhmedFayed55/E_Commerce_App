
import 'package:ecommerce_app/core/utils/app_assets.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_styles.dart';
import 'package:ecommerce_app/core/utils/dialogue_utils.dart';
import 'package:ecommerce_app/core/utils/validators.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/features/ui/auth/register/cubit/register_screen_states.dart';
import 'package:ecommerce_app/features/ui/auth/register/cubit/register_screen_view_model.dart';
import 'package:ecommerce_app/features/ui/widgets/custom_elevated_button.dart';
import 'package:ecommerce_app/features/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterViewModel viewModel = getIt<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel,RegisterStates>(
      bloc: viewModel,
      listener: (context,state){
        if(state is RegisterLoadingState){
          DialogueUtils.showMessage(context: context, message: "Loading.......");
        }else if(state is RegisterErrorState){
          DialogueUtils.hideLoading(context);
          DialogueUtils.showMessage(context: context, message: state.error.errorMessage,
          title: "Error",posActionName: "OK");
        }else if(state is RegisterSuccessState){
          DialogueUtils.hideLoading(context);
          DialogueUtils.showMessage(context: context, message: "Register Successfully",
          title: "Success",posActionName: "OK");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
        ),
        backgroundColor: AppColors.primaryColor,
          body : SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Image.asset(AppAssets.routeImageBlue),
                SizedBox(height: 40.h,),
              Column(
                spacing: 15.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Full Name",style: AppStyles.medium18White,),
                  CustomTextFormField(
                    controller: viewModel.fullNameController,
                    validator: AppValidators.validateFullName,
                      hintText: "enter your full name"
                  ),
                  Text("Mobile Number",style: AppStyles.medium18White),
                  CustomTextFormField(
                    controller: viewModel.phoneController,
                      hintText: "enter your mobile no.",
                    validator: AppValidators.validatePhoneNumber,
                  ),
                  Text("Email Address",style: AppStyles.medium18White),
                  CustomTextFormField(
                    controller: viewModel.emailController,
                      hintText: "enter your email address",
                    validator: AppValidators.validateEmail,
                  ),
                  Text("Password",style: AppStyles.medium18White),
                  CustomTextFormField(
                    controller: viewModel.passwordController,
                      hintText: "enter your password",
                    validator: AppValidators.validatePassword,
                  ),
                  Text("Re-Password",style: AppStyles.medium18White),
                  CustomTextFormField(
                    controller: viewModel.rePasswordController,
                      hintText: "enter your re-password",
                    validator: AppValidators.validatePassword,
                  ),
                  SizedBox(height: 15.h,),
                  CustomElevatedButton(
                      text: "Sign up",
                      onTap: (){
                        viewModel.register();
                      })
                ],
              ),
            ],
          ),
        )
      )),
    );
  }
}
