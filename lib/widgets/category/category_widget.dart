import 'package:flutter/material.dart';
import 'package:missan_app/miscellaneous/common.dart';
import 'package:missan_app/models/api.dart';
import 'package:missan_app/widgets/category/category_list_widget.dart';

// ignore: must_be_immutable
class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({super.key});
  List<AssetImage> sharedImages = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: Category.allCategories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 0,
      ),
      itemBuilder: (BuildContext context, int index) {
        Category listItems = Category.allCategories[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(createRoute(CategoryList(
              categoryId: listItems.id,
              categoryName: listItems.name,
            )));
          },
          child: SizedBox(
            height: 50,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: const Color.fromARGB(255, 241, 230, 190),
                    backgroundImage: listItems.image,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    listItems.name,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ]),
          ),
        );
      },
    );
  }
}
