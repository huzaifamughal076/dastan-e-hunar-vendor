import '../Utils/utils.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Payment",
        appBar: AppBar(),
        widgets: const [],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
    );
  }
}
