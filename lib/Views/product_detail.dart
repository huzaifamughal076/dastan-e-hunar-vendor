import 'package:carousel_slider/carousel_slider.dart';

import '../Utils/utils.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map product = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: BaseAppBar(
        title: "Product Details",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(text: "Edit Product", function: () {
          context.read<EditProductCubit>().onChangeSelectedCategory(product['productCategory']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductPage(finalMap: product),));

          // Navigator.pushNamed(
          //   context, 
          //   AppRoutes.editProduct, 
          //   );

        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: CarouselSlider.builder(
                itemCount: (product["productImage"] as List).length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    (product["productImage"] as List)[itemIndex],
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                options: CarouselOptions(
                    enlargeCenterPage: true, height: double.infinity),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: product["productName"],
                        fontsize: 25,
                      ),
                      CustomText(text: "Rs. ${product["productPrice"]}")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const CustomText(
                    text: "Status",
                  ),
      
                   CustomText(
                    text: "${product['productStatus']}",
                    color: (product['productStatus'].toLowerCase()=="pending")
                                          ?kOrange
                                          :(product['productStatus'].toLowerCase()=="rejected")
                                          ?kRed
                                          :(product['productStatus'].toLowerCase()=="active")
                                          ?kGreen
                                          :kBlack,
      
                  ),
      
                    ],),
                  const SizedBox(
                    height: 10,
                  ),
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const CustomText(
                    text: "Category",
                  ),
      
                   CustomText(
                    text: "${product['productCategory']??"Not Provided"}",
      
                  ),
      
                    ],),
      
                 (product["productColors"]?.isEmpty??true)
                 ?const SizedBox.shrink()
                 : const SizedBox(
                    height: 10,
                  ),
                  (product["productColors"]?.isEmpty??true)
                  ?const SizedBox.shrink()
                  :const CustomText(text: 'Color'), 
      
                  Wrap(
                    children:(product["productColors"]?.isEmpty??true)
                    ?[]
                    : (product["productColors"]as List).map((e) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 30, 
                      width: 30, 
                      color: _getColorFromString(e),
                    )).toList(),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  ((product["productDescription"]?.isEmpty??true) ||  product["productDescription"] == " " )
                  ?const SizedBox.shrink()
                  :const CustomText(
                    text: "Description",
                  ),
                  ((product["productDescription"]?.isEmpty??true) ||  product["productDescription"] == " " )
                  ?const SizedBox.shrink()
                  :Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                  color: kGrey.shade200,
                  borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                    CustomText(text: product["productDescription"] ?? ""),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

    Color _getColorFromString(String colorString) {
    int value = int.parse(colorString.replaceAll('Color(0x', '').replaceAll(')', ''), radix: 16);
    return Color(value);
  }
}
