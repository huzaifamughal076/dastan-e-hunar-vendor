import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Blocs/Dashboard%20Cubit/cubit/dashboard_cubit.dart';
import 'package:dashtanehunar/Blocs/Get%20product/get_product_cubit.dart';
import 'package:dashtanehunar/models/Order%20Model/order_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../Utils/utils.dart';

class ProductService {
  static Future<String?> addProduct(
      List<Color>? productColorList,
      String uid,
      String productName,
      String productDescription,
      List<String> productImages,
      String productPrice,
      String category,
      ) async {
    try {
      var docId = FirebaseFirestore.instance.collection("shops").doc(uid).collection("products").doc().id;
      await FirebaseFirestore.instance
          .collection("shops")
          .doc(uid)
          .collection("products")
          .doc(docId)
          .set(
        { 
          "productColors": (productColorList?.isNotEmpty??false) ? productColorList?.map((color) => color.toString()).toList() : null,
          "ProductId":docId,
          "productName": productName,
          "productDescription": productDescription,
          "productImage": productImages,
          "productPrice": productPrice,
          "productCategory": category,
          "productStatus":"Pending",
          'vendorId':uid
        },
      );
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<List<String>> uploadImages(
      String uid, List<File> productImages) async {
    final List<String> images = [];
    for (var element in productImages) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child(uid)
          .child("products")
          .child(basename(element.path));
      final uploadTask = storageRef.putFile(File(element.path));
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      if (snapshot.state == TaskState.success) {
        final String downloadURL = await snapshot.ref.getDownloadURL();
        images.add(downloadURL);
      }
    }
    return images;
  }


    static Future<String?> editProduct(
      List<Color>? productColorList,
      String uid,
      String productName,
      String productDescription,
      List<String>? productImages,
      String productId,
      String productPrice, 
      String category,
      ) async {
    try {
      if(productImages?.isNotEmpty??false){
        await FirebaseFirestore.instance
          .collection("shops")
          .doc(uid)
          .collection("products")
          .doc(productId)
          .update(
        {
          "productColors": (productColorList?.isNotEmpty??false) ? productColorList?.map((color) => color.toString()).toList() : null,
          "productName": productName,
          "productDescription": productDescription,
          "productImage": productImages,
          "productPrice": productPrice,
          "productCategory": category,
          "productStatus":"Pending",
          "vendorId":uid
        },
      );
      }else{
        await FirebaseFirestore.instance
          .collection("shops")
          .doc(uid)
          .collection("products")
          .doc(productId)
          .update(
        {
          "productName": productName,
          "productDescription": productDescription,
          "productPrice": productPrice,
          "productStatus":"Pending",
        },
      );
      }
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }



static Future<void> getAllOrders(BuildContext context, String? uid) async {
  List<GroupOrderModel> groupordersList = [];
  List<OrderModel> list = [];

  var outerSnapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where('vendor_id', isEqualTo: uid)
      .get();

  await Future.wait(outerSnapshot.docs.map((i) async {
    print(i.id);
    var innerSnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(i.id)
        .collection('order')
        .get();

    List<OrderModel> orderList = [];
    
    for (var j in innerSnapshot.docs) {
      print(j.data()['ProductId']);
      orderList.add(OrderModel.fromJson(j.data()));
      list.add(OrderModel.fromJson(j.data()));
    }

    groupordersList.add(GroupOrderModel.fromMap(i.id, i.data()['orderStatus'] ?? "Not Provided", orderList));
  })).then((value) {
    context.read<DashboardCubit>().onChangeOrderList(groupordersList).then((value){
        OrderModel? topSellingProductInfo =  ProductService.findTopSellingProduct(list);
        double? totalSale = ProductService().calculateTotalSale(groupordersList);

        context.read<DashboardCubit>().onChangeTopSellingProduct(topSellingProductInfo);
        context.read<DashboardCubit>().onChangeTotalSale(totalSale);
  print(topSellingProductInfo?.productId);
  print(topSellingProductInfo?.quantity);
    });
  });
}


double calculateTotalSale(List<GroupOrderModel>? groupOrderList) {
  if (groupOrderList == null || groupOrderList.isEmpty) {
    return 0.0;
  }

  return groupOrderList.fold(0.0, (total, groupOrder) {
    return total + calculateTotalPrice(groupOrder.orderList);
  });
}


 static OrderModel? findTopSellingProduct(List<OrderModel>? orderList) {
  print(orderList?.length);
    if (orderList == null || orderList.isEmpty) {
      return null;
    }

    HashMap<String, int> productQuantities = HashMap();

    for (var order in orderList) {
      String productId = order.productId ?? "";
      int quantity = order.quantity ?? 0;

      if (productQuantities.containsKey(productId)) {
        productQuantities[productId] = productQuantities[productId]! + quantity;
      } else {
        productQuantities[productId] = quantity;
      }
    }
    String topSellingProduct = "";
    int maxQuantity = 0;

    productQuantities.forEach((productId, quantity) {
      if (quantity > maxQuantity) {
        maxQuantity = quantity;
        topSellingProduct = productId;
      }
    });
    print("Top selling product: $topSellingProduct (Quantity: $maxQuantity)");

   int? index = orderList.indexWhere((element) => element.productId==topSellingProduct);


            print(index);
            OrderModel? model;
            if(index!=-1){
              model = orderList[index];
               model.quantity = maxQuantity;
            }

    return model;
  }


 }


