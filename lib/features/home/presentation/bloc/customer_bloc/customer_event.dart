import 'package:equatable/equatable.dart';
import 'package:smart_save/features/home/domain/entities/customer.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class CustomerFetchEvent extends CustomerEvent {
  const CustomerFetchEvent();

  @override
  List<Object> get props => [];
}

class CustomerCreateEvent extends CustomerEvent {
  const CustomerCreateEvent({
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

class CustomerUpdateEvent extends CustomerEvent {
  const CustomerUpdateEvent({
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
}

class CustomerSelectEvent extends CustomerEvent {
  const CustomerSelectEvent({required this.customer});

  final Customer customer;

  @override
  List<Object> get props => [customer.id];
}

class ClearSelectedCustomer extends CustomerEvent {
  const ClearSelectedCustomer();

  @override
  List<Object> get props => [];
}
