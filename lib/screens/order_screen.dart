import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samip_grubrr/model/order_model.dart';
import 'package:samip_grubrr/utils/base_extension.dart';

import '../blocs/order/order_bloc_cubit.dart';
import '../utils/base_colors.dart';
import '../utils/base_strings.dart';
import '../widgets/platform_indicator.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late final OrderBlocCubit orderBlocCubit;

  @override
  void initState() {
    orderBlocCubit = BlocProvider.of<OrderBlocCubit>(context)..getData();
    super.initState();
  }

  @override
  void dispose() {
    orderBlocCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Order'),
        centerTitle: true,
        toolbarHeight: 86,
        backgroundColor: BaseColors.orange,
        elevation: 0,
      ),
      body: BlocBuilder<OrderBlocCubit, OrderBlocState>(
        builder: (context, state) {
          if (state is GetDataInProgress) {
            return const PlatformIndicator(showMessage: false);
          } else if (state is FailedState) {
            return state.failMessage.noDataError;
          } else if (state is GetDataCompleted) {
            return state.data.isEmpty
                ? BaseStrings.cartIsEmpty.noDataError
                : DataTable(
                    dataRowHeight: 150,
                    columnSpacing: 10,
                    headingRowHeight: 50,
                    columns: [
                      buildDataColumn('Item'),
                      buildDataColumn('Qty'),
                      buildDataColumn('Price'),
                    ],
                    rows: List.generate(state.data.length, (index) {
                      final item = state.data[index];

                      return buildDataRow(item);
                    }),
                  );
          } else {
            '$state is state'.toErrorLog;
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  DataRow buildDataRow(OrderModel item) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Image(
                image: NetworkImage(item.itemImageUrl),
                width: 80,
              ),
              10.0.toHSB,
              Expanded(
                child: Text(
                  item.itemName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  context.read<OrderBlocCubit>().addToCart(
                        item.copyWith(isDecrease: true),
                        isRefresh: true,
                      );
                },
                color: BaseColors.orange,
                visualDensity: VisualDensity.compact,
              ),
              Text('${item.quantity}'),
              IconButton(
                icon: const Icon(Icons.add),
                color: BaseColors.orange,
                onPressed: () {
                  context.read<OrderBlocCubit>().addToCart(
                        item,
                        isRefresh: true,
                      );
                },
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              const Spacer(),
              Text('\$${item.itemPrice}'),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_forever_outlined),
                color: BaseColors.orange,
                visualDensity: VisualDensity.compact,
                onPressed: () =>
                    context.read<OrderBlocCubit>().deleteOrderItem(item),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }

  DataColumn buildDataColumn(String data) => DataColumn(
        label: Expanded(
          child: Text(
            data.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: BaseColors.orange,
            ),
          ),
        ),
      );
}
