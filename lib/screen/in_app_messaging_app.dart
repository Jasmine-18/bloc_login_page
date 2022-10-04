import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigPage extends StatefulWidget {
  const RemoteConfigPage({Key? key}) : super(key: key);

  @override
  State<RemoteConfigPage> createState() => _RemoteConfigPageState();
}

class _RemoteConfigPageState extends State<RemoteConfigPage> {
  bool showBanner = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remote Config Banner"),
      ),
      body: _banner(),
    );
  }

  bannerConfiguration() async {
    //TODO: Remote config
    RemoteConfig _remoteConfig = await RemoteConfig.instance;
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await _remoteConfig.fetchAndActivate();
    Map<String, RemoteConfigValue> allconfig = _remoteConfig.getAll();
    debugPrint("Jasmine Print: showBanner: ${showBanner}");
    setState(() {
      showBanner = _remoteConfig.getBool('show_true_banner');
    });
    debugPrint("Jasmine Print: showBanner: ${showBanner}");
  }

  _banner() {
    return showBanner
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
          );
  }
}
