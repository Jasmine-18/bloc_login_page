part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionInitializeEvent extends TransactionEvent {
  final int pageNo;
  const TransactionInitializeEvent(this.pageNo);

  @override
  List<Object> get props => [pageNo];
}

class TransactionFetchingEvent extends TransactionEvent {
  final int pageNo;
  const TransactionFetchingEvent(this.pageNo);
  @override
  List<Object> get props => [pageNo];
}

class TransactionFetchedEvent extends TransactionEvent {}
