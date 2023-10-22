import '../Blocs/Get product/get_product_cubit.dart';
import '../Utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: context.read<LoginCubit>().state.userData?["shopName"] ?? "",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: thirdColor,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addProduct),
        child: const Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "All Products",
              fontsize: 25,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<GetProductCubit, GetProductState>(
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  images.first,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
