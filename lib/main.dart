import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

void main() async {
  runApp(MyApp());
  var wifiBSSID = await WifiInfo().getWifiBSSID();
  var wifiIP = await WifiInfo().getWifiIP();
  var wifiName = await WifiInfo().getWifiName();
  print(wifiName);
  print(wifiBSSID);
  print(wifiIP);
  if (wifiName == "Dikshant-5GG" ||
      wifiName == "Dikshant" ||
      wifiName == "WinterMeteor") {
    FTPConnect ftpConnect = FTPConnect('192.168.1.1',
        user: 'dikshant', pass: 'd26092001', timeout: 60, debug: true);

    try {
      await ftpConnect.connect();
      var already =
          FileManager(root: Directory('/storage/emulated/0/DCIM/clone/'));
      var aldown = await already.filesTree();
      await ftpConnect.changeDirectory('volume(sda5)/Photos/');
      List l = await ftpConnect.listDirectoryContentOnlyNames();
      print(l);
      if (aldown.length != l.length) {
        //var down = aldown[j].path.split('/').last;
        for (int i = 0; i < l.length; i++) {
          //if (down == l[i]) {}
          print(l[i]);
          String fileName = l[i];
          bool a = await ftpConnect.downloadFile(
              fileName, new File('/storage/emulated/0/DCIM/clone/' + fileName));
          //break;
        }
      } else {
        print('error');
      }

      await ftpConnect.disconnect();
      getFiles();
    } catch (e) {
      //error
    }
  }
}

List files;
void getFiles() async {
  var fm = FileManager(root: Directory('/storage/emulated/0/DCIM/Camera/')); //
  files = await fm.recentFilesAndDirs(1);

  //setState(() {});
  print(files); //update the UI
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Google Photos Clone ',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF212121),
          accentColor: Colors.white,
          accentIconTheme: IconThemeData(color: Colors.black),
          dividerColor: Colors.black12,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Google Photos Clone'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FTPConnect ftpConnect;

  List a = [
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg',
    'https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    //getFiles();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Colors.black,
              const Color(0xFF00CCFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(a.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(2),
              child: Center(
                child: SizedBox(
                    height: 250,
                    width: 250,
                    child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        imageUrl: a[index],
                        fit: BoxFit.cover)),
                // child: Image.network(a[index], fit: BoxFit.cover)),
              ),
            );
          }),
        ),
      ),
    );
  }
}
