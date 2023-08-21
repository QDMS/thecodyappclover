import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/screens/mobile_chat_screen_layout.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';

import 'package:thecodyapp/storeApp/consts/utils.dart';
import 'package:thecodyapp/storeApp/models/products_model.dart';
import 'package:thecodyapp/storeApp/providers/products_provider.dart';
import 'package:thecodyapp/storeApp/widgets/empty_products_screen.dart';
import 'package:thecodyapp/storeApp/widgets/feed_items.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreen";
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> listProductsSearch = [];
  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    Size size = Utils(context).getScreenSize;
    final productsProviders = Provider.of<ProductsProvider>(context);
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productByCat = productsProviders.findByCategory(catName);
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
        //         size: 30,
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
        title: TextWidget(
          text: catName,
          color: Colors.white,
          textSize: 20,
        ),
      ),
      body: productByCat.isEmpty
          ? const EmptyProdWidget(
              text: 'No Products Belong To This Category Yet!\nStay Tuned',
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextField(
                        focusNode: _searchTextFocusNode,
                        cursorColor: Colors.black,
                        controller: _searchTextController,
                        onChanged: (value) {
                          setState(() {
                            listProductsSearch =
                                productsProviders.searchQuery(value);
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: tabColor, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: tabLabelColor, width: 1),
                          ),
                          contentPadding: const EdgeInsets.only(top: 0),
                          prefixIcon: Icon(
                            IconlyLight.search,
                            color: _searchTextFocusNode.hasFocus
                                ? tabColor
                                : tabLabelColor,
                          ),
                          hintStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.only(top: 0),
                            icon: Icon(
                              Icons.cancel,
                              color: _searchTextFocusNode.hasFocus
                                  ? tabColor
                                  : tabLabelColor,
                            ),
                            onPressed: () {
                              _searchTextController.clear();
                              _searchTextFocusNode.unfocus();
                            },
                          ),
                          hintText: "Search Cody Products",
                        ),
                      ),
                    ),
                  ),
                  _searchTextController.text.isNotEmpty &&
                          listProductsSearch.isEmpty
                      ? EmptyProdWidget(
                          text: 'No Product Found Please Try Another Keyword')
                      : GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          // crossAxisSpacing: 15,
                          childAspectRatio: size.width / (size.height * 0.55),
                          children: List.generate(
                            _searchTextController.text.isNotEmpty
                                ? listProductsSearch.length
                                : productByCat.length,
                            (index) {
                              return ChangeNotifierProvider.value(
                                value: _searchTextController.text.isNotEmpty
                                    ? listProductsSearch[index]
                                    : productByCat[index],
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
