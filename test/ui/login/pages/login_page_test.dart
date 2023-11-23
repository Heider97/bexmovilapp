import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//cubit
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';
//presentation
import 'package:bexmovil/src/presentation/views/global/login_view.dart';

class FakeLoginState extends Fake implements LoginState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLoginState());
  });

  group('LoginPage ', () {
    testWidgets('renders LoginPage', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginView(),
        ),
      );
      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}
