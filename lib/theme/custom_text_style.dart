import 'package:flutter/material.dart';
import 'package:project/theme/theme_helper.dart';
import 'package:project/utils/size_utils.dart';
// import 'package:google_fonts/google_fonts.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLarge18 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 18.fSize,
      );
  static get bodyLargegrey800 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.grey800,
      );
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );
  static get bodyLargeGray900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray900,
      );
  static get bodyLargeInter => theme.textTheme.bodyLarge!.inter.copyWith(
        fontSize: 18.fSize,
      );
  static get bodyLargeOnPrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 18.fSize,
      );
  static get bodyLargeOnPrimary_1 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get bodyMediumgrey800 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.grey800,
      );
  static get bodyMediumgrey80015 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.grey800,
        fontSize: 15.fSize,
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumGray900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray900,
      );
  static get bodyMediumGray900_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray900,
      );
  static get bodyMediumInter => theme.textTheme.bodyMedium!.inter;
  static get bodyMediumInterBlack900 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.black900,
      );
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmall10_1 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallBlack90010 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 10.fSize,
      );
  static get bodySmallInter => theme.textTheme.bodySmall!.inter;
  static get bodySmallInterBlack900 =>
      theme.textTheme.bodySmall!.inter.copyWith(
        color: appTheme.black900,
        fontSize: 10.fSize,
      );
  static get bodySmallOnPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get bodySmallOnPrimary10 => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 10.fSize,
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 10.fSize,
      );
  static get bodySmallPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get bodySmallPrimary_1 => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodySmallRed400 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.grey800,
      );
  static get bodySmall_1 => theme.textTheme.bodySmall!;
  static get bodySmall_2 => theme.textTheme.bodySmall!;
  // Headline text style
  static get headlineMediumgrey800 => theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.grey800,
        fontWeight: FontWeight.w400,
      );
  static get headlineSmallBold => theme.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallGray900 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.gray900,
      );
  static get headlineSmallGray900Bold =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.gray900,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallPrimary => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  // Label text style
  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  // Title text style
  static get titleLarge22 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 22.fSize,
      );
  static get titleLargegrey800 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.grey800,
        fontSize: 22.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleLargegrey80022 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.grey800,
        fontSize: 22.fSize,
      );
  static get titleLargegrey800_1 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.grey800,
      );
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 22.fSize,
      );
  static get titleLargeBold => theme.textTheme.titleLarge!.copyWith(
        fontSize: 22.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeGray900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray900,
        fontSize: 22.fSize,
      );
  static get titleLargeGray900_1 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray900,
      );
  static get titleLargeInter => theme.textTheme.titleLarge!.inter.copyWith(
        fontSize: 22.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleLargeIntergrey800 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.grey800,
        fontSize: 22.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumgrey800 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.grey800,
        fontSize: 16.fSize,
      );
  static get titleMediumgrey800_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.grey800,
      );
  static get titleMediumInter => theme.textTheme.titleMedium!.inter.copyWith(
        fontSize: 16.fSize,
      );
  static get titleMediumIntergrey800 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.grey800,
        fontSize: 16.fSize,
      );
  static get titleMediumIntergrey800SemiBold =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.grey800,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumInterOnPrimary =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterPrimary =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallgrey800 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.grey800,
      );
  static get titleSmallGray900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray900,
      );
  static get titleSmallInter => theme.textTheme.titleSmall!.inter.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleSmallInterGray900 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Work Sans',
    );
  }

  TextStyle get productSans {
    return copyWith(
      fontFamily: 'Work Sans',
    );
  }
}
