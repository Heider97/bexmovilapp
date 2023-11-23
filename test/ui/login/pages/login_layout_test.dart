import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

//cubit
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';
//presentation
import 'package:bexmovil/src/presentation/views/global/login_view.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class FakeLoginState extends Fake implements LoginState {}

void main() {
  late MockLoginCubit cubitLogin;

  setUpAll(() {
    FakeLoginState();
  });

  setUp(() {
    cubitLogin = MockLoginCubit();
  });

  group('RandomCatPage states ', () {
    testWidgets(
        'render FailureRandomCatView when state is [RandomCatStatus.failure]',
        (tester) async {
      when(() => cubitLogin.state).thenReturn(
        const LoginFailed(),
      );
      await tester.pumpWidget(
        BlocProvider<LoginCubit>(
          lazy: false,
          create: (_) => cubitLogin,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      expect(find.byKey(const Key(ConstWidgetKeysApp.RandomCatFailure)),
          findsOneWidget);
    });

    testWidgets('render LoadingView when state is [RandomCatStatus.loading]',
        (tester) async {
      when(() => cubitLogin.state).thenReturn(
        const LoginLoading(),
      );
      await tester.pumpWidget(
          BlocProvider<LoginCubit>(
            lazy: false,
            create: (_) => cubitLogin,
            child: const MaterialApp(
              home: LoginView(),
            ),
          ),
      );
      expect(
          find.byKey(const Key(ConstWidgetKeysApp.CatLoading)), findsOneWidget);
    });

    testWidgets(
        'render SuccessRandomCatView when state is [RandomCatStatus.success]',
        (tester) async {
      when(() => cubitLogin.state).thenReturn(
        const LoginSuccess(),
      );
      await tester.pumpWidget(
          BlocProvider<LoginCubit>(
            lazy: false,
            create: (_) => cubitLogin,
            child: const MaterialApp(
              home: LoginView(),
            ),
          ),
      );
      expect(find.byKey(const Key(ConstWidgetKeysApp.RandomCatSuccess)),
          findsOneWidget);
    });

    testWidgets(
        'render InitialRandomCatView when state is [RandomCatStatus.initial]',
        (tester) async {
      when(() => cubitLogin.state).thenReturn(
        const LoginInitial(),
      );
      await tester.pumpWidget(
          BlocProvider<LoginCubit>(
            lazy: false,
            create: (_) => cubitLogin,
            child: const MaterialApp(
              home: LoginView(),
            ),
          ),
      );
      expect(find.byKey(const Key(ConstWidgetKeysApp.RandomCatInitial)),
          findsOneWidget);
    });
  });

  group('Click on FAB ', () {
    testWidgets('call to bloc to get next cat', (tester) async {
      when(() => cubitLogin.state).thenReturn(
        const LoginSuccess(),
      );
      await tester.pumpWidget(
          BlocProvider<LoginCubit>(
            lazy: false,
            create: (_) => cubitLogin,
            child: const MaterialApp(
              home: LoginView(),
            ),
          ),
      );
      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      verify(() => cubitLogin.emit(const LoginLoading())).called(1);
    });
  });

  // group('Call to SearchRandomCat on BlocListener ', () {
  //   const login = Login(id: '1', breeds: [], width: 1, height: 1, url: 'www');
  //
  //   testWidgets('Call to event when breeds is empty', (tester) async {
  //     whenListen(
  //       cubitLogin,
  //       Stream<LoginState>.fromIterable(
  //         [
  //           const RandomCatState(),
  //           const RandomCatState(status: RandomCatStatus.emptyBreeds, cat: cat)
  //         ],
  //       ),
  //     );
  //     when(() => cubitLogin.state).thenReturn(
  //       const RandomCatState(status: RandomCatStatus.emptyBreeds, cat: cat),
  //     );
  //     await tester.pumpWidget(
  //         BlocProvider<LoginCubit>(
  //           lazy: false,
  //           create: (_) => cubitLogin,
  //           child: const MaterialApp(
  //             home: LoginView(),
  //           ),
  //         ),
  //     );
  //
  //     verify(() => cubitLogin.emit(const LoginLoading())).called(1);
  //   });
  // });
}
