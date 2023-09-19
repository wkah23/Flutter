import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

// 백그라운드/중지된 상태에서의 메시지 처리 - 앱에 뱃지 표시 등 ...
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 백그라운드 메시지 핸들러 세팅
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /* Create an Android Notification Channel.
    We use this channel in the `AndroidManifest.xml` file to override the
    default FCM channel to enable heads up notifications. */
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Update the iOS foreground notification presentation options
    // to allow heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  RemoteMessage? _message;
  String _myText = '';

  // 사용자가 폰을 바꾸면 토큰이 바뀐다.
  // 앱 삭제시 변경된다.
  // - 앱별로 푸시가 이루어질 수도 있지만, 사용자를 특정해 푸시를 보내려면
  // - 매번 토큰을 구해서 서버의 개인 정보에 업데이트 해야 한다.
  void setToken(String? token) {
    print('FCM Token: $token');
  }
  
  @override
  void initState() {
    super.initState();
    
    // 앱이 시작될 때 확인 안 한 메시지가 있다면 여기서 나온다. 없다면 null
    // 여러개가 있다면 가장 최근의 것이 나온다.
    FirebaseMessaging.instance.getInitialMessage()
      .then((RemoteMessage? message) {
        print('aaaaaa ======================================');
        print(message?.data['message']);
        if (message != null) {
          _message = message;
        }
        // callSanckBar(message?.data['message']); // <-- 빌드전이라 에러 발생
      });

    // 앱이 실행 중일 때 알림 메시지가 올 경우 처리
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print(message.notification?.title);
      // print(message.notification?.body);
      // print(message.data);
      print('bbbbbb ======================================');
      if (message.data['message'] != null) {
        print(message.data['message']);  // 서버에서 푸시 메시지에 사용한 키 값
        callSanckBar(message.data['message']);
      } else {
        print('bbbbbb bbbbbb ===============================');
      }

      // 시스템 알림 창에 등록
      /*
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
      */
    });

    // 앱이 백그라운드에 있을 때 푸쉬 메시지의 내용을 클릭한 경우
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('cccccc ======================================');
      print(message.data['message']);
      _message = message;
    });
 
    // 폰의 토큰을 앱 실행시마다 구해온다.
    FirebaseMessaging.instance
      .getToken(vapidKey:
        'ejZBh7JPQ4SWqxQqHXYgWD:APA91bH5tq5xkUUW5SCUjBGlz1n9KSuzFwG1BQTIAv6ZQeIBGrt37E6zF2w4XNJeNRBLqm2AUt4pdT0FtLIBLIad5RvQkbOkY5gixUT9VC6GQKcr8RjtMLy-eiHEUje6sHv1KgI5NERg')
      .then(setToken);
    // _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    // _tokenStream.listen(setToken);
  }

  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
          print('Subscribing to topic "fcm_test" successful.');
        }
        break;
      case 'unsubscribe':
        {
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
          print('Unsubscribing from topic "fcm_test" successful.');
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            String? token = await FirebaseMessaging.instance.getAPNSToken();
            print('Got APNs token: $token');
          } else {
            print('Getting an APNs token is only supported on iOS and macOS platforms.');
          }
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: onActionSelected,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'subscribe',
                  child: Text('Subscribe to topic'),
                ),
                const PopupMenuItem(
                  value: 'unsubscribe',
                  child: Text('Unsubscribe to topic'),
                ),
                const PopupMenuItem(
                  value: 'get_apns_token',
                  child: Text('Get APNs token (Apple only)'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              _myText,
              style: const TextStyle(fontSize: 30.0,),
            ),
            const SizedBox(height: 20), // 간단한 간격 조정
            ElevatedButton(
              child: const Text('Firebase Cloud Message',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                setState(() {
                  // 상태바 변한 변수를 가진 객체는 다시 그려라.
                  if (_message != null) {
                    _myText = _message!.data['message'];
                  } else {
                    _myText = "출력할 내용이 없습니다.";
                  }
                });
              },
            ),

          ],
        ),
      ),
    );
  }

  callSanckBar(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(color: Colors.black,)),
        backgroundColor: Colors.yellow[800],
        duration: Duration(milliseconds: 10000),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.black,
          onPressed: () {},
        ),
        // behavior: SnackBarBehavior.floating,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   side: BorderSide(
        //     color: Colors.red,
        //     width: 2,
        //   ),
        // ),
      ),
    );  
  }
}