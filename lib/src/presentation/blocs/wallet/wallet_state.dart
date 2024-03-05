part of 'wallet_bloc.dart';

enum WalletStatus { initial, loading, success, failed }

class WalletState extends Equatable {
  final WalletStatus status;
  final List<Graphic>? graphics;
  final String? error;

  const WalletState(
      {this.status = WalletStatus.initial, this.graphics, this.error});

  WalletState copyWith(
          {WalletStatus? status, List<Graphic>? graphics, String? error}) =>
      WalletState(
        status: status ?? this.status,
        graphics: graphics ?? this.graphics,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        status,
        graphics,
        error,
      ];

  bool canRenderView() =>
      status == WalletStatus.initial ||
      status == WalletStatus.success ||
      status == WalletStatus.failed;
}
