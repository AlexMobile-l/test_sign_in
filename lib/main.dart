import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_by_apple_id/provider/provider_list.dart';
import 'package:sign_in_by_apple_id/router/router_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderList.providers,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: Routes.router,
        );
      },
    );
  }
}
