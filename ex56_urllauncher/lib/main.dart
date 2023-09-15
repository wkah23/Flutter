import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ex56 URL Launcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _launchURL('https://m.google.com'), 
              child: const Text('https',
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => _launchURL('tel:010-9180-2524'), 
              child: const Text('tel',
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => _sendEmail(), 
              child: const Text('email',  // 스팸, 광고, 
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => _sendSMS(), 
              child: const Text('sms',  // 스팸, 광고, 안전문자
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  void _launchURL(url) async {
    Uri _url = Uri.parse(url);
    await canLaunchUrl(_url) ? await launchUrl(_url) 
    : throw 'Could not launch $url';
  }
  void _sendSMS() {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: '010 9180 2524',
      queryParameters: <String, String> {
        'body' : Uri.encodeComponent('Example Subject & Symbols are allowed'),
      },
    );
    launchUrl(smsLaunchUri);
  }
  void _sendEmail() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'wkah23@naver.com',
      query: encodequeryParameters(<String, String> {
        'subject' : 'Example Subject & Symbols are allowed!',
      }),
    );
    launchUrl(emailLaunchUri);
  }
  String? encodequeryParameters(Map<String, String> params) {
    return params.entries
      .map((MapEntry<String, String> e) => 
        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
  }
}
