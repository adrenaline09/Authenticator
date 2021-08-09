import 'package:firebase_authentication/screens/services/authentication_services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;

  const Register({Key key, this.toggleScreen}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  Text("Welcome",
                  style: TextStyle(fontSize:  22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text("Create account to continue", 
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
                    onPressed: ()async{
                      if (_formkey.currentState.validate()){
                        print("Email: ${_emailController.text}");
                        print("Email: ${_passwordController.text}");
                         await loginProvider.register(_emailController.text.trim(), _passwordController.text.trim());
                      }
                    },
                    height: 60,
                    minWidth: loginProvider.isLoading? null : double.infinity,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: loginProvider.isLoading? CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    ): 
                    Text("Register", 
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
                      Text("Already have an account ? "),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: ()=>widget.toggleScreen(), 
                        child: Text("Login"))
                    ],
                  ),
                  SizedBox(height: 20,),
                  if(loginProvider.errorMessage != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.amberAccent,
                    child: ListTile(
                      title: Text(loginProvider.errorMessage),
                      leading: Icon(Icons.error),
                      trailing: IconButton(icon: Icon(Icons.close),onPressed: ()=> loginProvider.setMessage(null),),
                    ),
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