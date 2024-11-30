import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_right/core/components/widgets/custom_button.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/app_auth/presentation/manager/log_in_cubit/log_in_cubit.dart';
import 'package:read_right/features/app_auth/presentation/manager/log_in_cubit/log_in_states.dart';
import 'package:read_right/features/app_auth/presentation/ui/auth_view.dart';
import 'package:read_right/features/app_auth/presentation/ui/widgets/auth_footer.dart';
import 'package:read_right/core/components/widgets/custom_input_field.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthView(
      formTitle: context.logInWelcome,
      form: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: context.read<LogInCubit>().formKey,
          child: Column(
            children: [
              CustomAppInputField(
                hintText: context.emailHint,
                icon: FontAwesomeIcons.solidEnvelope,
                isPassword: false,
                validationMessage: context.emailErrorHint,
                controller: context.read<LogInCubit>().emailController,
              ),
              const SizedBox(height: 16),
              CustomAppInputField(
                hintText: context.passwordHint,
                icon: FontAwesomeIcons.lock,
                validationMessage: context.passwordErrorHint,
                isPassword: true,
                controller: context.read<LogInCubit>().passwordController,
              ),
              const SizedBox(height: 24),
              BlocConsumer<LogInCubit,LogInState>(
                builder: (context,state) {
                  if(state is LogInLoadingState){
                    return CustomButton(
                      onPressed: () {},
                      label: context.logInButtonLabel,
                      isLoading: true,
                    );
                  }
                  return CustomButton(
                    onPressed: () {
                      logInAction(context);
                    },
                    label: context.logInButtonLabel,
                    isLoading: false,
                  );
                },
                listener: (context,state){
                  if(state is LogInSuccessState){
                    Navigator.pushNamed(context, AppRoutingConstances.appManager);
                  }
                  if(state is LogInErrorState){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              AuthFooter(
                clickable: context.logInFooterLabelClickable,
                notClickable: context.logInFooterLabelUnClickable,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutingConstances.signUp);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  logInAction(BuildContext context){
    if(context.read<LogInCubit>().formKey.currentState!.validate()){
      if(context.read<LogInCubit>().passwordController.text.length < 6){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.passwordLengthErrorHint),
          ),
        );
        context.read<LogInCubit>().passwordController.clear();
        return;
      }
      String email = context.read<LogInCubit>().emailController.text;
      String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
      RegExp regExp = RegExp(emailPattern);
      if (!regExp.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.emailErrorHint),
          ),
        );
        context.read<LogInCubit>().emailController.clear();
        return;
      }
      context.read<LogInCubit>().logIn(
        email: context.read<LogInCubit>().emailController.text,
        password: context.read<LogInCubit>().passwordController.text,
      );
    }
  }
}
