import '../Utils/utils.dart';

class CustomTextField extends StatefulWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final int? maxLines;
  final String? Function(String?)? validator;
  final String? hintText;
  final void Function(String)? onChanged;
  final bool obsureText;
  final EdgeInsetsGeometry? contentPadding;
  final String? initialValue;
  final bool? enabled;
  final bool? isPassword;
  const CustomTextField(
      {super.key,
      this.prefix,
      this.suffix,
      this.label,
      this.controller,
      this.contentPadding,
      this.hintText,
      this.maxLines = 1,
      this.validator,
      this.keyboardType,
      this.enabled,
      this.obsureText = false,
      this.isPassword = false,
      this.onChanged,
      this.initialValue});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obsure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      initialValue: widget.initialValue,
      textAlignVertical: TextAlignVertical.center,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword == true ? obsure : widget.obsureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding:
            widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 20),
        filled: true,
        prefixIcon: widget.prefix,
        fillColor: kWhite,
        label: widget.label,
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obsure = !obsure;
                  });
                },
                icon: const Icon(Icons.visibility))
            : widget.suffix,
        hintText: widget.hintText,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: kTransparent),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kTransparent),
            borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kTransparent),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kTransparent),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
