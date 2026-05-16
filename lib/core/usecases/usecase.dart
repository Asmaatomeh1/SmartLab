// // // core/usecases/usecase.dart
// // import 'package:dartz/dartz.dart';
// // import '../error/failures.dart';

// // abstract class UseCase<Type, Params> {
// //   Future<Either<Failure, Type>> call(Params params);
// // }

// // class NoParams {
// //   @override
// //   bool operator ==(Object other) => identical(this, other) || other is NoParams;

// //   @override
// //   int get hashCode => runtimeType.hashCode;
// // }

// // core/usecases/usecase.dart
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import '../error/failures.dart';

// abstract class UseCase<Type, Params> {
//   Future<Either<Failure, Type>> call(Params params);
// }

// class NoParams extends Equatable {
//   const NoParams();

//   @override
//   List<Object?> get props => [];
// }
