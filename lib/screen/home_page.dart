import 'package:bloc_login_page/screen/dynamic_link_generator_screen.dart';
import 'package:bloc_login_page/screen/in_app_messaging_app.dart';
import 'package:bloc_login_page/screen/profile_page.dart';
import 'package:bloc_login_page/screen/transaction_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    InAppMessagingPage(),
    TransactionPage(),
    DynamicLinkGeneratorPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Home Page"),
        // ),
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messaging',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.link),
              label: 'Dynamic Link',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
      ),
    );
    //   Center(
    //     child: Column(
    //       children: [
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => const TransactionPage(),
    //               ),
    //             );
    //           },
    //           child: const Text("Transaction Page"),
    //         ),
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => const DynamicLinkGeneratorPage(),
    //               ),
    //             );
    //           },
    //           child: const Text("Dynamic Link Generator Page"),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
