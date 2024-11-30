import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_right/core/components/widgets/custom_button.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/app_auth/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:read_right/features/app_auth/presentation/manager/sign_up_cubit/sign_up_states.dart';
import 'package:read_right/features/app_auth/presentation/ui/auth_view.dart';
import 'package:read_right/features/app_auth/presentation/ui/widgets/auth_footer.dart';
import 'package:read_right/core/components/widgets/custom_input_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthView(
      formTitle: context.signUpWelcome,
      form: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: context.read<SignUpCubit>().formKey,
          child: Column(
            children: [
              CustomAppInputField(
                hintText: context.emailHint,
                validationMessage: context.emailErrorHint,
                icon: FontAwesomeIcons.solidEnvelope,
                isPassword: false,
                controller: context.read<SignUpCubit>().emailController,
              ),
              const SizedBox(height: 16),
              CustomAppInputField(
                hintText: context.passwordHint,
                validationMessage: context.passwordErrorHint,
                icon: FontAwesomeIcons.lock,
                isPassword: true,
                controller: context.read<SignUpCubit>().passwordController,
              ),
              const SizedBox(height: 16),
              CustomAppInputField(
                hintText: context.rePasswordHint,
                validationMessage: context.rePasswordErrorHint,
                icon: FontAwesomeIcons.lock,
                isPassword: true,
                controller: context.read<SignUpCubit>().passwordConfirmController,
              ),
              const SizedBox(height: 24),
              BlocConsumer<SignUpCubit,SignUpState>(
                builder: (context,state) {
                  if(state is SignUpLoadingState){
                    return CustomButton(
                      onPressed: () {},
                      label: context.signUpButtonLabel,
                      isLoading: true,
                    );
                  }
                  return CustomButton(
                    onPressed: () {
                      signUpAction(context);
                    },
                    label: context.signUpButtonLabel,
                    isLoading: false,
                  );
                },
                listener: (context,state){
                  if(state is SignUpSuccessState){
                    Navigator.pushNamed(context, AppRoutingConstances.preSetting);
                  }
                },
              ),
              const SizedBox(height: 16),
              AuthFooter(
                clickable: context.signUpFooterLabelClickable,
                notClickable: context.signUpFooterLabelUnClickable,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutingConstances.logIn);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  signUpAction(BuildContext context){
    if(context.read<SignUpCubit>().formKey.currentState!.validate()){
      if(context.read<SignUpCubit>().passwordController.text != context.read<SignUpCubit>().passwordConfirmController.text){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.rePasswordErrorHint),
          ),
        );
        context.read<SignUpCubit>().passwordController.clear();
        context.read<SignUpCubit>().passwordConfirmController.clear();
        return;
      }
      if(context.read<SignUpCubit>().passwordController.text.length < 6){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.passwordLengthErrorHint),
          ),
        );
        context.read<SignUpCubit>().passwordController.clear();
        return;
      }
      String email = context.read<SignUpCubit>().emailController.text;
      String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
      RegExp regExp = RegExp(emailPattern);
      if (!regExp.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.emailErrorHint),
          ),
        );
        context.read<SignUpCubit>().emailController.clear();
        return;
      }
      context.read<SignUpCubit>().signUp(
        email: context.read<SignUpCubit>().emailController.text,
        password: context.read<SignUpCubit>().passwordController.text,
        confirmPassword: context.read<SignUpCubit>().passwordConfirmController.text,
      );
    }
  }
}
