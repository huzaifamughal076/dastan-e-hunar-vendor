// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString?);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String? orderModelToJson(OrderModel data) => json.encode(data.toJson());

class GroupOrderModel {
  String? groupOrderId;
  String? groupOrderStatus;
  List<OrderModel>? orderList;

  GroupOrderModel({this.groupOrderId, this.groupOrderStatus, this.orderList});

  factory GroupOrderModel.fromMap(groupOrderId, groupOrderStatus, List<OrderModel>? orderList) {
    return GroupOrderModel(
      groupOrderId: groupOrderId,
      groupOrderStatus: groupOrderStatus,
      orderList: orderList
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'groupOrderId': groupOrderId,
      'groupOrderStatus': groupOrderStatus,
    };
  }
}

 double calculateTotalPrice(orderList) {
    if (orderList == null || orderList!.isEmpty) {
      return 0.0;
    }

    return orderList!.fold(0.0, (total, order) {
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
    this.customerPhone
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
      'customerPhone':customerPhone
    };
  }
}
