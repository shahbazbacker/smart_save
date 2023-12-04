part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  CustomerState({List<Customer>? customersList, Customer? selectedCustomer})
      : customersList = customersList ?? [],
        selectedCustomer = selectedCustomer ?? Customer.empty();

  final List<Customer> customersList;
  Customer selectedCustomer;

  @override
  List<Object> get props => [customersList];
}

class CustomerInitial extends CustomerState {
  CustomerInitial();
}

///Customer Listing States
class FetchingCustomers extends CustomerState {
  FetchingCustomers();
}

class CustomersLoaded extends CustomerState {
  CustomersLoaded({required List<Customer> customersList})
      : super(customersList: customersList);

  @override
  List<Object> get props =>
      customersList.map((customer) => customer.id).toList();
}

class CustomerError extends CustomerState {
  CustomerError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

///Customer Create States
class CreatingCustomer extends CustomerState {
  CreatingCustomer();
}

class CreatedCustomerLoaded extends CustomerState {
  CreatedCustomerLoaded(this.customer);

  final CustomerCreateResult customer;

  @override
  List<Object> get props => [customer];
}

class CreateCustomerError extends CustomerState {
  CreateCustomerError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

///Customer Update States
class UpdatingCustomer extends CustomerState {
  UpdatingCustomer();
}

class UpdatedCustomerLoaded extends CustomerState {
  UpdatedCustomerLoaded(this.customer);

  final CustomerUpdateResult customer;

  @override
  List<Object> get props => [customer];
}

class UpdateCustomerError extends CustomerState {
  UpdateCustomerError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

class CustomerSelect extends CustomerState {
  // final List<Customer> customersList;

  CustomerSelect(
      {required Customer selectedCustomer,
      required List<Customer> customersList})
      : super(customersList: customersList, selectedCustomer: selectedCustomer);

  @override
  List<Object> get props => super.props..addAll([selectedCustomer]);
  // List<Object> get props =>
  //     customersList.map((customer) => customer.id).toList();
}

class SelectedCustomerCleared extends CustomerState {
  // final List<Customer> customersList;

  SelectedCustomerCleared(
      {required Customer selectedCustomer,
      required List<Customer> customersList})
      : super(customersList: customersList, selectedCustomer: selectedCustomer);

  @override
  List<Object> get props => super.props..addAll([selectedCustomer]);
// List<Object> get props =>
//     customersList.map((customer) => customer.id).toList();
}
