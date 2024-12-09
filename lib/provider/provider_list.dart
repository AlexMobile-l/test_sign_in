import 'package:provider/provider.dart';
import 'package:sign_in_by_apple_id/domain/auth_state.dart';

class ProviderList {
  static final providers = [
    ChangeNotifierProvider<AuthState>(
      create: (context) => AuthState(),
    ),
  ];
}
