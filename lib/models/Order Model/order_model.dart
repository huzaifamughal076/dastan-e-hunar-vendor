// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString?);

import 'dart:convert';
import 'package:dashtanehunar/Utils/utils.dart';
OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String? orderModelToJson(OrderModel data) => json.encode(data.toJson());

class GroupOrderModel {
  String? groupOrderId;
  String? groupOrderStatus;
  List<OrderModel>? orderList;
  int? orderPlaceOn;

  GroupOrderModel({this.groupOrderId, this.groupOrderStatus, this.orderList, this.orderPlaceOn,});

  factory GroupOrderModel.fromMap(groupOrderId, groupOrderStatus, List<OrderModel>? orderList, orderPlaceOn) {
    return GroupOrderModel(
      groupOrderId: groupOrderId,
      groupOrderStatus: groupOrderStatus,
      orderList: orderList, 
      orderPlaceOn: orderPlaceOn,
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'groupOrderId': groupOrderId,
      'groupOrderStatus': groupOrderStatus,
      'orderPlaceOn':orderPlaceOn,
    };
  }
}

double calculateTotalPrice(List<OrderModel>? orderList, int year) {
  if (orderList == null || orderList.isEmpty) {
    return 0.0;
  }

  // Get the current year
  int currentYear = year;

  // Filter orders for the current year
  List<OrderModel> currentYearOrders = orderList
      .where((order) => DateTime.fromMillisecondsSinceEpoch(order.orderPlaceOn ?? 0).year == currentYear)
      .toList();

  return currentYearOrders.fold(0.0, (total, order) {
    return total + (double.parse(order.productPrice ?? "0") * (order.quantity ?? 1));
  });
}

class OrderModel {
  String? productId;
  String? customerEmail;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? orderId;
  String? productCategory;
  int? orderPlaceOn;
  String? orderStatus;
  String? productDescription;
  List<String>? productImage;
  String? productName;
  String? productPrice;
  String? productStatus;
  Color? productColor;
  int? quantity;

  OrderModel({
    this.productId,
    this.customerEmail,
    this.customerId,
    this.customerName,
    this.orderId,
    this.orderPlaceOn,
    this.orderStatus,
    this.productDescription,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productStatus,
    this.quantity,
    this.productCategory,
    this.customerPhone,
    this.productColor,
  });

  factory OrderModel.fromJson(Map<String, dynamic>? json) {
    return OrderModel(
      productId: json?['ProductId'],
      customerEmail: json?['customerEmail'],
      customerId: json?['customerId'],
      customerName: json?['customerName'],
      orderId: json?['orderId'],
      orderPlaceOn: json?['orderPlaceOn'],
      orderStatus: json?['orderStatus'],
      productDescription: json?['productDescription'],
      productImage: List<String>.from(json?['productImage']),
      productName: json?['productName'],
      productPrice: json?['productPrice'],
      productStatus: json?['productStatus'],
      quantity: json?['quantity'],
      productCategory: json?['productCategory'], 
      customerPhone: json?['customerPhone'], 
      productColor: (json?['productColor']==null)?null:_getColorFromString(json?['productColor'])
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'ProductId': productId,
      'customerEmail': customerEmail,
      'customerId': customerId,
      'customerName': customerName,
      'orderId': orderId,
      'orderPlaceOn': orderPlaceOn,
      'orderStatus': orderStatus,
      'productDescription': productDescription,
      'productImage': productImage,
      'productName': productName,
      'productPrice': productPrice,
      'productStatus': productStatus,
      'quantity': quantity,
      'productCategory':productCategory,
      'customerPhone':customerPhone, 
      "productColor": productColor
    };
  }

}


    Color _getColorFromString(String colorString) {
    int value = int.parse(colorString.replaceAll('Color(0x', '').replaceAll(')', ''), radix: 16);
    return Color(value);
  }
