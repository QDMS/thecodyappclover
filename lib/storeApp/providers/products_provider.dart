import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thecodyapp/storeApp/models/products_model.dart';

class ProductsProvider with ChangeNotifier {
  static List<ProductModel> _productsList = [];
  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      //_productsList.clear();
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
          0,
          ProductModel(
            id: element.get('id'),
            title: element.get('title'),
            imageUrl: element.get('imageUrl'),
            productCategoryName: element.get('productCategoryName'),
            price: double.parse(
              element.get('price'),
            ),
            salePrice: element.get('salePrice'),
            isOnSale: element.get('isOnSale'),
            isMonth: element.get('isMonth'),
            isPiece: element.get('isPiece'),
          ),
        );
      });
    });
    notifyListeners();
  }

  ProductModel findProdById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> _searchList = _productsList
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }

  // static final List<ProductModel> _productsList = [
  //   ProductModel(
  //     id: 'RiceKTreat',
  //     title: 'RiceKTreat',
  //     price: 20.00,
  //     salePrice: 15.49,
  //     imageUrl:
  //         'https://scontent-atl3-2.xx.fbcdn.net/v/t39.30808-6/362226455_750085513790524_6393372333997380574_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=8kxAW4pywJYAX-qbBKO&_nc_ht=scontent-atl3-2.xx&oh=00_AfDfACDjFNLh2qWjdhxWPye8myoGx4cF9z2KXzpH-IZI1g&oe=64C6C9C9',
  //     productCategoryName: 'CBD Edibles',
  //     isOnSale: true,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'LuckyTreat',
  //     title: 'LuckyTreat',
  //     price: 20.00,
  //     salePrice: 0.5,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-6/361940987_750085430457199_1295267877446176021_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=KeRpaQ2E7dEAX87iBKf&_nc_ht=scontent-atl3-1.xx&oh=00_AfBMcKQfr9lG7OUm-ANz2QQG8ALde0a3QcecV5xnZflf2Q&oe=64C6FBBA',
  //     productCategoryName: 'CBD Edibles',
  //     isOnSale: false,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'Bidi Stick Icy Mango',
  //     title: 'Bidi Stick Icy Mango',
  //     price: 1.22,
  //     salePrice: 0.7,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-6/286200898_4833415970114370_2061774705257838691_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=Bi_ytSdjPrMAX_Nqst_&_nc_ht=scontent-atl3-1.xx&oh=00_AfC1OvYcwShJda-uohGWkdsKI-8Co7mDLOyqFBfGkn2GLA&oe=64C75F7A',
  //     productCategoryName: 'Vapes',
  //     isOnSale: true,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'Numbing Cream',
  //     title: 'Numbing Cream',
  //     price: 1.5,
  //     salePrice: 0.5,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-6/362256710_750116140454128_9041801132069415996_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=m8LMxJINBUgAX_qNTqQ&_nc_ht=scontent-atl3-1.xx&oh=00_AfCpe4nvgeBKEIAsuutBPhI314FoVTJpDOewavJO6TGblQ&oe=64C5E214',
  //     productCategoryName: 'Miscellaneous',
  //     isOnSale: true,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'Kratom',
  //     title: 'Kratom',
  //     price: 0.99,
  //     salePrice: 0.4,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t1.6435-9/131294216_3230950147027635_4066293339094535870_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=sIfDl_Ws6PoAX_7k9Du&_nc_ht=scontent-atl3-1.xx&oh=00_AfDbjSzxj0VzuJCd7DNsB2UvAqmzspUxs3ISsNTAZd4YQA&oe=64E95214',
  //     productCategoryName: 'Kratom',
  //     isOnSale: false,
  //     isPiece: false,
  //     isMonth: false,
  //   ),
  //   // ProductModel(
  //   //   id: 'Dubee',
  //   //   title: 'Dubee',
  //   //   price: 0.6,
  //   //   salePrice: 0.2,
  //   //   imageUrl:
  //   //       'https://scontent-atl3-2.xx.fbcdn.net/v/t39.30808-6/241548327_3990701547719154_6092104490970547517_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=GX-1QSnpWbQAX8z2z47&_nc_ht=scontent-atl3-2.xx&oh=00_AfCPV_heNGIhvjbBKU_IniwCNTUd2pkc2NvRUPVDKda36Q&oe=64C6C09B',
  //   //   productCategoryName: 'CBD Oil & Flower',
  //   //   isOnSale: true,
  //   //   isPiece: true,
  //   //   isMonth: false,
  //   // ),
  //   ProductModel(
  //     id: 'Cody Cable',
  //     title: 'Cody Cable',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl:
  //         'https://scontent-atl3-2.xx.fbcdn.net/v/t1.6435-9/130712994_3221872271268756_4995278941265698487_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=9DGdFttDNCoAX_6Bq12&_nc_ht=scontent-atl3-2.xx&oh=00_AfDM-QVAINHPIEbHpV2dxrMjCxVLs5G4il7-4ZEEeui84A&oe=64E9353E',
  //     productCategoryName: 'Cody Cable',
  //     isOnSale: false,
  //     isPiece: false,
  //     isMonth: true,
  //   ),
  //   ProductModel(
  //     id: 'RiceKTreat',
  //     title: 'RiceKTreat',
  //     price: 0.99,
  //     salePrice: 0.49,
  //     imageUrl:
  //         'https://scontent-atl3-2.xx.fbcdn.net/v/t39.30808-6/362226455_750085513790524_6393372333997380574_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=8kxAW4pywJYAX-qbBKO&_nc_ht=scontent-atl3-2.xx&oh=00_AfDfACDjFNLh2qWjdhxWPye8myoGx4cF9z2KXzpH-IZI1g&oe=64C6C9C9',
  //     productCategoryName: 'CBD Edibles',
  //     isOnSale: true,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'LuckyTreat',
  //     title: 'LuckyTreat',
  //     price: 0.88,
  //     salePrice: 0.5,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-6/361940987_750085430457199_1295267877446176021_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=KeRpaQ2E7dEAX87iBKf&_nc_ht=scontent-atl3-1.xx&oh=00_AfBMcKQfr9lG7OUm-ANz2QQG8ALde0a3QcecV5xnZflf2Q&oe=64C6FBBA',
  //     productCategoryName: 'CBD Edibles',
  //     isOnSale: false,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'Bidi Stick Icy Mango',
  //     title: 'Bidi Stick Icy Mango',
  //     price: 1.22,
  //     salePrice: 0.7,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-6/286200898_4833415970114370_2061774705257838691_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=Bi_ytSdjPrMAX_Nqst_&_nc_ht=scontent-atl3-1.xx&oh=00_AfC1OvYcwShJda-uohGWkdsKI-8Co7mDLOyqFBfGkn2GLA&oe=64C75F7A',
  //     productCategoryName: 'Vapes',
  //     isOnSale: true,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'Numbing Cream',
  //     title: 'Numbing Cream',
  //     price: 1.5,
  //     salePrice: 0.5,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-6/362256710_750116140454128_9041801132069415996_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=m8LMxJINBUgAX_qNTqQ&_nc_ht=scontent-atl3-1.xx&oh=00_AfCpe4nvgeBKEIAsuutBPhI314FoVTJpDOewavJO6TGblQ&oe=64C5E214',
  //     productCategoryName: 'Miscellaneous',
  //     isOnSale: true,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'Kratom',
  //     title: 'Kratom',
  //     price: 0.99,
  //     salePrice: 0.4,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t1.6435-9/131294216_3230950147027635_4066293339094535870_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=sIfDl_Ws6PoAX_7k9Du&_nc_ht=scontent-atl3-1.xx&oh=00_AfDbjSzxj0VzuJCd7DNsB2UvAqmzspUxs3ISsNTAZd4YQA&oe=64E95214',
  //     productCategoryName: 'Kratom',
  //     isOnSale: false,
  //     isPiece: false,
  //     isMonth: false,
  //   ),
  //   // ProductModel(
  //   //   id: 'Dubee',
  //   //   title: 'Dubee',
  //   //   price: 0.6,
  //   //   salePrice: 0.2,
  //   //   imageUrl:
  //   //       'https://scontent-atl3-2.xx.fbcdn.net/v/t39.30808-6/241548327_3990701547719154_6092104490970547517_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=GX-1QSnpWbQAX8z2z47&_nc_ht=scontent-atl3-2.xx&oh=00_AfCPV_heNGIhvjbBKU_IniwCNTUd2pkc2NvRUPVDKda36Q&oe=64C6C09B',
  //   //   productCategoryName: 'CBD Oil & Flower',
  //   //   isOnSale: true,
  //   //   isPiece: true,
  //   //   isMonth: false,
  //   // ),
  //   ProductModel(
  //     id: 'Cody Cable',
  //     title: 'Cody Cable',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl:
  //         'https://scontent-atl3-2.xx.fbcdn.net/v/t1.6435-9/130712994_3221872271268756_4995278941265698487_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=9DGdFttDNCoAX_6Bq12&_nc_ht=scontent-atl3-2.xx&oh=00_AfDM-QVAINHPIEbHpV2dxrMjCxVLs5G4il7-4ZEEeui84A&oe=64E9353E',
  //     productCategoryName: 'Cody Cable',
  //     isOnSale: false,
  //     isPiece: false,
  //     isMonth: true,
  //   ),
  //   ProductModel(
  //     id: 'RiceKTreat',
  //     title: 'RiceKTreat',
  //     price: 0.99,
  //     salePrice: 0.49,
  //     imageUrl:
  //         'https://scontent-atl3-2.xx.fbcdn.net/v/t39.30808-6/362226455_750085513790524_6393372333997380574_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=8kxAW4pywJYAX-qbBKO&_nc_ht=scontent-atl3-2.xx&oh=00_AfDfACDjFNLh2qWjdhxWPye8myoGx4cF9z2KXzpH-IZI1g&oe=64C6C9C9',
  //     productCategoryName: 'CBD Edibles',
  //     isOnSale: true,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'LuckyTreat',
  //     title: 'LuckyTreat',
  //     price: 0.88,
  //     salePrice: 0.5,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-6/361940987_750085430457199_1295267877446176021_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=KeRpaQ2E7dEAX87iBKf&_nc_ht=scontent-atl3-1.xx&oh=00_AfBMcKQfr9lG7OUm-ANz2QQG8ALde0a3QcecV5xnZflf2Q&oe=64C6FBBA',
  //     productCategoryName: 'CBD Edibles',
  //     isOnSale: false,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'Bidi Stick Icy Mango',
  //     title: 'Bidi Stick Icy Mango',
  //     price: 1.22,
  //     salePrice: 0.7,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-6/286200898_4833415970114370_2061774705257838691_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=Bi_ytSdjPrMAX_Nqst_&_nc_ht=scontent-atl3-1.xx&oh=00_AfC1OvYcwShJda-uohGWkdsKI-8Co7mDLOyqFBfGkn2GLA&oe=64C75F7A',
  //     productCategoryName: 'Vapes',
  //     isOnSale: true,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'Numbing Cream',
  //     title: 'Numbing Cream',
  //     price: 1.5,
  //     salePrice: 0.5,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-6/362256710_750116140454128_9041801132069415996_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=m8LMxJINBUgAX_qNTqQ&_nc_ht=scontent-atl3-1.xx&oh=00_AfCpe4nvgeBKEIAsuutBPhI314FoVTJpDOewavJO6TGblQ&oe=64C5E214',
  //     productCategoryName: 'Miscellaneous',
  //     isOnSale: true,
  //     isPiece: true,
  //     isMonth: false,
  //   ),
  //   ProductModel(
  //     id: 'Kratom',
  //     title: 'Kratom',
  //     price: 0.99,
  //     salePrice: 0.4,
  //     imageUrl:
  //         'https://scontent-atl3-1.xx.fbcdn.net/v/t1.6435-9/131294216_3230950147027635_4066293339094535870_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=sIfDl_Ws6PoAX_7k9Du&_nc_ht=scontent-atl3-1.xx&oh=00_AfDbjSzxj0VzuJCd7DNsB2UvAqmzspUxs3ISsNTAZd4YQA&oe=64E95214',
  //     productCategoryName: 'Kratom',
  //     isOnSale: false,
  //     isPiece: false,
  //     isMonth: false,
  //   ),
  //   // ProductModel(
  //   //   id: 'Dubee',
  //   //   title: 'Dubee',
  //   //   price: 0.6,
  //   //   salePrice: 0.2,
  //   //   imageUrl:
  //   //       'https://scontent-atl3-2.xx.fbcdn.net/v/t39.30808-6/241548327_3990701547719154_6092104490970547517_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=GX-1QSnpWbQAX8z2z47&_nc_ht=scontent-atl3-2.xx&oh=00_AfCPV_heNGIhvjbBKU_IniwCNTUd2pkc2NvRUPVDKda36Q&oe=64C6C09B',
  //   //   productCategoryName: 'CBD Oil & Flower',
  //   //   isOnSale: true,
  //   //   isPiece: true,
  //   //   isMonth: false,
  //   // ),
  //   ProductModel(
  //     id: 'Cody Cable',
  //     title: 'Cody Cable',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl:
  //         'https://scontent-atl3-2.xx.fbcdn.net/v/t1.6435-9/130712994_3221872271268756_4995278941265698487_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=9DGdFttDNCoAX_6Bq12&_nc_ht=scontent-atl3-2.xx&oh=00_AfDM-QVAINHPIEbHpV2dxrMjCxVLs5G4il7-4ZEEeui84A&oe=64E9353E',
  //     productCategoryName: 'Cody Cable',
  //     isOnSale: false,
  //     isPiece: false,
  //     isMonth: true,
  //   ),
  // ];
}
