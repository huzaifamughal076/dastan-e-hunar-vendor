import '../Utils/utils.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight fontWeight;
  final double fontsize;
  final int maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  const CustomText(
      {Key? key,
      required this.text,
      this.color,
      this.fontWeight = FontWeight.w500,
      this.fontsize = 16,
      this.textAlign,
      this.textDecoration,
      this.maxLines = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
      style: TextStyle(
          color: color ?? kGrey.shade700,
          fontWeight: fontWeight,
          fontSize: fontsize,
          decoration: textDecoration),
      overflow: TextOverflow.ellipsis,
    );
  }
}
