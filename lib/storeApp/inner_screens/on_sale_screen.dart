import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/screens/mobile_chat_screen_layout.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/consts/utils.dart';
import 'package:thecodyapp/storeApp/models/products_model.dart';
import 'package:thecodyapp/storeApp/providers/products_provider.dart';
import 'package:thecodyapp/storeApp/widgets/empty_products_screen.dart';
import 'package:thecodyapp/storeApp/widgets/on_sale_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 0.25,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: tabLabelColor,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: IconButton(
          //       icon: const Icon(
          //         IconlyLight.chat,
          //         color: tabLabelColor,
          //         size: 24,
          //       ),
          //       onPressed: () => Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const MobileChatScreenLayout(),
          //         ),
          //       ),
          //     ),
          //   ),
          // ],
          title: const Text('Products On Sale'),
        ),
        body: productsOnSale.isEmpty
            ? const EmptyProdWidget(text: 'No Products On Sale Yet!\nStay Tuned',)
            : GridView.count(
                
                crossAxisCount: 2,
                // crossAxisSpacing: 15,
                childAspectRatio: size.width / (size.height * 0.45),
                children: List.generate(productsOnSale.length, (index) {
                  return ChangeNotifierProvider.value(
                    value: productsOnSale[index],
                    child: const OnSaleWidget());
                }),
              ));
  }
}
