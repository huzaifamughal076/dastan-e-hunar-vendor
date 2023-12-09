part of 'dashboard_cubit.dart';

class DashboardState {
  final int currentScreenIndex;
  final List<GroupOrderModel>? orderList;
  final List<OrderModel>? orders;
  final OrderModel? topSellingProduct;
  final double? totalSale;
  final int? selectedYear;

  const DashboardState({
    this.currentScreenIndex = 0,
    this.orderList,
    this.topSellingProduct,
    this.totalSale,
    this.selectedYear,
    this.orders,
  });

  DashboardState copyWith({
    int? currentScreenIndex,
    List<GroupOrderModel>? orderList,
    OrderModel? topSellingProduct,
    int? selectedYear,
    List<OrderModel>? orders,
    double? totalSale, // Specify the type of totalSale
  }) {
    return DashboardState(
      currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,
      orderList: orderList ?? this.orderList,
      topSellingProduct: topSellingProduct ?? this.topSellingProduct,
      totalSale: totalSale ?? this.totalSale,
      selectedYear: selectedYear ?? this.selectedYear,
      orders: orders ?? this.orders,
    );
  }
}
