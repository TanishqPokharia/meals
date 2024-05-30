import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/tabs/screenIndexProvider/screenIndexProvider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/favorites.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/widgets/meal_item.dart';

class TabsScreen extends ConsumerWidget {
  const TabsScreen({super.key});
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
            position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                .animate(
                    CurvedAnimation(parent: animation, curve: Curves.ease)),
            child: child);
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return MealDetailsScreen(meal: meal);
      },
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreenIndex = ref.watch(screenIndexProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(screenIndexProvider) == 0
            ? "Categories"
            : "Your Favorites"),
        foregroundColor: Colors.white,
        backgroundColor: currentScreenIndex == 0
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.tertiary,
      ),
      drawer: MainDrawer(),
      body: currentScreenIndex == 0 ? CategoriesScreeen() : FavoritesScreen(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          ref.read(screenIndexProvider.notifier).state = value;
        },
        type: BottomNavigationBarType.shifting,
        currentIndex: ref.watch(screenIndexProvider),
        selectedIconTheme: IconThemeData(size: 30),
        selectedFontSize: 16,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.grey.shade800,
              icon: const Icon(
                Icons.set_meal,
              ),
              label: "Categories"),
          BottomNavigationBarItem(
              backgroundColor: Colors.grey.shade800,
              icon: const Icon(
                Icons.star,
              ),
              label: "Favorites"),
        ],
      ),
    );
  }
}
