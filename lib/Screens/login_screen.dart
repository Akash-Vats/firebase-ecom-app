import 'package:chat_app/Models/user_model.dart';
import 'package:chat_app/Screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  FirebaseAuth auth=FirebaseAuth.instance;
  bool password=false;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
      
          children: [
          const Text("Login Screen",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black),),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text("E-Mail",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
              TextField(controller:emailController,decoration: InputDecoration(hintText: "Enter your Email",
                  enabledBorder:const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
              const SizedBox(height: 20,),
              const Text("Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
              TextField(
                obscureText: !password,
                controller:passController,decoration: InputDecoration(hintText: "Enter your Password",
                  enabledBorder:const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      password=!password;
                    });
                  },
                    icon:Icon(password ? Icons.visibility:Icons.visibility_off,color: Colors.black,),)
      
              ),),
      
            ],),
          ),
            SizedBox(height: 20,),
            SizedBox(
              height: size.height/16,
              width: size.width/1.6,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor: Colors.black
      
                  ),
                  onPressed: (){
      if(emailController.text.trim().isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter email")));
      }
      else if(passController.text.trim().isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter password")));
      }
      else{
       login(emailController.text.trim().toString(),passController.text.trim().toString() ) ;
      }
                  }, child: const Text("Login",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),)),
            )
        ],),
        bottomNavigationBar: Container(child:  Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("don't have an account?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black
          ),),
          InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
          },
              child: Text("SignUp",style: TextStyle(fontWeight:FontWeight.w400,color: Colors.blue,fontSize: 20),))
        ],),),
      ),
    );
  }


  void login(String email,String password)async{
    UserCredential credential;

    try{
      credential=await auth.signInWithEmailAndPassword(
          email: email,
          password: password);
      if(credential!=null){

        String uid=credential.user!.uid;
        DocumentSnapshot userData= await FirebaseFirestore.instance.collection("users").doc(uid).get();
        UserModel userModel=UserModel.fromMap(userData.data() as Map<String,dynamic> );


        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(userModel: userModel,
            firebaseUser: credential!.user!)));
        emailController.clear();
        passController.clear();
      }


    }catch(e){

    }
  }
}
