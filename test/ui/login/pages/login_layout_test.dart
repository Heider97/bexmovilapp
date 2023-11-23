import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

//cubit
// import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';
//presentation
// import 'package:bexmovil/src/presentation/views/global/login_view.dart';

// class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}
//
// class FakeLoginState extends Fake implements LoginState {}

void main() {
  // late MockLoginCubit cubitLogin;
  //
  // setUpAll(() {
  //   FakeLoginState();
  // });
  //
  // setUp(() {
  //   cubitLogin = MockLoginCubit();
  // });

  // group('LoginPage states ', () {
  //   testWidgets(
  //       'render FailureLoginView when state is [LoginStatus.failure]',
  //       (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //       const LoginFailed(),
  //     );
  //     await tester.pumpWidget(
  //       BlocProvider<LoginCubit>(
  //         lazy: false,
  //         create: (_) => cubitLogin,
  //         child: const MaterialApp(
  //           home: LoginView(),
  //         ),
  //       ),
  //     );
  //     expect(find.byKey(const Key('LoginFailed')),
  //         findsOneWidget);
  //   });
  //
  //   testWidgets('render LoadingView when state is [LoginStatus.loading]',
  //       (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //       const LoginLoading(),
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
  //     expect(
  //         find.byKey(const Key('LoginLoading')), findsOneWidget);
  //   });
  //
  //   testWidgets(
  //       'render SuccessLoginView when state is [LoginStatus.success]',
  //       (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //       const LoginSuccess(),
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
  //     expect(find.byKey(const Key('LoginSuccess')),
  //         findsOneWidget);
  //   });
  //
  //   testWidgets(
  //       'render InitialLoginView when state is [LoginStatus.initial]',
  //       (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //       const LoginInitial(),
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
  //     expect(find.byKey(const Key('LoginInitial')),
  //         findsOneWidget);
  //   });
  // });

  // group('Click on FAB ', () {
  //   testWidgets('call to bloc to get next cat', (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //       const LoginSuccess(),
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
  //     expect(find.byType(FloatingActionButton), findsOneWidget);
  //
  //     await tester.tap(find.byType(FloatingActionButton));
  //     await tester.pumpAndSettle();
  //
  //     verify(() => cubitLogin.emit(const LoginLoading())).called(1);
  //   });
  // });

  // group('Call to SearchLogin on BlocListener ', () {
  //   const login = Login(id: '1', breeds: [], width: 1, height: 1, url: 'www');
  //
  //   testWidgets('Call to event when breeds is empty', (tester) async {
  //     whenListen(
  //       cubitLogin,
  //       Stream<LoginState>.fromIterable(
  //         [
  //           const LoginState(),
  //           const LoginState(status: LoginStatus.emptyBreeds, cat: cat)
  //         ],
  //       ),
  //     );
  //     when(() => cubitLogin.state).thenReturn(
  //       const LoginState(status: LoginStatus.emptyBreeds, cat: cat),
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
