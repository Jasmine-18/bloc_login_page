import 'package:bloc_login_page/TransactionList/transaction_list.dart';

class TransactionRepository {
  const TransactionRepository();

  Future<List<Transaction>> fetchTransactions(int pageNo) async {
    // if (pageNo == 1) {
    //   notificationFetcher.sink.add(null);
    //   response = List();
    //   notificationList = [];
    // }
    // isAllPagesLoaded = false;

    // response = await _repository.getPurchaseTransactionsReport(
    //     page: pageNo.toString(), productDesc: productDesc, date: date);
    // if (response is List<Transaction>) {
    //   notificationList.addAll(response ?? []);
    //   isAllPagesLoaded = response?.isEmpty ?? true;
    //   response = notificationList;
    // }
    // notificationFetcher.sink.add(response);
    return Transaction.getList();
  }
}
