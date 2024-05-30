import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/tabs/favoriteListProvider/favoriteListProvider.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});
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
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return MealItem(
                meal: ref.watch(favoriteListProvider)[index],
                onSelectMeal: (meal) {
                  selectMeal(context, meal);
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 30,
                ),
            itemCount: ref.watch(favoriteListProvider).length));
  }
}
