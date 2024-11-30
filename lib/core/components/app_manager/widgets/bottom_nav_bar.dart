import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/app_manager/manager/app_manager_cubit.dart';
import 'package:read_right/core/components/app_manager/manager/app_manager_states.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppManagerCubit,AppManagerState>(
      builder: (context,state) {
        return BottomNavigationBar(
          currentIndex: state.viewIndex,
          selectedItemColor: AppColorHelper.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          iconSize: 28,
          onTap: (int index) {
            context.read<AppManagerCubit>().changeBottomNavBarIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: context.homeViewLabel,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: context.searchViewLabel,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu_book_sharp),
              label: context.myLibraryViewLabel,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: context.profileViewLabel,
            ),
          ],
        );
      }
    );
  }
}
