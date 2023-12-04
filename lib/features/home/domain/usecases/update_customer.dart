import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/customer_update.dart';
import '../repositories/home_repository.dart';

class UpdateCustomerUseCase
    implements UseCaseWithParams<CustomerUpdateResult, UpdateCustomerParams> {
  final HomeRepository _repository;

  UpdateCustomerUseCase(this._repository);

  @override
  ResultFuture<CustomerUpdateResult> call(UpdateCustomerParams params) async =>
      _repository.updateCustomer(
        customerId: params.customerId,
        name: params.name,
        mobile: params.mobile,
        email: params.email,
        street: params.street,
        streetTwo: params.streetTwo,
        pinCode: params.pinCode,
        city: params.city,
        country: params.country,
        state: params.state,
      );
}

class UpdateCustomerParams extends Equatable {
  const UpdateCustomerParams({
    required this.customerId,
    required this.name,
    required this.mobile,
    required this.email,
    required this.street,
    required this.streetTwo,
    required this.pinCode,
    required this.city,
    required this.country,
    required this.state,
  });

  final int customerId;
  final String name;
  final String mobile;
  final String email;
  final String street;
  final String streetTwo;
  final String pinCode;
  final String city;
  final String country;
  final String state;

  @override
  List<Object> get props => [name, email, mobile];
}
