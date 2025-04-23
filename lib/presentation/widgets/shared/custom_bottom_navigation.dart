import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
    final StatefulNavigationShell shell;

  const CustomBottomNavigation({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: shell.goBranch,
      currentIndex: shell.currentIndex,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
