import 'package:frontend/models/place.dart';
import 'package:frontend/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, AppUser?>(
  (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<AppUser?> {
  UserNotifier() : super(null);

  setUser(AppUser? user) {
    state = user;
  }

  Future<void> setName(String name) async {
    state = state?.copyWith(firstName: name) ??
        AppUser(firstName: name, id: state!.id);
  }

  Future<void> setLastName(String lastName) async {
    state = state?.copyWith(lastName: lastName) ??
        AppUser(lastName: lastName, id: state!.id);
  }

  Future<void> setBirthDate(String birthDate) async {
    state = state?.copyWith(birthDate: birthDate) ??
        AppUser(birthDate: birthDate, id: state!.id);
  }

  Future<void> setOnboarded(bool onboarded) async {
    state = state?.copyWith(onboarded: onboarded) ??
        AppUser(onboarded: onboarded, id: state!.id);
  }

  Future<void> setAvatar(String avatarUrl) async {
    state = state?.copyWith(avatarUrl: avatarUrl) ??
        AppUser(avatarUrl: avatarUrl, id: state!.id);
  }

  Future<void> setGoogleAddress(Place googleAddress) async {
    state = state?.copyWith(googleAddress: googleAddress) ??
        AppUser(googleAddress: googleAddress, id: state!.id);
  }

  AppUser? get user => state;
}
