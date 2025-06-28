import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetPath;
  final bool isSvgFile;
  final bool isSvgCode;
  final bool isSvgNetwork;
  final bool isImgNetwork;
  final double? size;
  final Color? customColor;
  final Color defaultBackgroundColor;
  final double borderRadius;
  final Offset offset;
  final Color? iconColor;

  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.assetPath,
    this.isSvgFile = false,
    this.isSvgCode = false,
    this.isSvgNetwork = false,
    this.isImgNetwork = false,
    this.iconColor,
    this.size,
    this.customColor,
    this.defaultBackgroundColor = Colors.transparent,
    this.borderRadius = 10,
    this.offset = Offset.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double finalSize = size ?? 20;
    final Color backgroundColor = customColor ?? defaultBackgroundColor;

    Widget iconWidget;
    if (isSvgFile) {
      iconWidget = SvgPicture.asset(
        assetPath,
        height: finalSize,
        width: finalSize,
        fit: BoxFit.contain,
        colorFilter: iconColor != null
            ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
            : null,
      );
    } else if (isSvgCode) {
      iconWidget = SvgPicture.string(
        assetPath,
        height: finalSize,
        width: finalSize,
        fit: BoxFit.contain,
        colorFilter: iconColor != null
            ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
            : null,
      );
    } else if (isSvgNetwork) {
      iconWidget = SvgPicture.network(
        assetPath,
        height: finalSize,
        width: finalSize,
        fit: BoxFit.contain,
        colorFilter: iconColor != null
            ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
            : null,
      );
    } else if (isImgNetwork) {
      iconWidget = Image.network(
        assetPath,
        height: finalSize,
        width: finalSize,
        fit: BoxFit.contain,
        color: iconColor,
      );
    } else {
      iconWidget = Image.asset(
        assetPath,
        height: finalSize,
        width: finalSize,
        fit: BoxFit.contain,
        color: iconColor,
      );
    }

    return Transform.translate(
      offset: offset,
      child: SizedBox(
        width: finalSize + 5,
        height: finalSize + 5,
        child: IconButton(
          onPressed: onPressed,
          iconSize: finalSize,
          padding: EdgeInsets.all(9),
          constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
          icon: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: iconWidget,
          ),
        ),
      ),
    );
  }
}
