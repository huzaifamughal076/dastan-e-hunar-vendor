class ShopModel {
  String? id;
  String? shopName;
  String? shopProfileUrl;
  String? shopLocation;
  String? shopType;
  String? shopDescription;

  ShopModel({this.id, this.shopLocation, this.shopName, this.shopProfileUrl, this.shopType,this.shopDescription});

  // Convert a Map to a ShopModel
  factory ShopModel.fromMap(Map<String, dynamic>? map) {
    return ShopModel(
      id: map?['id'] as String?,
      shopName: map?['shopName'] as String?,
      shopProfileUrl: map?['shopProfileUrl'] as String?,
      shopLocation: map?['shopLocation'] as String?,
      shopDescription: map?['shopDescription'] as String?,
      shopType: map?['shopType'] as String?,
    );
  }

  // Convert a ShopModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopName': shopName,
      'shopProfileUrl': shopProfileUrl,
      'shopLocation': shopLocation,
      'shopType': shopType,
      'shopDescription': shopDescription,
    };
  }
}
