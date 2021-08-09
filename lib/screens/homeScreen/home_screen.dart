import 'package:firebase_authentication/screens/services/authentication_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(onPressed: () async =>loginProvider.logout() , icon: Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}