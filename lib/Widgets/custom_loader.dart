import '../Utils/utils.dart';

class CustomLoader extends StatelessWidget {
  final double width;
  const CustomLoader({Key? key, this.width = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LottieBuilder.asset(
      "assets/loader.json",
      width: width,
    ));
  }
}
