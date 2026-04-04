import 'package:equatable/equatable.dart';

abstract class ProfileViewModelState extends Equatable {
  const ProfileViewModelState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileViewModelState {}

class ProfileLoaded extends ProfileViewModelState {
  final bool isProfileCompleted;

  const ProfileLoaded({required this.isProfileCompleted});

  @override
  List<Object?> get props => [isProfileCompleted];
}
