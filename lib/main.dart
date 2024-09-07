import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard_project/models/contact_model.dart';
import 'package:vcard_project/pages/form_page.dart';
import 'package:vcard_project/pages/home_page.dart';
import 'package:vcard_project/pages/scan_page.dart';
import 'package:vcard_project/providers/contact_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: EasyLoading.init(),
      routerConfig: _router,
      title: 'Vcard Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
    );
  }

  final _router =
      GoRouter(debugLogDiagnostics: true, initialLocation: '/', routes: [
    GoRoute(
        path: '/',
        name: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
              path: ScanPage.routeName,
              name: ScanPage.routeName,
              builder: (context, state) => const ScanPage(),
              routes: [
                GoRoute(
                  path: FormPage.routeName,
                  name: FormPage.routeName,
                  builder: (context, state) => FormPage(
                    contactModel: state.extra! as ContactModel,
                  ),
                )
              ]),
        ]),
  ]);
}
