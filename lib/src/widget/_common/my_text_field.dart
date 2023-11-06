import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.obscureText,
    this.required,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.textError,
    this.errorMaxLines,
    this.onEditingComplete,
    this.onChanged,
    this.textInputAction,
    this.maxLength,
    this.keyboardType,
    this.floatingLabelBehavior,
    this.readOnly = false,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final bool? required;
  final bool? obscureText;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? textError;
  final int? errorMaxLines;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final Function(String)? onChanged;
  final int? maxLength;
  final TextInputType? keyboardType;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: labelText ?? hintText ?? '',
            style: GoogleFonts.sura(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            children: required ?? false
                ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ]
                : [],
          ),
        ),
        TextFormField(
          controller: controller,
          focusNode: focusNode ?? FocusNode(),
          maxLength: maxLength,
          minLines: minLines,
          maxLines: obscureText == true
              ? 1
              : minLines != null
                  ? 10
                  : null,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.black87, fontSize: 20, letterSpacing: 0.25),
          decoration: InputDecoration(
            floatingLabelBehavior: floatingLabelBehavior,
            isDense: true,
            fillColor: Colors.grey.shade100.withOpacity(0.1),
            hintText: hintText,
            alignLabelWithHint: true,
            errorText: textError == null || textError!.isEmpty ? null : textError,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            errorMaxLines: errorMaxLines ?? 2,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 18),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.black12),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Color(0xFFFB545E)),
            ),
          ),
          textInputAction: textInputAction,
          onEditingComplete: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            if (onEditingComplete != null) {
              onEditingComplete!();
            }
          },
          onChanged: onChanged,
          readOnly: readOnly,
        ),
      ],
    );
  }
}
