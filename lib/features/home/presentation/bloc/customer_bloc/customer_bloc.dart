import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:smart_save/core/utils/extenstions.dart';
import 'package:smart_save/features/home/domain/entities/customer_create.dart';
import 'package:smart_save/features/home/domain/usecases/create_customer.dart';

import '../../../domain/entities/customer.dart';
import '../../../domain/entities/customer_hive_model.dart';
import '../../../domain/entities/customer_update.dart';
import '../../../domain/usecases/get_customers.dart';
import '../../../domain/usecases/update_customer.dart';
import 'customer_event.dart';

part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc({
    required GetCustomersUseCase getCustomers,
    required CreateCustomerUseCase createCustomer,
    required UpdateCustomerUseCase updateCustomer,
  })  : _getCustomerUseCase = getCustomers,
        _createCustomerUseCase = createCustomer,
        _updateCustomerUseCase = updateCustomer,
        _customer = null,
        super(CustomerInitial()) {
    on<CustomerFetchEvent>(_customersFetchHandler);
    on<CustomerCreateEvent>(_customerCreateHandler);
    on<CustomerUpdateEvent>(_customerUpdateHandler);
    on<CustomerSelectEvent>(_customerSelectHandler);
    on<ClearSelectedCustomer>(_customerClearHandler);
  }

  final GetCustomersUseCase _getCustomerUseCase;
  final CreateCustomerUseCase _createCustomerUseCase;
  final UpdateCustomerUseCase _updateCustomerUseCase;

  final Customer? _customer;
  Customer? get items => _customer;

  Future<void> _customersFetchHandler(
      CustomerFetchEvent event, Emitter<CustomerState> emit) async {
    emit(FetchingCustomers());

    ///Checking internet
    bool isInternetAvailable = await InternetConnection().hasInternetAccess;

    if (!isInternetAvailable) {
      log('Internet not available');
      // Try to load data from Hive if there is no internet connection
      final List<Customer> cachedCustomers = await _loadCustomersFromHive();
      if (cachedCustomers.isNotEmpty) {
        log('cachedCustomers not empty');
        _customersList = cachedCustomers;
        emit(CustomersLoaded(customersList: cachedCustomers));
      } else {
        emit(CustomerError('No internet connection available.'));
      }
      return;
    }

    // Internet is available, proceed with fetching customers
    final result = await _getCustomerUseCase();
    log(result.toString(), name: 'result login');

    result.fold(
      (failure) async {
        // Try to load data from Hive in case of a failure
        final List<Customer> cachedCustomers = await _loadCustomersFromHive();
        if (cachedCustomers.isNotEmpty) {
          _customersList = cachedCustomers;
          emit(CustomersLoaded(customersList: cachedCustomers));
        } else {
          emit(CustomerError(failure.errorMessage));
        }
      },
      (success) {
// Use Hive to save customers locally
        _saveCustomersToLocal(success.customers);
        _customersList = success.customers;
        emit(CustomersLoaded(customersList: success.customers));
      },
    );
  }

  Future<void> _customerCreateHandler(
      CustomerCreateEvent event, Emitter<CustomerState> emit) async {
    emit(CreatingCustomer());
    final result = await _createCustomerUseCase(
      CreateCustomerParams(
        name: event.name,
        email: event.email,
        mobile: event.mobile,
        street: event.street,
        streetTwo: event.streetTwo,
        pinCode: event.pinCode,
        city: event.city,
        country: event.country,
        state: event.state,
      ),
    );

    result.fold(
      (failure) => emit(CreateCustomerError(failure.errorMessage)),
      (success) => emit(CreatedCustomerLoaded(success)),
    );
  }

  Future<void> _customerUpdateHandler(
      CustomerUpdateEvent event, Emitter<CustomerState> emit) async {
    emit(UpdatingCustomer());
    final result = await _updateCustomerUseCase(
      UpdateCustomerParams(
        customerId: event.customerId,
        name: event.name,
        email: event.email,
        mobile: event.mobile,
        street: event.street,
        streetTwo: event.streetTwo,
        pinCode: event.pinCode,
        city: event.city,
        country: event.country,
        state: event.state,
      ),
    );

    result.fold(
      (failure) => emit(UpdateCustomerError(failure.errorMessage)),
      (success) => emit(UpdatedCustomerLoaded(success)),
    );
  }

  Future<void> _customerSelectHandler(
      CustomerSelectEvent event, Emitter<CustomerState> emit) async {
    for (int i = 0; i < _customersList.length; i++) {
      _customersList[i].isSelected = false;
      if (_customersList[i] == event.customer) {
        _customersList[i].isSelected = !_customersList[i].isSelected;
      }
    }
    emit(CustomerSelect(
      selectedCustomer: event.customer,
      customersList: _customersList,
    ));
  }

  Future<void> _customerClearHandler(
      ClearSelectedCustomer event, Emitter<CustomerState> emit) async {
    for (int i = 0; i < _customersList.length; i++) {
      _customersList[i].isSelected = false;
    }
    emit(SelectedCustomerCleared(
      selectedCustomer: Customer.empty(),
      customersList: _customersList,
    ));
  }

  List<Customer> _customersList = [];
}

Future<void> _saveCustomersToLocal(List<Customer> customers) async {
  log('_saveCustomersToLocal');

  try {
    // Use Hive to save customers locally
    final Box<CustomerHiveModel> customersBox =
        Hive.box<CustomerHiveModel>('customersBox');

    log('_saveCustomersToLocal customersBox ${customersBox.values.length}');

    // Convert List<Customer> to List<CustomerHiveModel>
    List<CustomerHiveModel> hiveModels = customers.toCustomerHiveModelList();

    // Clear existing data and save new customers
    await customersBox.clear();

    customersBox.addAll(hiveModels);
    log('_saveCustomersToLocal customersBox after clear ${customersBox.values.length}');
  } catch (e) {
    // Handle Hive error
    log("Error saving customers to Hive: $e");
  }
}

Future<List<Customer>> _loadCustomersFromHive() async {
  log('_loadCustomersFromHive');
  try {
    // Open the Hive box before trying to access it
    // Hive.openBox<Customer>('customersBox');

    // Load customers from Hive
    final Box<CustomerHiveModel> customersBox =
        Hive.box<CustomerHiveModel>('customersBox');

    log('_loadCustomersFromHive customersBox ${customersBox.values.length}');

    List<CustomerHiveModel> hiveModels = customersBox.values.toList();

    // Convert List<CustomerHiveModel> to List<Customer>
    List<Customer> customers = hiveModels.toCustomerModelList();

    return customers;
  } catch (e) {
    // Handle Hive loading error
    return [];
  }
}
