import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkUtils {
  DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://bloclogindeeplinking.page.link',
    link: Uri.parse('https://bloclogindeeplinking.page.link'),
  );

  DynamicLinkUtils(String code) {
    parameters = DynamicLinkParameters(
      uriPrefix: 'https://bloclogindeeplinking.page.link',
      link: Uri.parse('https://bloclogindeeplinking.page.link?screen=${code}'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.bloc_login_page',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Generate Code',
        description: 'This is a link for generated code: ',
      ),
    );
  }

  Future<Uri> createDynamicLink() async {
    final link = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      link,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    return shortenedLink.shortUrl;
  }
}
