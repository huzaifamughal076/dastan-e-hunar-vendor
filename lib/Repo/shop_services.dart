

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Blocs/Shop%20Cubit/cubit/shop_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';
// ignore: implementation_imports
import 'package:awesome_snackbar_content/src/content_type.dart' as content;
import 'package:dashtanehunar/models/Shop%20Model/shop_model.dart';


class ShopServices{

  static Future<void> getVendorShop(BuildContext context)async{
    FirebaseFirestore.instance.collection('shops').doc(context.read<LoginCubit>().state.userData?['uid']).snapshots().listen((event) {
      ShopModel? shopModel = ShopModel.fromMap(event.data());
      shopModel.id = event.id;
      context.read<ShopCubit>().setShopData(shopModel);
     });

  }
static Future<void> updateShopData(BuildContext context, String? uid,)async{
  ShopState state = context.read<ShopCubit>().state;
  BlocProvider.of<ShopCubit>(context).onChangeShopDataUpdating(true);
  try{
      await FirebaseFirestore.instance.collection('users').doc(uid).update({"shopName":state.shopName, "shopDescription":state.shopDescription, "shopType":state.shopModel?.shopType, "shopLocation":state.shopLocation}).then((value) async {
       await FirebaseFirestore.instance.collection('shops').doc(uid).update({"shopName":state.shopName,"shopDescription":state.shopDescription, "shopType":state.shopModel?.shopType, "shopLocation":state.shopLocation}).then((value) {
       ShopModel? shopModel  = ShopModel(
        id: uid, 
        shopDescription: state.shopDescription?? state.shopModel?.shopDescription,
        shopLocation: state.shopLocation?? state.shopModel?.shopLocation, 
        shopName: state.shopName?? state.shopModel?.shopName, 
        shopProfileUrl: state.shopModel?.shopProfileUrl, 
        shopType: state.shopModel?.shopType, 
       );
       BlocProvider.of<ShopCubit>(context).setShopData(shopModel);
        Navigator.pop(context);
        SnackBarService.showSnackBar(context, title: "Shop Updated", message: 'Shop updated successfully', contentType: content.ContentType.success);
BlocProvider.of<ShopCubit>(context).onChangeShopDataUpdating(false);
  
       });
             });
  
  }catch(e){
    // ignore: use_build_context_synchronously
    context.read<ShopCubit>().onChangeShopDataUpdating(false);
  
    debugPrint(e.toString());
            // ignore: use_build_context_synchronously
            SnackBarService.showSnackBar(context, title: "", message: e.toString(), contentType: content.ContentType.failure);

  }

}


}