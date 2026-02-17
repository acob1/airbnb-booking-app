import 'package:flutter/material.dart';
import '../../features/properties/presentation/screens/home_screen.dart';
import '../../features/properties/presentation/screens/search_screen.dart';
import '../../features/properties/presentation/screens/favorites_screen.dart';
import '../../features/profile/presentation/screens/account_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreenContent(),
    const SearchScreenContent(),
    const FavoritesScreenContent(),
    const AccountScreenContent(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
