import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samip_grubrr/blocs/category_bloc/category_bloc.dart';
import 'package:samip_grubrr/blocs/item/items_bloc.dart';
import 'package:samip_grubrr/model/category_model.dart';
import 'package:samip_grubrr/utils/base_colors.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:samip_grubrr/utils/base_methods.dart';
import 'package:samip_grubrr/utils/base_strings.dart';
import 'package:samip_grubrr/utils/base_styles.dart';
import 'package:samip_grubrr/utils/routes.dart';
import 'package:samip_grubrr/widgets/custom_buttons.dart';
import 'package:samip_grubrr/widgets/item_page_view.dart';

import '../widgets/platform_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController pageController;
  late final CategoryBloc categoryBloc;
  late final ItemsBloc itemBloc;

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    itemBloc = BlocProvider.of<ItemsBloc>(context);
    categoryBloc.add(LoadCategories());
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    categoryBloc.close();
    itemBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  /// build category items

                  buildCategoryList,
                  Expanded(
                    child: PageView.builder(
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return FoodItemPageView(
                          index: index + 1,
                          itemBloc: itemBloc,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HomePageButton(
                      callback: () {
                        Navigator.pushNamed(context, Routes.order);
                      },
                      name: BaseStrings.checkout,
                      backgroundColor: Colors.amber,
                      textColor: BaseColors.black,
                      padding: const EdgeInsets.all(14.0),
                    ),
                    5.0.toVSB,
                    HomePageButton(
                      callback: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.screenSaver, (route) => false);
                      },
                      name: BaseStrings.cancelOrder,
                      backgroundColor: Colors.grey.shade300,
                      textColor: Colors.grey.shade600, //BaseColors.greyLight,
                      padding: const EdgeInsets.all(8.0),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get buildCategoryList {
    return BlocConsumer<CategoryBloc, CategoryState>(
      bloc: categoryBloc,
      listener: (context, state) {
        // if (state is LoadCategoriesCompleted) {
        //   categoryBloc.add(SelectedCategory(
        //       state.categoryList, state.categoryList[initialPage].id));
        // }
        if (state is LoadCategoriesCompleted) {
          pageController
              .animateToPage(
                state.pageViewIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              )
              .then((value) =>
                  itemBloc.add(LoadCategoryItems(state.selectedCategoryId)));
          // itemBloc.add(LoadCategoryItems(state.selectedCategoryId));
        }
      },
      buildWhen: (previous, current) {
        return current is LoadCategoriesInProgress ||
            current is LoadCategoriesCompleted ||
            current is LoadCategoriesFailed;
      },
      builder: (context, state) {
        if (state is LoadCategoriesInProgress) {
          return const PlatformIndicator(
            showMessage: false,
          );
        } else if (state is LoadCategoriesCompleted) {
          List<Category> list = state.categoryList;
          // if (state is LoadCategoriesCompleted) {
          //   list = state.categoryList;
          // } else if (state is SelectedCategoryCompleted) {
          //   list = state.categoryList;
          // }
          return SizedBox(
            width: 0.26.sw,
            child: ListView.builder(
              itemCount: list.length,
              padding: const EdgeInsets.all(14.0),
              itemBuilder: (context, index) {
                final item = list[index];
                return buildCategory(
                  category: item,
                  isSelected: index == state.pageViewIndex,
                  onTap: () {
                    categoryBloc.add(SelectedCategory(list, item.id));
                  },
                );
              },
            ),
          );
        } else if (state is LoadCategoriesFailed) {
          return BaseStrings.categoryLoadingFailed.noDataError;
        } else {
          '$state is state'.toErrorLog;
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget buildCategory({
    required VoidCallback onTap,
    required Category category,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: BaseColors.transparent,
        highlightColor: BaseColors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(category.imageLink),
                  loadingBuilder: customLoadingBuilder,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
                if (!isSelected)
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: BaseColors.grey.withOpacity(0.5)),
                    ),
                  ),
              ],
            ),
            12.0.toVSB,
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: BaseStyles.categoryNameText.copyWith(
                color: isSelected ? BaseColors.amber : BaseColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
