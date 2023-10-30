import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/home/views/category/category_view.dart';
import 'package:kvn_farm_rich/app/modules/home/views/profile/edit_profile.dart';
import 'package:kvn_farm_rich/app/modules/my_team/bindings/my_team_binding.dart';
import 'package:kvn_farm_rich/app/modules/my_team/views/assigned_route_list.dart';
import 'package:kvn_farm_rich/app/modules/my_team/views/my_team_assign_shop.dart';
import 'package:kvn_farm_rich/app/modules/my_team/views/my_team_view.dart';
import 'package:kvn_farm_rich/app/modules/order_history/views/my_order.dart/my_order.dart';
import 'package:kvn_farm_rich/app/modules/place/bindings/place_binding.dart';
import 'package:kvn_farm_rich/app/modules/place/views/place_view.dart';
import 'package:kvn_farm_rich/app/modules/shops/views/shop_edit.dart';
import 'package:kvn_farm_rich/app/modules/shops/views/shop_profile.dart';

import '../modules/add_payment/bindings/add_payment_binding.dart';
import '../modules/add_payment/views/add_payment_view.dart';
import '../modules/add_products/bindings/add_products_binding.dart';
import '../modules/add_products/views/add_products_view.dart';
import '../modules/attendance_report/bindings/attendance_report_binding.dart';
import '../modules/attendance_report/views/attendance_report_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/expiry_products/bindings/expiry_products_binding.dart';
import '../modules/expiry_products/views/expiry_products_view.dart';
import '../modules/expiry_products/views/product_details_page.dart';
import '../modules/expiry_products/views/product_transfer_view.dart';
import '../modules/expiry_products/views/shop_details_page.dart';
import '../modules/google_map/bindings/google_map_binding.dart';
import '../modules/google_map/views/google_map_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/dashboard.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/employee_login.dart';
import '../modules/login/views/otp_view.dart';
import '../modules/myroute/bindings/myroute_binding.dart';
import '../modules/myroute/views/myroute_view.dart';
import '../modules/myvisit/bindings/myvisit_binding.dart';
import '../modules/myvisit/views/myvisit_view.dart';
import '../modules/order_history/bindings/order_history_binding.dart';
import '../modules/order_history/views/order_history_details_view.dart';
import '../modules/order_history/views/order_history_view.dart';
import '../modules/paymenthistory/bindings/paymenthistory_binding.dart';
import '../modules/paymenthistory/views/paymenthistory_view.dart';
import '../modules/pending_collection/bindings/pending_collection_binding.dart';
import '../modules/pending_collection/views/pending_collection_view.dart';
import '../modules/productdetails/bindings/productdetails_binding.dart';
import '../modules/productdetails/views/productdetails_view.dart';
import '../modules/products/bindings/product_binding.dart';
import '../modules/products/views/product_tab_view.dart';
import '../modules/shops/bindings/shops_binding.dart';
import '../modules/shops/views/add_shop.dart';
import '../modules/shops/views/shops_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/state/bindings/state_binding.dart';
import '../modules/state/views/state_view.dart';
import '../modules/stocks/bindings/stocks_binding.dart';
import '../modules/stocks/views/stock_details_view.dart';
import '../modules/stocks/views/stocks_view.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/views/support_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const DashboardView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SHOPS,
      page: () => const ShopsView(),
      binding: ShopsBinding(),
    ),
    GetPage(
      name: _Paths.MYVISIT,
      page: () => const MyvisitView(),
      binding: MyvisitBinding(),
    ),
    GetPage(
      name: _Paths.MYROUTE,
      page: () => const MyrouteView(),
      binding: MyrouteBinding(),
    ),
    GetPage(
        name: _Paths.SHOP_PROFILE,
        page: () => const ShopsProfile(),
        binding: ShopsBinding()),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => const MasalaView(),
      binding: MasalaBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE_REPORT,
      page: () => const AttendanceReportView(),
      binding: AttendanceReportBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAILS,
      page: () => const ProductdetailsView(),
      binding: ProductdetailsBinding(),
    ),
    // GetPage(
    //   name: _Paths.EMPLOYEE_LOGIN,
    //   page: () => const EmployeeLoginView(),
    //   binding: LoginBinding(),
    // ),
    GetPage(
      name: _Paths.RETAILER_LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => const OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY_DETAILS,
      page: () => const OrderHistoryDetailsView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDER,
      page: () => const MyOrder(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENTHISTORY,
      page: () => const PaymentHistoryView(),
      binding: PaymenthistoryBinding(),
    ),
    GetPage(
      name: _Paths.PENDING_COLLECTION,
      page: () => const PendingCollectionView(),
      binding: PendingCollectionBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PAYMENT,
      page: () => const AddPaymentView(),
      binding: AddPaymentBinding(),
    ),
    GetPage(
      name: _Paths.EXPIRY_PRODUCTS,
      page: () => const ExpiryProductsView(),
      binding: ExpiryProductsBinding(),
    ),
    GetPage(
      name: _Paths.EXPIRY_PRODUCTS_SHOP_DETAILS,
      page: () => const ExpiryProductShopDetailsView(),
      binding: ExpiryProductsBinding(),
    ),
    GetPage(
      name: _Paths.EXPIRY_PRODUCT_PRODUCTS_DETAILS,
      page: () => const ExpiryProductsDetailsView(),
      binding: ExpiryProductsBinding(),
    ),
    GetPage(
      name: _Paths.EXPIRY_PRODUCT_TRANSFER_VIEW,
      page: () => const ExpiryProductsTransferView(),
      binding: ExpiryProductsBinding(),
    ),
    GetPage(
      name: _Paths.STOCKS,
      page: () => const StocksView(),
      binding: StocksBinding(),
    ),
    GetPage(
      name: _Paths.STOCKS_DETAILS,
      page: () => const StockDetailsView(),
      binding: StocksBinding(),
    ),
    GetPage(
      name: _Paths.GOOGLE_MAP,
      page: () => const GoogleMapView(),
      binding: GoogleMapBinding(),
      children: [
        GetPage(
          name: _Paths.GOOGLE_MAP,
          page: () => const GoogleMapView(),
          binding: GoogleMapBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ADD_PRODUCTS,
      page: () => const AddProductsView(),
      binding: AddProductsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SHOPS,
      page: () => const AddShops(),
      binding: ShopsBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_EDIT,
      page: () => const ShopEditView(),
      binding: ShopsBinding(),
    ),
    GetPage(
      name: _Paths.STATE,
      page: () => const StateView(),
      binding: StateBinding(),
    ),
    GetPage(
      name: _Paths.PLACE,
      page: () => const PlaceView(),
      binding: PlaceBinding(),
    ),
    GetPage(
        name: _Paths.MY_TEAM,
        page: () => const MyTeamView(),
        binding: MyTeamBinding()),
    GetPage(
        name: _Paths.ASSIGNEDROUTE,
        page: () => const AssignedRouteView(),
        binding: MyTeamBinding()),
    GetPage(
        name: _Paths.MY_TEAM_ASSIGN_SHOP,
        page: () => const MyTeamAssigShopView(),
        binding: MyTeamBinding()),
    GetPage(
        name: _Paths.EDIT_PROFILE,
        page: () => const EditProfileView(),
        binding: HomeBinding()),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: HomeBinding(),
    ),
  ];
}
