import 'package:equatable/equatable.dart';

import 'customer.dart';

class CustomerCreateResult extends Equatable {
  final int errorCode;
  final Customer customer;
  final String message;

  const CustomerCreateResult({
    required this.errorCode,
    required this.customer,
    required this.message,
  });

  @override
  List<Object> get props => [errorCode, customer, message];
}
