import 'package:equatable/equatable.dart';
import 'package:smart_save/features/home/domain/entities/customer_create.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/home_repository.dart';

class CreateCustomerUseCase
    implements UseCaseWithParams<CustomerCreateResult, CreateCustomerParams> {
  final HomeRepository _repository;

  CreateCustomerUseCase(this._repository);

  @override
  ResultFuture<CustomerCreateResult> call(CreateCustomerParams params) async =>
      _repository.createCustomer(
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

class CreateCustomerParams extends Equatable {
  const CreateCustomerParams({
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
