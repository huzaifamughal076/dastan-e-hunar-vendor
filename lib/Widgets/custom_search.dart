import 'package:flutter/cupertino.dart';

import '../Utils/utils.dart';

class CustomSearch extends StatelessWidget {
  final bool enabled;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final bool autofocus;
  final dynamic function;
  const CustomSearch(
      {Key? key,
      this.enabled = true,
      this.function,
      this.onEditingComplete,
      this.autofocus = false,
      this.onSubmitted,
      this.onChanged,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        autofocus: autofocus,
        enabled: enabled,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(
            CupertinoIcons.search,
            color: primaryColor,
          ),
          hintText: hintText ?? "Search anything ..",
          isDense: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: kTransparent)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: kTransparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: kTransparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: kTransparent)),
          fillColor: kGrey.shade100,
          filled: true,
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
