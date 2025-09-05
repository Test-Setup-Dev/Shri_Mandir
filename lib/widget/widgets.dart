import 'package:flutter/material.dart';
import 'package:mandir/screen/dashboard/dashboard_screen.dart';
import 'package:mandir/utils/helper.dart';
import 'package:get/get.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/toasty.dart';
import 'package:mandir/values/dimen.dart';

Widget empty() => SizedBox();

Widget assetImage(
  String? name, {
  double? width,
  double? height,
  Color? color,
  BoxFit? fit,
  Alignment alignment = Alignment.center,
  ImageErrorWidgetBuilder? errorBuilder,
}) {
  try {
    if (name.empty) throw Exception('Empty Asset!');
    return Image.asset(
      name.nullSafe,
      width: width,
      height: height,
      color: color,
      fit: fit,
      alignment: alignment,
      errorBuilder:
          errorBuilder ??
          (c, o, s) {
            Logger.e(tag: 'ASSET IMAGE : ${name.nullSafe}', value: s);
            return SizedBox(width: width, height: height);
          },
    );
  } catch (e) {
    Logger.ex(tag: 'ASSET IMAGE', value: e);
    return empty();
  }
}

class MyFlatButton extends MaterialButton {
  const MyFlatButton({
    required final VoidCallback onPressed,
    required final Widget child,
    final VoidCallback? onLongPress,
    final double? height,
    final double? width = double.infinity,
    final double? minWidth,
    final Color? color,
    final Color? focusColor,
    final Color? splashColor,
    final Color? textColor,
    final EdgeInsetsGeometry? padding = EdgeInsets.zero,
    final ShapeBorder? shape,
    final double? elevation,
    final MaterialTapTargetSize? materialTapTargetSize,
  }) : super(
         onPressed: onPressed,
         onLongPress: onLongPress,
         height: height,
         minWidth: minWidth,
         color: color ?? Colors.transparent,
         highlightElevation: elevation ?? 0,
         focusColor: focusColor,
         splashColor: splashColor,
         textColor: textColor,
         padding: padding ?? EdgeInsets.zero,
         shape: shape,
         elevation: elevation ?? 0,
         materialTapTargetSize:
             materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
         child: child,
       );
}

class MyTextStyle extends TextStyle {
  const MyTextStyle({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double fontSize = 14,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
  }) : super(
         inherit: inherit,
         color: color ?? ThemeColors.defaultTextColor,
         backgroundColor: backgroundColor,
         fontSize: fontSize,
         fontWeight: fontWeight,
         fontFamily: fontFamily,
         fontStyle: fontStyle,
         letterSpacing: letterSpacing,
         wordSpacing: wordSpacing,
         textBaseline: textBaseline,
         height: height,
         decoration: decoration,
       );
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withAlpha(50)),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: ThemeColors.textPrimaryColor, fontSize: 4.w),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: ThemeColors.greyColor, fontSize: 4.w),
          filled: true,
          fillColor: ThemeColors.offWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 7.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 4.w,
            fontWeight: FontWeight.w600,
            color: ThemeColors.white,
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String icon;
  final Function() onTap;

  const SocialButton({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: onTap,
      onTap: () {
        Toasty.info('This feature is not available now');
      },
      child: Container(
        width: 12.w,
        height: 12.w,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: ThemeColors.offWhite,
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(color: ThemeColors.greyColor.withOpacity(0.2)),
        ),
        // child: Icon(icon, color: color, size: 6.w),
        child: Image(image: AssetImage(icon)),
      ),
    );
  }
}

Widget navItem(NavigationItem item, bool isSelected) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 240),
    height: 45,
    width: isSelected ? 120 : 45,
    padding: isSelected ? EdgeInsets.only(left: 14, right: 14) : null,
    decoration: isSelected
        ? BoxDecoration(
            color: ThemeColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          )
        : null,
    child: Center(
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  assetImage(
                    item.icon,
                    width: 20,
                    height: 20,
                    color: isSelected ? Colors.white : ThemeColors.primaryColor,
                  ),
                  if (item.count > 0)
                    Container(
                      width: 40,
                      height: 32,
                      alignment: Alignment.topRight,
                      child: Container(
                        width: fontSizeLarge,
                        height: fontSizeLarge,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: !isSelected
                              ? ThemeColors.primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(fontSizeMedium),
                        ),
                        child: Text(
                          item.count.toString(),
                          style: MyTextStyle(
                            fontSize: item.count < 100
                                ? fontSizeMini
                                : fontSizeMicro,
                            fontWeight: FontWeight.w600,
                            color: !isSelected
                                ? Colors.white
                                : ThemeColors.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: isSelected
                    ? DefaultTextStyle.merge(
                        style: MyTextStyle(
                          color: Colors.white,
                          fontSize: fontSizeSmall,
                        ),
                        child: item.title,
                      )
                    : empty(),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget customRefresh({
  required Widget child,
  required Future<void> Function() onRefresh,
}) {
  return RefreshIndicator(
    onRefresh: onRefresh,
    color: ThemeColors.white,
    backgroundColor: ThemeColors.colorSecondary.withAlpha(200),
    child: child,
  );
}
