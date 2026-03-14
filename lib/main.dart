import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/helper_functions/on_generate_routes.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/features/adaptive_layout/view/adaptive_layout_view.dart';
import 'package:safqaseller/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const SafqaSeller());
}

class SafqaSeller extends StatefulWidget {
  const SafqaSeller({super.key});

  static _SafqaSellerState? of(BuildContext context) =>
      context.findAncestorStateOfType<_SafqaSellerState>();

  @override
  State<SafqaSeller> createState() => _SafqaSellerState();
}

class _SafqaSellerState extends State<SafqaSeller> {
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  void _loadLocale() {
    final saved = getIt<CacheHelper>().getData(key: CacheKeys.language);
    Locale locale;
    if (saved == 'arabic') {
      locale = const Locale('ar');
    } else if (saved == 'english') {
      locale = const Locale('en');
    } else {
      final sys =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      locale = sys == 'ar' ? const Locale('ar') : const Locale('en');
    }
    setState(() => _locale = locale);
  }

  void setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: _locale.languageCode == 'ar' ? 'Cairo' : 'Inter',
          ),
          locale: _locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          initialRoute: AdaptiveLayoutView.routeName,
          onGenerateRoute: onGenerateRoutes,
          home: const AdaptiveLayoutView(),
        );
      },
    );
  }
}
