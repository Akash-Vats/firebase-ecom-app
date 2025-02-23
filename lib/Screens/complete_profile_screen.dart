import 'dart:io';


import 'package:chat_app/Models/user_model.dart';
import 'package:chat_app/Screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const ProfileScreen({super.key, required this.userModel,required this.firebaseUser});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController proController = TextEditingController();

   File? imageFile;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Complete Profile", style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),),),
      body: SafeArea(
        child: Column(children: [
          const SizedBox(height: 20,),
          InkWell(onTap: () {
            showPhotoOption();
          },
            child:  CircleAvatar(
              radius: 60,
              backgroundColor: Colors.black,
              backgroundImage: (imageFile!=null)?FileImage(imageFile!):null,
              child:(imageFile==null)? const Icon(Icons.person, size: 60, color: Colors.white,):null
            ),
          ),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Full Name", style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),),
                TextField(controller: proController,
                  decoration: InputDecoration(hintText: "Enter your full name",
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),),
              ],),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: size.height / 16,
            width: size.width / 1.6,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.grey,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor: Colors.black

                ),
                onPressed: () {
           uploadData();

                }, child: const Text("Submit",
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),)),
          )


        ],),
      ),
    );
  }

  void showPhotoOption() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(title: const Text("Upload Profile Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(onTap: () {
              Navigator.pop(context);
               selectImage(ImageSource.gallery);
            },
                child: const ListTile(
                  leading: Icon(Icons.photo_album_outlined,),
                  title: Text("Select from gallery"),)),
            
            InkWell(onTap: () {
              Navigator.pop(context);
              selectImage(ImageSource.camera);

            },
                child: const ListTile(
                  leading: Icon(Icons.camera_alt_outlined,),
                  title: Text("Take a photo"),)),
          ],),
      );
    }
    );
  }

  void selectImage(ImageSource source)async{
    XFile? pickedImage=await ImagePicker().pickImage(source: source);
    if(pickedImage!=null){

     setState(() {
       imageFile=File(pickedImage.path);
     });
    }
  }



  void uploadData()async{
UploadTask uploadTask=FirebaseStorage.instance.ref("profilepictures").child(widget.userModel.uid.toString()).putFile(imageFile!);
TaskSnapshot snapshot= await uploadTask;
String? imageUrl= await snapshot.ref.getDownloadURL();
String? fullName= proController.text.trim().toString();

widget.userModel.fullName=fullName;
widget.userModel.profilePic=imageUrl;
await FirebaseFirestore.instance.collection("users").doc(widget.userModel.uid).set(widget.userModel.toMap());

Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(userModel: widget.userModel,
    firebaseUser: widget.firebaseUser)));
  }

}