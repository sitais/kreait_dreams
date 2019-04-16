import 'package:kreait_dreams/kreait_dreams.dart';
import 'package:aqueduct_test/aqueduct_test.dart';

export 'package:kreait_dreams/kreait_dreams.dart';
export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';

/// A testing harness for kreait_dreams.
///
/// A harness for testing an aqueduct application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<KreaitDreamsChannel> with TestHarnessORMMixin {
  ManagedContext get context => channel.context;
  @override
  Future onSetUp() async {
    await resetData();
  }

  @override
  Future onTearDown() async {

  }
}
