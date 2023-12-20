part of 'shop_cubit.dart';

class ShopState {
  final bool loading; 
  final ShopModel? shopModel;
  final String? error;
  final bool shopDataUpdating;

  final String? shopName;
  final String? shopDescription;
  final String? shopType; 
  final String? shopLocation; 

  ShopState({this.loading = false, this.shopModel, this.error, this.shopName, this.shopDescription, this.shopLocation, this.shopType, this.shopDataUpdating= false});

  ShopState copyWith({
    final bool? loading, 
    final bool? shopDataUpdating, 
    final ShopModel? shopModel, 
    final String? error, 
    final String? shopName,
    final String? shopDescription,
  final String? shopType,
  final String? shopLocation,
  }){
    return ShopState(
      loading: loading ?? this.loading, 
      shopDataUpdating: shopDataUpdating ?? this.shopDataUpdating, 
      shopModel: shopModel ?? this.shopModel, 
      error:  error ?? this.error,
      shopDescription: shopDescription ?? this.shopDescription, 
      shopLocation: shopLocation ?? this.shopLocation, 
      shopName: shopName ?? this.shopName, 
      shopType: shopType ?? this.shopType
    );
  }
}
