import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/app_manager/manager/app_manager_cubit.dart';
import 'package:read_right/core/components/app_manager/manager/app_manager_states.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/theme/theme_state.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppManagerCubit, AppManagerState>(
      builder: (context, state) {
        final isMale = context.read<ThemeCubit>().state.gender.isMale;
        final selectedColor = AppColorHelper.primary(isMale: isMale);

        return Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                icon: Icons.home,
                label: context.homeViewLabel,
                isSelected: state.viewIndex == 0,
                selectedColor: selectedColor,
                onTap: () =>
                    context.read<AppManagerCubit>().changeBottomNavBarIndex(0),
              ),
              _NavBarItem(
                icon: Icons.search,
                label: context.searchViewLabel,
                isSelected: state.viewIndex == 1,
                selectedColor: selectedColor,
                onTap: () =>
                    context.read<AppManagerCubit>().changeBottomNavBarIndex(1),
              ),
              _NavBarItem(
                icon: Icons.menu_book_sharp,
                label: context.myLibraryViewLabel,
                isSelected: state.viewIndex == 2,
                selectedColor: selectedColor,
                onTap: () =>
                    context.read<AppManagerCubit>().changeBottomNavBarIndex(2),
              ),
              _NavBarItem(
                icon: Icons.person,
                label: context.profileViewLabel,
                isSelected: state.viewIndex == 3,
                selectedColor: selectedColor,
                onTap: () =>
                    context.read<AppManagerCubit>().changeBottomNavBarIndex(3),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? selectedColor : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? selectedColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
