import 'dart:io'; // File

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';  // 앨범과 카메라

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
      home: const MyHomePage(title: 'Ex52 Camera'),
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
  final ImagePicker _picker = ImagePicker();
  // ImagePicker 모듈에서 File 객체 반환. IOS에서 에러
  // late File mPhoto;    // <- 나중에 들어온다.
  File? mPhoto;         // 널 일수도 있다.
  XFile? image;
  @override
  Widget build(BuildContext context) {
    // Widget photo = (mPhoto != null) ? Image.file(mPhoto!) : Text('EMPTY');
    late Widget photo;
    if (mPhoto != null) {
      photo = Image.file(
        mPhoto!,
        fit: BoxFit.contain,  // 작은 쪽에 맞춤. 큰 쪽에 여백 남음
        // alignment: Alignment.center,     // 현재는 필요 없음
        // width: 300.0,
        // height: 300.0,
      );
    } else {
      photo = Text('EMPTY');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => takePhoto(ImageSource.gallery), 
                  child: const Text('Album',
                      style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 5,),
                ElevatedButton(
                  onPressed: () => takePhoto(ImageSource.camera), 
                  child: const Text('Camera',
                      style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 5,),
                ElevatedButton(
                  onPressed: () => savePhoto(), 
                  child: const Text('Save',
                      style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
            Expanded(child: photo),
          ],
        ),
      ),
    );
  }
  void takePhoto(ImageSource source) async {
    // 이미지 가져오기
    // final XFile? image = await _picker.pickImage(source: source);
    image = await _picker.pickImage(source: source);
    setState(() {
      mPhoto = File(image!.path);
    });
  }
  void savePhoto() async {
    /*
    await _picker.pickImage(source: ImageSource.camera)
      .then((XFile? image) {
        if (image != null) {
          setState(() {
            mPhoto = File(image.path);
          });
          GallerySaver.saveImage(image.path)
            .then((bool? success) {
              print('image saved on gallery... $success');
            });
        }
      });
    */
    // mPhoto
    if (image != null) {
      GallerySaver.saveImage(image!.path)
        .then((bool? success) {
          print('Image saved on gallery');
        });
    }
  }
}
