import 'package:flutter/material.dart';
import 'package:meals_app/data/category_list.dart';
import 'package:meals_app/widgets/category_widget.dart';

class CategoriesScreeen extends StatefulWidget {
  const CategoriesScreeen({super.key});

  @override
  State<CategoriesScreeen> createState() => _CategoriesScreeenState();
}

class _CategoriesScreeenState extends State<CategoriesScreeen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          padding: EdgeInsets.all(20),
          itemBuilder: (context, index) {
            // return CategoryWidget(category: categoryList[index]);
            return AnimatedBuilder(
              animation: _animationController,
              child: CategoryWidget(category: categoryList[index]),
              builder: (context, child) {
                return SlideTransition(
                  position: Tween(
                    begin: Offset(0, 0.5),
                    end: Offset(0, 0),
                  ).animate(CurvedAnimation(
                      parent: _animationController, curve: Curves.easeInOut)),
                  child: child,
                );
              },
            );
          },
          itemCount: categoryList.length,
        ));
  }
}
