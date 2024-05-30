import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/meals_list.dart';
import 'package:meals_app/models/meal.dart';

final mealsProvider =
    StateNotifierProvider<MealsStateNotifier, List<Meal>>((ref) {
  return MealsStateNotifier();
});

class MealsStateNotifier extends StateNotifier<List<Meal>> {
  MealsStateNotifier() : super(dummyMeals);

  void filter(
      {bool isGlutenFree = false,
      bool isLactoseFree = false,
      bool isVeg = false,
      bool isVegan = false}) {
    print(state.length);
    state = dummyMeals.where((meal) {
      if (isGlutenFree && !meal.isGlutenFree) {
        return false;
      }
      if (isLactoseFree && !meal.isLactoseFree) {
        return false;
      }
      if (isVeg && !meal.isVegetarian) {
        return false;
      }
      if (isVegan && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    print(state.length);
    print("done");
  }
}
