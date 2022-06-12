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
    //todo close it
    // orderBlocCubit.close();
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
            return const PlatformIndicator(
              showMessage: false,
            );
          } else if (state is GetDataFailed) {
            return BaseStrings.cartIsEmpty.noDataError;
          } else if (state is GetDataCompleted) {
            return DataTable(
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
                width: 100,
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
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                // todo add
              },
              color: BaseColors.orange,
            ),
            Text('${item.quantity}'),
            IconButton(
              icon: const Icon(Icons.add),
              color: BaseColors.orange,
              onPressed: () {
                // todo remove
              },
            ),
          ],
        )),
        DataCell(
          Text('\$${item.itemPrice}'),
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
