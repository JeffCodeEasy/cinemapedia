import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  final StatefulNavigationShell shell;
  // final Widget childView;
  const HomeScreen({
    super.key,
    // required this.childView,
    required this.shell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar:  CustomBottomNavigation(
        shell: shell,
      ),
    );
  }
}
