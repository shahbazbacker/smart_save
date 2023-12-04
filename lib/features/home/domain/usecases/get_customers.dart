import 'package:smart_save/features/home/domain/repositories/home_repository.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/customer.dart';

class GetCustomersUseCase implements UseCaseWithoutParams<CustomerResult> {
  final HomeRepository _repository;

  GetCustomersUseCase(this._repository);

  @override
  ResultFuture<CustomerResult> call() async => _repository.getCustomers();
}
