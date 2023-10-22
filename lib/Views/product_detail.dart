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
        child: CustomButton(text: "Edit Product", function: () {}),
      ),
      body: Column(
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
          Expanded(
            child: Padding(
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
                  const CustomText(
                    text: "Description",
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: kGrey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        CustomText(text: product["productDescription"] ?? ""),
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
