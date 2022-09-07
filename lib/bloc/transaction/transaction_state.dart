part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];

  get pageNo => null;
}

class TransactionInitial extends TransactionState {
  @override
  List<Object> get props => [];
}

class TransactionFetchingState extends TransactionState {
  final int pageNo;
  const TransactionFetchingState({required this.pageNo});
  @override
  List<Object> get props => [pageNo];
}

class TransactionFetchedState extends TransactionState {
  final List<Transaction> transactions;
  final bool isAll;
  const TransactionFetchedState(
      {required this.transactions, required this.isAll});
  @override
  List<Object> get props => [transactions];
}

class TransactionFailureState extends TransactionState {
  @override
  List<Object> get props => [];
}
