import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/tabs/favoriteListProvider/favoriteListProvider.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/favorite_icon_widget.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: FittedBox(child: Text(meal.title)),
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          foregroundColor: Colors.white,
          actions: [
            FavoriteButton(
              onPressed: () {
                if (ref.watch(favoriteListProvider).contains(meal)) {
                  ref.read(favoriteListProvider.notifier).removeMeal(meal);
                } else {
                  ref.read(favoriteListProvider.notifier).addMeal(meal);
                }
              },
              color: ref.watch(favoriteListProvider).contains(meal)
                  ? Colors.pink
                  : Colors.grey.shade500,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: ValueKey("hero-food-image-${meal.id}"),
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ...meal.ingredients.map((e) => Text(e)),
              SizedBox(
                height: 10,
              ),
              Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ...meal.steps.indexed.map((e) => Container(
                    margin: EdgeInsets.all(15),
                    child: Text("${e.$1}. ${e.$2}")))
              ])
            ],
          ),
        ));
  }
}
