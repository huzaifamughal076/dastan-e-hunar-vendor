// ignore_for_file: file_names

import 'package:dashtanehunar/Utils/utils.dart';

List<String> mainCategories =[
  "Home Decoration",
  "Fashion and Accessories",
  "Textile and Fiber Arts",
  "Woodworking",
  "Candles and Soaps",
  "Jewelry"
];

List<String> categoriesList = [
  "None",
];

List<String> homeDecorList = [
  "Handcrafted Wall Art",
  "Customized Pillows and Cushions",
  "Unique Ceramics and Pottery",
  "Quirky Planters and Vases",
  "Artistic Photo Frames",
];
List<String> fashionAndAccessoriesList = [
  "Handmade Jewelry",
  "Custom Leather Goods",
  "Knitted Scarves and Hats",
  "Embroidered Bags and Purses",
  "Handcrafted Footwear",
];
List<String> textileList = [
  "Handwoven Rugs and Tapestries",
  "Patchwork and Quilting",
  "Hand-dyed Fabrics and Yarns",
  "Embroidery and Cross-Stitch",
  "Crocheted and Knitted Garments",
];
List<String> woodWorking = [
  "Handcrafted Furniture",
  "Wooden Home Accessories",
  "Custom Carved Art Pieces",
  "Woodturned Bowls and Vases",
  "Wooden Toys and Games",
];
List<String> candlesAndSoaps = [
   "Artisanal Candles",
  "Handmade Scented Soaps",
  "Aromatherapy Products",
  "Custom Candle Holders",
  "Natural Bath and Body Products",
];
List<String> jewelry = [
  "Beaded Bracelets and Necklaces",
  "Wire-Wrapped Gemstone Jewelry"
];

List<DropdownMenuEntry<String>> dropdownItems =categoriesList
    .map((category) => DropdownMenuEntry<String>(
          value: category,
          label: category,
        ))
    .toList();

   List<String> displayCategories(BuildContext context){
    int? index = mainCategories.indexWhere((element) => element ==context.read<LoginCubit>().state.userData?['shopType']);
    if(index==-1){
      return categoriesList;
    }else if(index==0){
      return homeDecorList;

    }else if(index==1){
      return fashionAndAccessoriesList;
      
    }else if(index==2){
      return textileList;
    }else if(index==3){
      return woodWorking;
    }else if(index==4){
      return candlesAndSoaps;
    }else if(index==5){
      return jewelry;
    }else{
      return [];
    }
  }