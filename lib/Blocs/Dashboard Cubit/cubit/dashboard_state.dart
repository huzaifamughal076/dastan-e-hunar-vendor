part of 'dashboard_cubit.dart';

class DashboardState {
  final int currentScreenIndex;
  final List<GroupOrderModel>? orderList;
  final OrderModel? topSellingProduct;
  final double? totalSale;

  const DashboardState({this.currentScreenIndex = 0,this.orderList,this.topSellingProduct,this.totalSale});

  DashboardState copyWith({
    final int? currentScreenIndex,
    final List<GroupOrderModel>? orderList,
    final OrderModel? topSellingProduct,
    final totalSale, 
  }) {
    return DashboardState(
        currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex, 
        orderList: orderList ?? this.orderList, 
        topSellingProduct: topSellingProduct ?? this.topSellingProduct, 
        totalSale: totalSale ?? this.totalSale, 
        );
  }
}
