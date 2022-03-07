import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:laundry_lady/utils/theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.text,
    required this.icon,
    required this.controller,
    this.validator,
    this.readOnly = false,
    this.maxLines = 1,
    this.textType = TextInputType.text,
  }) : super(key: key);
  final String text;
  final TextEditingController controller;
  final IconData icon;
  final int maxLines;
  final bool readOnly;
  final TextInputType textType;
  final validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  late bool isPassword;

  @override
  void initState() {
    isPassword = widget.textType == TextInputType.visiblePassword;
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.textType,
          validator: widget.validator,
          obscureText: isPassword,
          focusNode: _focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: widget.readOnly,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          maxLines: widget.maxLines,
          decoration: InputDecoration(
              errorMaxLines: 3,
              isDense: true,
              labelText: widget.text,
              prefixIcon: Icon(
                widget.icon,
                size: 23,
                color:
                    _focusNode.hasFocus ? Themes.mainColor : Themes.lightColor,
              ),
              suffix: widget.textType == TextInputType.visiblePassword
                  ? GestureDetector(
                      onTap: () => setState(() {
                        isPassword = !isPassword;
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1.0, right: 2),
                        child: Icon(
                          isPassword
                              ? FluentSystemIcons.ic_fluent_eye_show_regular
                              : FluentSystemIcons.ic_fluent_eye_hide_regular,
                          color: _focusNode.hasFocus
                              ? Themes.mainColor
                              : Themes.lightColor,
                          size: 20,
                        ),
                      ),
                    )
                  : const SizedBox())),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(() {});
    super.dispose();
  }
}
