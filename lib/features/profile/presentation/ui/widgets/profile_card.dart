import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.name, required this.email, required this.photo});

  final String name;
  final String email;
  final String photo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImages(
          photo: photo,
        ),
        SizedBox(height: 20),
        Text(
          name,
          style: AppTextStyleHelper.font24BoldBlack,
        ),
        Text(
          email,
          style: AppTextStyleHelper.font22BoldGrey,
        ),
      ],
    );
  }
}

class ProfileImages extends StatelessWidget {
  const ProfileImages({super.key, required this.photo});

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        image: DecorationImage(
          image: NetworkImage(
            photo,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
