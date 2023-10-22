import '../Utils/utils.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final AppBar appBar;
  final bool automaticallyImplyLeading, centerTitle;
  final List<Widget> widgets;
  final double appBarHeight;
  final Widget? leading;
  final Color titleColor;
  final double? elevation;
  final PreferredSizeWidget? bottom;

  /// you can add more fields that meet your needs

  const BaseAppBar(
      {Key? key,
      required this.title,
      required this.appBar,
      required this.widgets,
      this.automaticallyImplyLeading = false,
      this.backgroundColor = Colors.transparent,
      this.centerTitle = true,
      required this.appBarHeight,
      this.titleColor = kBlack,
      this.bottom,
      this.elevation = 0,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: true,
      leading: automaticallyImplyLeading == false
          ? null
          : leading ??
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  )),
      actions: widgets,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
