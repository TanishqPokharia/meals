import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/meals_list.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/providers/meals/mealsProvider/mealsProvider.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FittedBox(
              fit: BoxFit.cover,
              child: FadeInImage(
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(category.imageUrl)),
            )),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: category.color.withOpacity(0.65)),
        ),
        Text(
          category.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 200), () {
                //filter the rrespective category meal
                final filteredList = ref
                    .watch(mealsProvider)
                    .where((meal) => meal.categories.contains(category.id))
                    .toList();

                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: const Offset(0, 0))
                          .animate(CurvedAnimation(
                              curve: Curves.ease, parent: animation)),
                      child: MealsScreen(
                          title: category.title, meals: filteredList),
                    );
                  },
                ));
              });
            },
            splashColor: category.color,
            highlightColor: category.color,
            borderRadius: BorderRadius.circular(10),
          ),
        )
      ],
    );
  }
}
