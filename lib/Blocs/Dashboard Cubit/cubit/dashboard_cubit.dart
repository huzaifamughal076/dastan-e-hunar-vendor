

import 'package:dashtanehunar/Repo/product.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:dashtanehunar/models/Order%20Model/order_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());


onChangeOrderList(List<GroupOrderModel>? list)async{ 
  emit(state.copyWith(orderList: list));
}

getAllOrders(BuildContext context, uid)async{
  await ProductService.getAllOrders(context, uid);
}

  onChangeCurrentIndex(int index)async{
    emit(state.copyWith(currentScreenIndex: index));
  }

  onChangeTopSellingProduct(OrderModel? model)async{
    emit(state.copyWith(topSellingProduct: model));
  }

  onChangeTotalSale(double? totalSale)async{
    emit(state.copyWith(totalSale: totalSale));
  }
}
