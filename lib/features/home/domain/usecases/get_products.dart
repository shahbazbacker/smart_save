import 'package:smart_save/features/home/domain/repositories/home_repository.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';

class GetProductsUseCase implements UseCaseWithoutParams<ProductResult> {
  final HomeRepository _repository;

  GetProductsUseCase(this._repository);

  @override
  ResultFuture<ProductResult> call() async => _repository.getProducts();
}
