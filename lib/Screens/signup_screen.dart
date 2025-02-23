import 'dart:developer';

import 'package:chat_app/Models/user_model.dart';
import 'package:chat_app/Screens/complete_profile_screen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController conPassController=TextEditingController();
  FirebaseAuth auth=FirebaseAuth.instance;

  bool password=false;
  bool cPassword=false;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          const Text("Register Screen",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black),),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("E-Mail",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                TextField(controller:emailController,decoration: InputDecoration(hintText: "Enter your Email",
                    enabledBorder:OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
                const SizedBox(height: 20,),
                const Text("Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                TextField(
                  obscureText:!password,
                  controller:passController,decoration: InputDecoration(hintText: "Enter your Password",
                    enabledBorder:OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        password=!password;
                      });
                    },
                      icon:Icon(password ? Icons.visibility:Icons.visibility_off,color: Colors.black,),)

                ),),
                const SizedBox(height: 20,),
                const Text("Confirm Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                TextField(
                  obscureText: !cPassword,
                  controller:conPassController,decoration: InputDecoration(hintText: "Enter your Confirm Password",
                    enabledBorder:const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        cPassword=!cPassword;
                      });
                    },
                      icon:Icon(cPassword ? Icons.visibility:Icons.visibility_off,color: Colors.black,),)

                ),),

              ],),
          ),
          const SizedBox(height: 20,),
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
                     else if(conPassController.text.trim().isEmpty){
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter confirm password")));
                       
                     }
                     else if(passController.text.trim()!=conPassController.text.trim())
                       {
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("confirm password is not matched")));
                       }

                     else{
                       signUp(emailController.text.trim().toString(),passController.text.trim().toString(),);
                     }
                }, child: const Text("Sign Up",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),)),
          )
        ],),
    );
  }


  void signUp(String email,String password)async{
    UserCredential credential;
   try{
     credential=await auth.createUserWithEmailAndPassword(
       email:email ,
       password: password,
     );

     if(credential!=null){
       String uid =credential.user!.uid;
       UserModel newUser=UserModel(
         uid: uid,
         email: email,
         fullName: "",
         profilePic: ""
       );
       await FirebaseFirestore.instance.collection("users").doc(uid).set(newUser.toMap());
       log("Account Created");

       Navigator.push(context, MaterialPageRoute(builder: (context)=>
           ProfileScreen(userModel: newUser, firebaseUser: credential!.user!)));
       emailController.clear();
       passController.clear();
     }
     }

   catch(e){

   }
  }
}
