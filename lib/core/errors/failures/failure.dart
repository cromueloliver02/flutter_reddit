import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final Object exception;
  final String message;

  Failure({
    Object? exception,
    this.message = 'Oops! Something went wrong',
  }) : exception = exception ?? Exception();

  @override
  List<Object> get props => [exception, message];
}
