import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/features/profile/view_model/profile_view_model_state.dart';

class ProfileViewModel extends Cubit<ProfileViewModelState> {
  final CacheHelper cacheHelper;

  ProfileViewModel(this.cacheHelper) : super(ProfileInitial());

  /// Restores isProfileCompleted from SharedPreferences.
  void loadFromCache() {
    final isCompleted =
        (cacheHelper.getData(key: CacheKeys.isProfileCompleted) as bool?) ??
            false;
    emit(ProfileLoaded(isProfileCompleted: isCompleted));
  }

  /// Returns whether the profile is completed.
  bool get isProfileCompleted {
    final s = state;
    if (s is ProfileLoaded) return s.isProfileCompleted;
    return false;
  }

  /// Marks profile as completed in cache + emits success.
  Future<void> completeProfile() async {
    await cacheHelper.saveData(
      key: CacheKeys.isProfileCompleted,
      value: true,
    );
    emit(const ProfileLoaded(isProfileCompleted: true));
  }

  /// Resets profile completion (used on logout).
  Future<void> reset() async {
    await cacheHelper.removeData(key: CacheKeys.isProfileCompleted);
    emit(const ProfileLoaded(isProfileCompleted: false));
  }
}
