import 'package:equatable/equatable.dart';

abstract class AuthViewModelState extends Equatable {
  const AuthViewModelState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthViewModelState {}

class AuthAuthenticated extends AuthViewModelState {
  final String token;
  final String role; // "User" | "Seller"

  const AuthAuthenticated({required this.token, required this.role});

  @override
  List<Object?> get props => [token, role];
}

class AuthUnauthenticated extends AuthViewModelState {}
