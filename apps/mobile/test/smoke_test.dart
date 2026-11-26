// Smoke test proving the test harness runs once Flutter tooling is set up.
//
// The app intentionally has no implemented widgets yet (scaffold-only
// repository, awaiting reference_material/APP_PLAN/). This file keeps `flutter
// test` meaningful in CI from day one and is replaced by real widget tests
// as screens land.
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mobile package test harness works', () {
    expect(1 + 1, 2);
  });
}
