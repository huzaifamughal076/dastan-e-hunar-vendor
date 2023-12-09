import 'package:dashtanehunar/Repo/product.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:dashtanehunar/models/Order%20Model/order_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super( DashboardState(
    selectedYear: DateTime.now().year
  ));


onChangeSelectedYear(int? year)async{
  emit(state.copyWith(selectedYear: year));
}
onChangeOrderList(List<GroupOrderModel>? list)async{ 
  emit(state.copyWith(orderList: list));
}
onChangeOrders(List<OrderModel>? list)async{ 
  emit(state.copyWith(orders: list));
}

getAllOrders(BuildContext context, uid)async{
  await ProductService.getAllOrders(context, uid);
}

  onChangeCurrentIndex(int index)async{
    emit(state.copyWith(currentScreenIndex: index));
  }

  onChangeTopSellingProduct(OrderModel? model)async{
    emit(state.copyWith(topSellingProduct: model??OrderModel()));
  }

  onChangeTotalSale(double? totalSale)async{
    emit(state.copyWith(totalSale: totalSale));
  }
}
