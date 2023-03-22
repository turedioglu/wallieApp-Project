// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/base/model/base_state.dart';
import '../../../core/init/theme/color_manager.dart';

class WTextFormField {
  static final WTextFormField _instance = WTextFormField._init();
  static WTextFormField get instance => _instance;
  WTextFormField._init();

  Widget widget({
    required BuildContext context,
    bool? autoFocus,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? mask,
    String? Function(String?)? validation,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    TextEditingController? controller,
    TextInputType? keyboardType,
    int? minLines,
    InputBorder? errorBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? border,
    InputBorder? disabledBorder,
    InputDecoration? decoration,
    TextStyle? style,
    TextStyle? labelStyle,
    BoxConstraints? boxConstraints,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    TextStyle? helperStyle,
    String? hintText,
    String? labelText,
    String? helperText,
    Widget? leadingIcon,
    Widget? suffixIcon,
    bool? obscureText,
    int? maxLength,
    int? maxLines,
    bool? enabled,
    bool? readOnly,
    bool allBorder = false,
    Color? cursorColor,
    AutovalidateMode? validateMode,
    double? fontSize,
    Color? borderColor,
    Color? fillColor,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Utility.dynamicWidthPixel(8),
      ),
      child: TextFormField(
        autofocus: autoFocus == null ? false : true,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        cursorColor: cursorColor ?? ColorManager.instance.darkGray,
        textInputAction: textInputAction,
        style: style != null
            ? style
            : TextStyle(
                color: ColorManager.instance.primary,
                fontSize: fontSize ?? Utility.dynamicTextSize(16),
              ),
        scrollPadding: EdgeInsets.only(bottom: Utility.dynamicWidthPixel(100)),
        inputFormatters: mask != null ? mask : [],
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText ?? false,
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        autovalidateMode: validateMode != null ? validateMode : AutovalidateMode.disabled,
        keyboardType: keyboardType ?? TextInputType.text,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        minLines: minLines ?? 1,
        decoration: decoration ??
            InputDecoration(
              filled: true,
              prefixIcon: leadingIcon,
              contentPadding: EdgeInsets.fromLTRB(
                Utility.dynamicWidthPixel(12),
                Utility.dynamicWidthPixel(4),
                Utility.dynamicWidthPixel(4),
                Utility.dynamicWidthPixel(6),
              ),
              suffixIcon: suffixIcon,
              focusColor: ColorManager.instance.greyBG,
              fillColor: ColorManager.instance.greyBG,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager.instance.grayBorder,
                ),
              ),
              hintText: labelText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager.instance.grayBorder,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager.instance.grayBorder,
                ),
              ),
              errorStyle: errorStyle,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1.5,
                  color: ColorManager.instance.white,
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintStyle: labelStyle ??
                  TextStyle(
                    fontSize: Utility.dynamicTextSize(15),
                    color: ColorManager.instance.secondary,
                  ),
            ),
        validator: validation,
      ),
    );
  }
}
