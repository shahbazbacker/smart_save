import 'package:equatable/equatable.dart';

import 'customer.dart';

class CustomerUpdateResult extends Equatable {
  final int errorCode;
  final Customer customer;
  final String message;

  const CustomerUpdateResult({
    required this.errorCode,
    required this.customer,
    required this.message,
  });

  @override
  List<Object> get props => [errorCode, customer, message];
}
