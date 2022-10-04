import 'dart:async';

import 'package:bloc_login_page/bloc/login/login_bloc.dart';
import 'package:bloc_login_page/repository/user_repository.dart';
import 'package:bloc_login_page/screen/home_page.dart';
import 'package:bloc_login_page/screen/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  /*Firebase INIT*/
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp(
    userRepository: UserRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({Key? key, required this.userRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RepositoryProvider.value(
          value: userRepository,
          child: BlocProvider(
            create: (context) => LoginBloc(userRepository: userRepository),
            child:
                // const DynamicLinkGeneratorPage(),
                AppView(),
          ),
        ));
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
  StreamSubscription? _sub;

  @override
  void initState() {
    fetchLinkData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => const LoginPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/homepage': (context) => const HomePage(),
      },
      builder: (context, child) {
        return BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginState) {
              return LoginPage();
              // return const DynamicLinkGeneratorPage();
            } else if (state is LoginSubmitted) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("HomePage"),
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.directions_car)),
                      Tab(icon: Icon(Icons.directions_transit)),
                      Tab(icon: Icon(Icons.directions_bike)),
                    ],
                  ),
                ),
                body: const Center(
                  child: Text("AppView"),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("HomePage"),
                ),
                body: const Center(
                  child: Text("AppView"),
                ),
              );
            }
          },
        );
      },
    );
  }

  void fetchLinkData() async {
    // FirebaseDynamicLinks.getInitialLInk does a call to firebase to get us the real link because we have shortened it.

    var link = await FirebaseDynamicLinks.instance.getInitialLink();
    // This link may exist if the app was opened fresh so we'll want to handle it the same way onLink will.
    if (link != null) {
      handleLinkData(link);
    }

    // This will handle incoming links if the application is already opened
    FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) async {
      handleLinkData(dynamicLink!);
    }, onError: (OnLinkErrorException e) async {
      //print('onLinkError');
      //print("message ERROR ${e.message}");
    });
  }

  void handleLinkData(PendingDynamicLinkData data) {
    final Uri? uri = data.link;
    if (uri != null) {
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        String? screen = queryParams["screen"];
        // verify the username is parsed correctly
        print("My screen params is: $screen");
      }
    }
  }
}
