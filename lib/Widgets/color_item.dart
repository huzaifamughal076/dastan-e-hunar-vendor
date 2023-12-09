import 'package:dashtanehunar/Utils/utils.dart';

class ColorItem extends StatelessWidget {
  final Color color;

  const ColorItem({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        color: color,
        margin: const EdgeInsets.all(8.0),
      ),
    );
  }
}