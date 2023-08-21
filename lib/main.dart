import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider;
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/common/widgets/error.dart';
import 'package:thecodyapp/chatApp/common/widgets/loader.dart';
import 'package:thecodyapp/chatApp/features/auth/controller/auth_controller.dart';
import 'package:thecodyapp/chatApp/responsive/responsive_layout.dart';
import 'package:thecodyapp/chatApp/screens/mobile_chat_screen_layout.dart';
import 'package:thecodyapp/chatApp/screens/web_screen_layout.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/firebase_options.dart';
import 'package:thecodyapp/intro_screen.dart';
import 'package:thecodyapp/router.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/inner_screens/cat_screen.dart';
import 'package:thecodyapp/storeApp/inner_screens/feeds_screen.dart';
import 'package:thecodyapp/storeApp/inner_screens/on_sale_screen.dart';
import 'package:thecodyapp/storeApp/inner_screens/product_details.dart';
import 'package:thecodyapp/storeApp/providers/dark_theme_provider.dart';
import 'package:thecodyapp/storeApp/providers/cart_provider.dart';
import 'package:thecodyapp/storeApp/providers/orders_provider.dart';
import 'package:thecodyapp/storeApp/providers/products_provider.dart';
import 'package:thecodyapp/storeApp/providers/viewed_provider.dart';
import 'package:thecodyapp/storeApp/providers/wishlist_provider.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeLogin.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeRegister.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeforgot_pass.dart';
import 'package:thecodyapp/storeApp/screens/fetch_screen.dart';
import 'package:thecodyapp/storeApp/screens/home_screen.dart';
import 'package:thecodyapp/storeApp/screens/orders/orders_screen.dart';
import 'package:thecodyapp/storeApp/screens/payment/iframe.dart';
import 'package:thecodyapp/storeApp/screens/payment/success.dart';
import 'package:thecodyapp/storeApp/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:thecodyapp/storeApp/screens/wishlist/wishlist_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final Future<FirebaseApp> _firebaseInitializtion = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData.dark();
    final User? user = authInstance.currentUser;
    return FutureBuilder(
        future: _firebaseInitializtion,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Loader(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const ErrorScreen(error: 'An Error Occurred !!!');
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ProductsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => WishlistProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ViewedProductProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'The Cody App',
              theme: base.copyWith(
                  scaffoldBackgroundColor: backgroundColor,
                  textSelectionTheme: const TextSelectionThemeData(
                      selectionHandleColor: tabLabelColor),
                  colorScheme: const ColorScheme.dark(
                    background: backgroundColor,
                  )),
              onGenerateRoute: (settings) => generateRoute(settings),
              home: const StoreLoginScreen(),
              // ref.watch(userDataAuthProvider).when(
              //       data: (user) {
              //         if (user == null) {
              //           return const IntroScreen();
              //         }
              //         return const ResponsiveLayoutScreen(
              //           mobileScreenLayout: MobileChatScreenLayout(),
              //           webScreenLayout: WebScreenLayout(),
              //         );
              //       },
              //       error: (err, trace) {
              //         return ErrorScreen(
              //           error: err.toString(),
              //         );
              //       },
              //       loading: () => const Loader(),
              //     ),
              routes: {
                OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
                ThankYouPage.routeName: (ctx) => const ThankYouPage(),
                CheckoutMethodBank.routeName: (ctx) =>
                    const CheckoutMethodBank(),
                FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                ProductDetails.routeName: (ctx) => const ProductDetails(),
                CategoryScreen.routeName: (ctx) => const CategoryScreen(),
                WishlistScreen.routeName: (ctx) => const WishlistScreen(),
                OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                ViewedRecentlyScreen.routeName: (ctx) =>
                    const ViewedRecentlyScreen(),
                HomeScreen.routeName: (ctx) => const HomeScreen(),
                StoreLoginScreen.routeName: (ctx) => const StoreLoginScreen(),
                StoreRegisterScreen.routeName: (ctx) =>
                    const StoreRegisterScreen(),
                StoreForgetPasswordScreen.routeName: (ctx) =>
                    const StoreForgetPasswordScreen(),
                ResponsiveLayoutScreen.routeName: (ctx) =>
                    const ResponsiveLayoutScreen(
                      mobileScreenLayout: MobileChatScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    ),
              },
            ),
          );
        });
  }
}
