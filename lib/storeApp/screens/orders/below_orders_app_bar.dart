import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/providers/orders_provider.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class BelowOrdersAppBar extends StatelessWidget {
  const BelowOrdersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
     final ordersProvider = Provider.of<OrdersProvider>(context);
       final ordersList = ordersProvider.getOrders;
    return Container(
     color: appBarColor,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextWidget(
            text: 'Your Orders (${ordersList.length})',
            color: tabLabelColor,
            textSize: 24,
            isTitle: true,
                  ),
          ),
        ],
      ),
    );
  }
}
