import 'package:test_case/src/providers/api_providers.dart';

class Repositories {
  final apiProvider = ApiProviders();

  Future getData() => apiProvider.getData();
}
