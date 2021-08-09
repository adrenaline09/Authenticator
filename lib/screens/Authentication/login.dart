import 'package:firebase_authentication/screens/services/authentication_services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function toggleScreen;

  const Login({Key key, this.toggleScreen}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
   TextEditingController _emailController;
   TextEditingController _passwordController;
   final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed:(){}, 
                    icon: Icon(CupertinoIcons.back),
                    color: Theme.of(context).primaryColor,
                    ),
                  SizedBox(height: 80),
                  Text("Welcome Back",
                  style: TextStyle(fontSize:  22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text("sing in to continue", 
                  style: TextStyle(fontSize: 14, color: Colors.grey),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _emailController,
                    validator: (val)=> val.isNotEmpty? null: "Please enter email address",
        
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(CupertinoIcons.mail_solid,color: Colors.deepPurple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: (val)=> val.length< 6 ? "Password length is less than 6 char": null,
                    decoration: InputDecoration(
                      hintText: "Password",
                       prefixIcon: Icon(Icons.vpn_key,color: Colors.deepPurple,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  SizedBox(height: 30,),
                  MaterialButton(
                    onPressed: () async {
                      if (_formkey.currentState.validate()){
                        print("Email: ${_emailController.text}");
                        print("Email: ${_passwordController.text}");

                        await loginProvider.login(_emailController.text.trim(), _passwordController.text.trim());
                      }
                    },
                    height: 60,
                    minWidth: loginProvider.isLoading? null: double.infinity,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: loginProvider.isLoading? CircularProgressIndicator(): Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const Divider(
                  height: 80,
                  thickness: 2,
                  indent: 70,
                  endIndent: 70,
                  color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have an account ? "),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: ()=>widget.toggleScreen(), 
                        child: Text("Register"))
                    ],
                  )
          
                ],
              ),
            ),
          ),
        ),
      ),      
    );
  }
}

//////https://www.youtube.com/watch?v=r4EY8oou_VI  4:49