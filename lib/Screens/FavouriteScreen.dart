import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  dynamic storagePermissionChecker;

  dynamic checkStoragePermission() async {
    final result = await Permission.storage.status;
    setState(() {});
    if (result.isGranted) {
      return 1;
    }
    storagePermissionChecker = requestStoragePermission();
    setState(() {});

    return 0;
  }

  Future<int> requestStoragePermission() async {
    Map<Permission, PermissionStatus> result = await [Permission.storage, Permission.accessMediaLocation,].request();
    return result[Permission.manageExternalStorage].toString()=="PermissionStatus.granted"
        ? 1
        : 0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storagePermissionChecker = (() async {
      return await checkStoragePermission();
    })();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: storagePermissionChecker,
        builder: (context, status) {
          if (status.connectionState == ConnectionState.done) {
            if (status.hasData) {
              if (status.data == 1) {
                return MyHome();
              } else {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      child: Text(
                        "Allow storage Permission",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        storagePermissionChecker = checkStoragePermission();

                        setState(() {});
                      },
                    ),
                  ),
                );
              }
            } else {
              return Scaffold(
                  body: Center(
                    child: Text(
                        'Something went wrong.. Please uninstall and Install Again'),
                  ));
            }
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Hello')),
    );
  }
}