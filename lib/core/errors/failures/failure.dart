import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final Object exception;
  final String message;

  const Failure({
    this.exception = '',
    this.message = '',
  });

  @override
  List<Object> get props => [exception, message];
}
