import 'package:bloc_login_page/utilities/dynamic_link_utils.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class DynamicLinkGeneratorPage extends StatefulWidget {
  const DynamicLinkGeneratorPage({Key? key}) : super(key: key);

  @override
  State<DynamicLinkGeneratorPage> createState() =>
      _DynamicLinkGeneratorPageState();
}

class _DynamicLinkGeneratorPageState extends State<DynamicLinkGeneratorPage> {
  Uri link = Uri.parse("");
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Link Generator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text("Code"),
              ),
              controller: codeController,
            ),
            ElevatedButton(
              child: const Text("Generate"),
              onPressed: () async {
                Uri referralLink = await DynamicLinkUtils(codeController.text)
                    .createDynamicLink();

                print(referralLink);
                setState(() {
                  link = referralLink;
                });
              },
            ),
            Text(link.toString()),
            ElevatedButton(
              child: const Text("Share"),
              onPressed: () async {
                if (true) {
                  await Share.share('${link}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
