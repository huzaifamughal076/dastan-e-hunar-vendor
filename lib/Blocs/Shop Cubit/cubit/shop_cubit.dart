import 'package:dashtanehunar/Repo/shop_services.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:dashtanehunar/models/Shop%20Model/shop_model.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopState());

  setLoading(bool loading)async{
    emit(state.copyWith(loading: loading));
  }

  onChangeShopDataUpdating(bool value)async{
  emit(state.copyWith(shopDataUpdating: value));
  }


  setShopData(ShopModel? shopModel)async{
    emit(state.copyWith(shopModel: shopModel));
  }

  getVendorShop(BuildContext context)async{
    await ShopServices.getVendorShop(context);
  }

  onChangeShopName(String? value)async{
    emit(state.copyWith(shopName: value));
  }
  onChangeShopDescription(String? value)async{
    emit(state.copyWith(shopDescription: value));
  }
  onChangeShopType(String? value)async{
    emit(state.copyWith(shopType: value));
  }
  onChangeShopLocation(String? value)async{
    emit(state.copyWith(shopLocation: value));
  }

updateShopData(BuildContext context, String? id)async{
  await ShopServices.updateShopData(context,id);
}


}
