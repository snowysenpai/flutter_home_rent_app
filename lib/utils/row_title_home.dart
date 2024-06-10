import 'package:flutter/material.dart';
import 'package:home_rent/utils/color.dart';

class RowTitleHome extends StatelessWidget {
  final VoidCallback onPress;
  final String title, subtitle;

  const RowTitleHome(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.black),
        ),
        InkWell(
          onTap: onPress,
          child: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColors.textPrimary, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
