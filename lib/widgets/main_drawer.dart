import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals/mealsProvider/mealsProvider.dart';
import 'package:meals_app/screens/filters.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Row(
              children: [
                Icon(Icons.fastfood,
                    size: 48, color: Theme.of(context).colorScheme.primary),
                SizedBox(
                  width: 18,
                ),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            title: Text(
              "Meal",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondaryContainer),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.filter_alt,
              size: 26,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            title: Text(
              "Filters",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondaryContainer),
            ),
            onTap: () async {
              final result = await Navigator.of(context)
                  .push<Map<Filter, bool>>(
                      MaterialPageRoute(builder: (context) => FiltersScreen()));

              ref.read(mealsProvider.notifier).filter(
                  isGlutenFree: result![Filter.glutenFree]!,
                  isLactoseFree: result[Filter.lactoseFree]!,
                  isVeg: result[Filter.veg]!,
                  isVegan: result[Filter.vegan]!);
            },
          )
        ],
      ),
    );
  }
}
