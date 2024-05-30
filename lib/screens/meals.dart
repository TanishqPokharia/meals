import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;
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

  Widget content(List<Meal> meals, context) {
    if (meals.isEmpty) {
      return Container(
        margin: EdgeInsets.all(10),
        child: Text(
          "Nothing here! Try browsing a different category",
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 30,
        ),
        itemBuilder: (context, index) {
          return MealItem(
            meal: meals[index],
            onSelectMeal: (meal) {
              selectMeal(context, meal);
            },
          );
        },
        itemCount: meals.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          foregroundColor: Colors.white,
          title: Text(
            title,
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: content(meals, context),
        ));
  }
}
