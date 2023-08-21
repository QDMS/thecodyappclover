import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/consts/constss.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/consts/utils.dart';
import 'package:thecodyapp/storeApp/inner_screens/feeds_screen.dart';
import 'package:thecodyapp/storeApp/inner_screens/on_sale_screen.dart';
import 'package:thecodyapp/storeApp/models/products_model.dart';
import 'package:thecodyapp/storeApp/providers/products_provider.dart';
import 'package:thecodyapp/storeApp/widgets/feed_items.dart';
import 'package:thecodyapp/storeApp/widgets/on_sale_widget.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Constss.offerImages[index],
                    fit: BoxFit.cover,
                  );
                },
                autoplay: true,
                duration: 1000,
                itemCount: Constss.offerImages.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: tabLabelColor,
                    activeColor: tabColor,
                  ),
                ),
                // control: SwiperControl(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {
                GlobalMethods.navigateTo(
                    ctx: context, routeName: OnSaleScreen.routeName);
              },
              child: TextWidget(
                text: 'View All',
                color: tabLabelColor,
                textSize: 20,
                maxLines: 1,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'On Sale'.toUpperCase(),
                        color: tabColor,
                        textSize: 25,
                        isTitle: true,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        IconlyLight.discount,
                        color: tabColor,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.24,
                    child: ListView.builder(
                      itemCount: productsOnSale.length < 10 ? productsOnSale.length : 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return ChangeNotifierProvider.value(
                            value: productsOnSale[index],
                            child: const OnSaleWidget());
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                      text: 'Cody Products',
                      color: Colors.white,
                      textSize: 25,
                      isTitle: true,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: FeedsScreen.routeName);
                    },
                    child: TextWidget(
                      text: 'Browse All',
                      color: tabLabelColor,
                      textSize: 20,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              // crossAxisSpacing: 15,
              childAspectRatio: size.width / (size.height * 0.6),
              children: List.generate(
                allProducts.length < 4 ? allProducts.length : 4,
                (index) {
                  return ChangeNotifierProvider.value(
                    value: allProducts[index],
                    child: const FeedsWidget(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
