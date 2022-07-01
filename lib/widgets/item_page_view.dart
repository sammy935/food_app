import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samip_grubrr/blocs/item/items_bloc.dart';
import 'package:samip_grubrr/model/food_item_model.dart';
import 'package:samip_grubrr/model/order_model.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:samip_grubrr/utils/base_images.dart';
import 'package:samip_grubrr/utils/base_strings.dart';
import 'package:samip_grubrr/utils/base_styles.dart';
import 'package:samip_grubrr/widgets/platform_indicator.dart';

import '../blocs/order/order_bloc_cubit.dart';

class FoodItemPageView extends StatelessWidget {
  const FoodItemPageView(
      {Key? key, required this.index, required this.itemBloc})
      : super(key: key);

  final int index;
  final ItemsBloc itemBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
        bloc: itemBloc,
        builder: (context, state) {
          // '$state is ths item bloc '.toLog;

          if (state is LoadCategoryItemsInProgress) {
            return const PlatformIndicator(
              showMessage: false,
            );
          } else if (state is LoadCategoryItemsCompleted) {
            List<FoodItem> list = state.itemList;

            return list.isNotEmpty
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 50 / 86,
                    ),
                    shrinkWrap: true,
                    itemCount: list.length,
                    padding: const EdgeInsets.all(14.0),
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return buildFoodItem(item, context);
                    },
                  )
                : BaseStrings.noItemsFoundForCategory.noDataError;
          } else if (state is LoadCategoryItemsFailed) {
            return BaseStrings.foodItemLoadingFailed.noDataError;
          } else {
            '$state is state'.toErrorLog;
            return const SizedBox.shrink();
          }
        });
  }

  Widget buildFoodItem(FoodItem foodItem, BuildContext context) {
    // '${foodItem.name}${foodItem.price}${foodItem.imageLink}'.toLog;

    return InkWell(
      onTap: () {
        //todo check regarding category name and id
        final order = OrderModel(
          itemId: foodItem.id,
          itemImageUrl: foodItem.imageLink,
          itemName: foodItem.name,
          itemPrice: foodItem.price,
          quantity: 1,
          orderTotal: 0.0,
          categoryId: 1,
          categoryName: '',
          // isDecrement: true,
        );
        context.read<OrderBlocCubit>().addToCart(order);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // FadeInImage(image: NetworkImage(foodItem.imageLink), placeholder: ,),
          FadeInImage(
            image: NetworkImage(foodItem.imageLink),
            placeholder: const AssetImage(BaseImages.shimmer),
            fit: BoxFit.contain,
            height: 150,
          ),
          Text(
            foodItem.name.toUpperCase(),
            style: BaseStyles.foodNameText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          5.0.toVSB,
          Text(
            '\$${foodItem.price.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: BaseStyles.foodPriceText,
          ),
        ],
      ),
    );
  }
}
