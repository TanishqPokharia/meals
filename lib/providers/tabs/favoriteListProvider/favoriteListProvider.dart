import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

final favoriteListProvider =
    StateNotifierProvider<FavoriteListNotifier, List<Meal>>((ref) {
  return FavoriteListNotifier();
});

class FavoriteListNotifier extends StateNotifier<List<Meal>> {
  FavoriteListNotifier() : super([]);

  void addMeal(Meal meal) {
    state = [...state, meal];
  }

  void removeMeal(Meal meal) {
    state = List.from(state)..remove(meal);
  }
}
