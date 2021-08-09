import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screens/homeScreen/wrapper.dart';
import 'package:firebase_authentication/screens/services/authentication_services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
      final _init = Firebase.initializeApp();
      return FutureBuilder(
        future: _init,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return ErrorWidget();
          }
          else if(snapshot.hasData){
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: AuthServices()),
                StreamProvider<User>.value(value: AuthServices().user, initialData: null)
                
              ],
              child: MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.deepPurple,
                ),
                debugShowCheckedModeBanner: false,
                home: Wrapper(),
              ),
            );
          }
          else{
            return Loading();
          }
      },
    );
  }
}



class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.error),
            Text("SomeThing Went Wrong")
          ],
        ),
      ),
    );
  }
}


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
} 