import 'package:bloc_login_page/bloc/home/home_bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteConfigPage extends StatefulWidget {
  const RemoteConfigPage({Key? key}) : super(key: key);

  @override
  State<RemoteConfigPage> createState() => _RemoteConfigPageState();
}

class _RemoteConfigPageState extends State<RemoteConfigPage> {
  HomeBloc bloc = HomeBloc();
  bool showBanner = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(HomeFetchingEvent()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Remote Config Banner"),
          ),
          body: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeInitialState) {
                context.read<HomeBloc>().add(HomeInitialEvent());
              }
              if (state is HomeFetchingState) {
                context.read<HomeBloc>().add(HomeFetchingEvent());
              }
            },
            builder: (context, state) {
              if (state is HomeFetchedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _alertDialog(),
                    _campaignBanner(),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  _campaignBanner() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(color: Colors.amber),
        child: Container(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  height: 50,
                  width: 300,
                  margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Ink(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
                  //             CachedNetworkImage(
                  //   imageUrl: image,
                  // ),
                ),
                onTap: () {},
              );
            },
          ),
        ));
  }

  _alertDialog() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: showBanner
          ? AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              title: const Text('True'),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    print("Pressed OK");
                  },
                ),
              ],
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('This is a true alert dialog.'),
                  ],
                ),
              ),
            )
          : AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              title: const Text('False'),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    print("Pressed OK");
                  },
                ),
              ],
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('This is a false alert dialog.'),
                  ],
                ),
              ),
            ),
    );
  }
}
