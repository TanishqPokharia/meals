import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters/glutenFilterProvider/glutenFilterPovider.dart';
import 'package:meals_app/providers/filters/lactoseFilterProvider/lactoseFilterProvider.dart';
import 'package:meals_app/providers/filters/veganFilterProvider/veganFilterProvider.dart';
import 'package:meals_app/providers/filters/vegFilterProvider/vegFilterProvider.dart';

enum Filter { glutenFree, lactoseFree, veg, vegan }

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      appBar: AppBar(
        title: Text("Your Filters"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: ref.read(glutenFilteProvider),
            Filter.lactoseFree: ref.read(lactoseFilterProvider),
            Filter.vegan: ref.read(veganFilterProvider),
            Filter.veg: ref.read(vegFilterProvider)
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: ref.watch(glutenFilteProvider),
              onChanged: (isChecked) {
                ref.read(glutenFilteProvider.notifier).state = isChecked;
              },
              title: Text(
                "Gluten-free",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              subtitle: Text(
                "Only include gluten-free meals.",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              activeColor: Theme.of(context).colorScheme.onTertiary,
              contentPadding: EdgeInsets.all(20),
            ),
            SwitchListTile(
              value: ref.watch(lactoseFilterProvider),
              onChanged: (isChecked) {
                ref.read(lactoseFilterProvider.notifier).state = isChecked;
              },
              title: Text(
                "Lactose-free",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              subtitle: Text(
                "Only include lactose-free meals.",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              activeColor: Theme.of(context).colorScheme.onTertiary,
              contentPadding: EdgeInsets.all(20),
            ),
            SwitchListTile(
              value: ref.watch(vegFilterProvider),
              onChanged: (isChecked) {
                ref.read(vegFilterProvider.notifier).state = isChecked;
              },
              title: Text(
                "Veg",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              subtitle: Text(
                "Only include vegetarian meals.",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              activeColor: Theme.of(context).colorScheme.onTertiary,
              contentPadding: EdgeInsets.all(20),
            ),
            SwitchListTile(
              value: ref.watch(veganFilterProvider),
              onChanged: (isChecked) {
                ref.read(veganFilterProvider.notifier).state = isChecked;
              },
              title: Text(
                "Vegan",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              subtitle: Text(
                "Only include vegan meals.",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              activeColor: Theme.of(context).colorScheme.onTertiary,
              contentPadding: EdgeInsets.all(20),
            )
          ],
        ),
      ),
    );
  }
}
