import 'dart:async';

import 'package:bloc_login_page/TransactionList/transaction_list.dart';
import 'package:bloc_login_page/bloc/transaction/transaction_bloc.dart';
import 'package:bloc_login_page/repository/transaction_repository.dart';
import 'package:bloc_login_page/widgets/progress_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TransactionBloc bloc = TransactionBloc();
  ScrollController controller = ScrollController();
  int pageNo = 1;
  List<Transaction> _transactions = [];

  @override
  void initState() {
    pageNo = 1;
    controller = ScrollController()..addListener(_scrollListener);
    // print(controller.offset);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(TransactionInitializeEvent(pageNo)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Transaction Page"),
        ),
        body: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionInitial) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Loading!'),
                ),
              );
            }
            if (state is TransactionFetchedState) {
              if (state.isAll) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('That\'s all transaction!'),
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is TransactionInitial) {
              context
                  .read<TransactionBloc>()
                  .add(TransactionInitializeEvent(pageNo));
            }
            if (state is TransactionFetchingState) {
              context
                  .read<TransactionBloc>()
                  .add(TransactionFetchingEvent(pageNo));
            }
            if (state is TransactionFetchedState) {
              if (state.transactions != []) {
                _transactions.addAll(state.transactions);
                return Scaffold(
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      controller: controller,
                      itemCount: _transactions.length - 1,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              _transactions[index].getName,
                              style: const TextStyle(fontSize: 22.0),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }
            return const Text("No transaction found!");
          },
        ),
      ),
    );
  }

  void _scrollListener() {
    TransactionRepository transactionRepository;
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      setState(() {
        _moveDown();
        pageNo++;
      });
      bloc.add(TransactionInitializeEvent(pageNo));
    } else {}
  }

  void _moveDown() {
    if (controller.hasClients) {
      Timer(const Duration(milliseconds: 300), () {
        controller.animateTo(
          controller.position.maxScrollExtent - 20,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 300),
        );
      });
    }
  }
}
