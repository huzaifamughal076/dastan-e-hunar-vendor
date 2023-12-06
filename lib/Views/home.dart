import 'package:dashtanehunar/Blocs/Dashboard%20Cubit/cubit/dashboard_cubit.dart';

import '../Blocs/Get product/get_product_cubit.dart';
import '../Utils/utils.dart';
import 'package:intl/intl.dart' as math;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardState state = context.watch<DashboardCubit>().state;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: thirdColor,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addProduct),
        child: const Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: 'Top Selling', fontWeight: FontWeight.bold, fontsize: 20,),
                      const SizedBox(height: 10,),
                      Container(
                        // height: 100, 
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        child: (state.topSellingProduct?.productId?.isNotEmpty??false)
                        ?Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
           height: 80,
           width: 80,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(12),
           ),
           child: ClipRRect(
               borderRadius: BorderRadius.circular(12),
               child: (state.topSellingProduct?.productImage?.isNotEmpty??false)?Image.network('${state.topSellingProduct?.productImage?.first}'):Image.asset(
                 'assets/profile_image.webp',
                 fit: BoxFit.fill,
               )),
         ),
    )
                        :const CustomText(text: 'No top selling product found'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: 'Total Sale', fontWeight: FontWeight.bold, fontsize: 20,),
                      const SizedBox(height: 10,),
                      Container(
                        height: 100, 
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        child: (state.totalSale!=null && state.totalSale!=0.0)
                        ?CustomText(text: math.NumberFormat.compactCurrency(symbol: "PKR\n", locale: 'en_US').format(state.totalSale),fontsize: 22, fontWeight: FontWeight.bold,)
                        :const CustomText(text: 'No sale found'),
                      ),
                    ],
                  ),
                ),
              ],
            ), 
            
            
      
            const SizedBox(height: 10,),
              const CustomText(
                text: "All Products",
                fontsize: 25,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<GetProductCubit, GetProductState>(
                builder: (context, state) {
                  if (state.requestStatus == RequestStatus.loading) {
                    return const CustomLoader();
                  }
                  if (state.requestStatus == RequestStatus.failure) {
                    return const Center(
                      child: CustomText(text: "Error"),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 16 / 27),
                    itemCount: state.products?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map product = state.products?[index];
                      final List images = (product["productImage"] as List)
                        ..shuffle();
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.productDetail,
                            arguments: state.products?[index]),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: FadeInImage(
                                      placeholder:
                                          const AssetImage("assets/logo.jpeg"),
                                      image: NetworkImage(
                                        images.first,
                                      ),
                                      imageErrorBuilder: (context, error, stackTrace) {
                                        return Image.asset('assets/logo.jpeg');
                                      },
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 5,
                                    child: Opacity(
                                      opacity: 0.91,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: kWhite),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: Text(
                                            '${state.products?[index]['productStatus']}',
                                            style: TextStyle(
                                                color: (state.products?[index][
                                                                'productStatus']
                                                            .toLowerCase() ==
                                                        "pending")
                                                    ? kOrange
                                                    : (state.products?[index][
                                                                    'productStatus']
                                                                .toLowerCase() ==
                                                            "rejected")
                                                        ? kRed
                                                        : (state.products?[
                                                                        index][
                                                                        'productStatus']
                                                                    .toLowerCase() ==
                                                                "active")
                                                            ? kGreen
                                                            : kTransparent)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(text: product["productName"] ?? "")
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
