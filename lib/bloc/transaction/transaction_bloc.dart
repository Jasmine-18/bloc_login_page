import 'package:bloc/bloc.dart';
import 'package:bloc_login_page/TransactionList/transaction_list.dart';
import 'package:bloc_login_page/repository/transaction_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  // final notificationFetcher = PublishSubject<dynamic>();
  final TransactionRepository _transactionRepository =
      const TransactionRepository();

  TransactionBloc() : super(TransactionInitial()) {
    // on<TransactionFetchedEvent>(_onTransactionFetchedEvent);
    on<TransactionInitializeEvent>(_onTransactionInitializeEvent);
    on<TransactionFetchingEvent>(_onTransactionFetchingEvent);
  }
  void _onTransactionInitializeEvent(
      TransactionInitializeEvent event, Emitter<TransactionState> emit) {
    // emit(TransactionFetchedState);
    emit(TransactionFetchingState(pageNo: event.pageNo));
  }

  void _onTransactionFetchingEvent(
      TransactionFetchingEvent event, Emitter<TransactionState> emit) async {
    dynamic notificationList = [];

    // notificationFetcher.sink.add(null);
    List<Transaction> response = [
      Transaction(name: "Transaction 1"),
      Transaction(name: "Transaction 2"),
      Transaction(name: "Transaction 3"),
      Transaction(name: "Transaction 4"),
      Transaction(name: "Transaction 5"),
      Transaction(name: "Transaction 6"),
      Transaction(name: "Transaction 7"),
      Transaction(name: "Transaction 8"),
      Transaction(name: "Transaction 9"),
      Transaction(name: "Transaction 10"),
      Transaction(name: "Transaction 11"),
      Transaction(name: "Transaction 12"),
      Transaction(name: "Transaction 13"),
      Transaction(name: "Transaction 14"),
      Transaction(name: "Transaction 15"),
      Transaction(name: "Transaction 16"),
      Transaction(name: "Transaction 17"),
      Transaction(name: "Transaction 18"),
      Transaction(name: "Transaction 19"),
      Transaction(name: "Transaction 20"),
      Transaction(name: "Transaction 21"),
      Transaction(name: "Transaction 22"),
      Transaction(name: "Transaction 23"),
      Transaction(name: "Transaction 24"),
      Transaction(name: "Transaction 25"),
      Transaction(name: "Transaction 26"),
      Transaction(name: "Transaction 27"),
      Transaction(name: "Transaction 28"),
      Transaction(name: "Transaction 29"),
      Transaction(name: "Transaction 30"),
    ];
    print(state);
    int start = 11 * (state.pageNo - 1) as int;
    int num = 0;
    int end = start + 11;
    print("start ${start}");
    print("end ${end}");
    print("num ${num}");
    if (end >= response.length - 1) {
      end = response.length - 1;
    }
    if (start >= response.length - 1) {
      num++;
    }
    if (num == 1) {
      emit(
        const TransactionFetchedState(transactions: [], isAll: true),
      );
    } else {
      emit(
        TransactionFetchedState(
            transactions: response.getRange(start, end).toList(), isAll: false),
      );
    }

    // notificationList.addAll(response);
    // response = notificationList;
    // notificationFetcher.sink.add(response);
    // emit(TransactionFetchedState);
  }
}
