import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/wallet/model/models/wallet_models.dart';
import 'package:safqaseller/features/wallet/model/repositories/wallet_repository.dart';
import 'package:safqaseller/features/wallet/view_model/withdrawal/withdrawal_view_model_state.dart';

class WithdrawalViewModel extends Cubit<WithdrawalState> {
  final WalletRepository walletRepository;

  WithdrawalViewModel(this.walletRepository) : super(WithdrawalInitial());

  Future<void> withdraw(double amount, {required int cardId}) async {
    emit(WithdrawalLoading());
    try {
      await walletRepository.withdraw(
        WithdrawalRequest(amount: amount, cardId: cardId),
      );
      emit(WithdrawalSuccess());
    } catch (e) {
      String msg = e.toString();
      if (msg.startsWith('Exception: ')) msg = msg.replaceFirst('Exception: ', '');
      emit(WithdrawalError(msg));
    }
  }
}
