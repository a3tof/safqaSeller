import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/features/profile/view_model/profile_view_model.dart';
import 'package:safqaseller/features/profile/view_model/profile_view_model_state.dart';

class CurrencyFormatter {
  /// Formats the given [amount] to the user's country currency.
  /// If [obscure] is true, replaces all digits with bullets (e.g. '••••').
  static String format(double amount, {bool obscure = false}) {
    String? currencyCode;
    try {
      final profileState = getIt<ProfileViewModel>().state;
      if (profileState is ProfileLoaded) {
        final countryName = profileState.countryName?.toLowerCase() ?? '';
        currencyCode = _getCurrencyCodeForCountry(countryName);
      }
    } catch (_) {
      // Ignore if service locator is not ready
    }

    final locale = ui.PlatformDispatcher.instance.locale.toString();

    NumberFormat formatter;
    if (currencyCode != null) {
      formatter = NumberFormat.simpleCurrency(
        locale: locale,
        name: currencyCode,
        decimalDigits: amount == amount.roundToDouble() ? 0 : 2,
      );
    } else {
      formatter = NumberFormat.simpleCurrency(
        locale: locale,
        decimalDigits: amount == amount.roundToDouble() ? 0 : 2,
      );
    }

    final formatted = formatter.format(amount);
    if (obscure) {
      return formatted.replaceAll(RegExp(r'[0-9.,]'), '•').replaceAll(RegExp(r'•+'), '••••');
    }
    return formatted;
  }

  /// Returns the currency symbol for the user's country (e.g. 'SAR', '$', 'E£').
  static String getSymbol() {
    String? currencyCode;
    try {
      final profileState = getIt<ProfileViewModel>().state;
      if (profileState is ProfileLoaded) {
        final countryName = profileState.countryName?.toLowerCase() ?? '';
        currencyCode = _getCurrencyCodeForCountry(countryName);
      }
    } catch (_) {
      // Ignore if service locator is not ready
    }

    final locale = ui.PlatformDispatcher.instance.locale.toString();

    if (currencyCode != null) {
      return NumberFormat.simpleCurrency(locale: locale, name: currencyCode).currencySymbol;
    } else {
      return NumberFormat.simpleCurrency(locale: locale).currencySymbol;
    }
  }

  static String? _getCurrencyCodeForCountry(String countryName) {
    if (countryName.isEmpty) return null;
    
    if (countryName.contains('egypt') || countryName.contains('مصر')) return 'EGP';
    if (countryName.contains('saudi') || countryName.contains('السعودية') || countryName.contains('ksa')) return 'SAR';
    if (countryName.contains('emirates') || countryName.contains('uae') || countryName.contains('الامارات')) return 'AED';
    if (countryName.contains('kuwait') || countryName.contains('الكويت')) return 'KWD';
    if (countryName.contains('qatar') || countryName.contains('قطر')) return 'QAR';
    if (countryName.contains('bahrain') || countryName.contains('البحرين')) return 'BHD';
    if (countryName.contains('oman') || countryName.contains('عمان')) return 'OMR';
    if (countryName.contains('jordan') || countryName.contains('الاردن')) return 'JOD';
    if (countryName.contains('states') || countryName.contains('usa')) return 'USD';
    if (countryName.contains('kingdom') || countryName.contains('uk')) return 'GBP';
    if (countryName.contains('europe') || countryName.contains('germany') || countryName.contains('france')) return 'EUR';
    
    return null;
  }
}
