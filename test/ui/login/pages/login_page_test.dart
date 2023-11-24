import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

//cubits
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';
//blocs
import 'package:bexmovil/src/presentation/blocs/recovery_password/recovery_password_bloc.dart';
//presentation
import 'package:bexmovil/src/presentation/views/global/login_view.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class MockRecoveryPasswordBloc
    extends MockBloc<RecoveryPasswordEvent, RecoveryPasswordState>
    implements RecoveryPasswordBloc {}

void main() {
  late MockLoginCubit cubitLogin;
  late MockRecoveryPasswordBloc blocRecoveryPassword;

  setUpAll(() {
    cubitLogin = MockLoginCubit();
    blocRecoveryPassword = MockRecoveryPasswordBloc();
    // FakeLoginState();
    // registerFallbackValue();
  });

  group('LoginPage ', () {
    testWidgets('renders LoginPage', (tester) async {
      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => blocRecoveryPassword),
          ],
          child: MaterialApp(
            home: BlocProvider(
                create: (_) => cubitLogin, child: const LoginView()),
          )));
      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}
