import 'package:flutter/material.dart';
import 'package:read_right/core/helpers/image_helper.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';

class AuthView extends StatelessWidget {
  const AuthView({
    super.key,
    required this.formTitle,
    required this.form,
  });

  final String formTitle;
  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Image.asset(
              AppImageHelper.authImage,
              width: double.infinity,
              height: 300,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              formTitle,
              style:
                  AppTextStyleHelper.font22BoldPrimary(context, isStart: true),
            ),
            const SizedBox(
              height: 20,
            ),
            form,
          ],
        ),
      ),
    );
  }
}
