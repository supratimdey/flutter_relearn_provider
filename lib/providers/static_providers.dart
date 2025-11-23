import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'fake_api_service.dart';

final staticStringProvider = Provider((Ref ref) {
  return 'Hello, Riverpod!';
});

final staticIntProvider = Provider((Ref ref) {
  return 43;
});

final CounterProvider = StateProvider<int>((Ref ref) {
  return 0;
});

final textProvider = StateProvider<String>((Ref ref) {
  return '';
});

final fakeApiProvider = Provider((_) => FakeApiService());

final greetingFutureProvider = FutureProvider<String>((Ref ref) async {
  final service = ref.read(fakeApiProvider);
  return await service.fetchGreeting();
});