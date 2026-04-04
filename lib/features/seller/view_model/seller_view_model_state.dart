import 'package:equatable/equatable.dart';
import 'package:safqaseller/features/seller/model/models/seller_home_response.dart';

abstract class SellerViewModelState extends Equatable {
  const SellerViewModelState();

  @override
  List<Object?> get props => [];
}

class SellerInitial extends SellerViewModelState {}

class SellerLoading extends SellerViewModelState {}

class SellerCreated extends SellerViewModelState {
  final int sellerId;

  const SellerCreated({required this.sellerId});

  @override
  List<Object?> get props => [sellerId];
}

class PersonalVerificationSuccess extends SellerViewModelState {}

class BusinessVerificationSuccess extends SellerViewModelState {}

class SellerHomeLoaded extends SellerViewModelState {
  final SellerHomeResponse data;

  const SellerHomeLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class SellerError extends SellerViewModelState {
  final String message;

  const SellerError(this.message);

  @override
  List<Object?> get props => [message];
}
