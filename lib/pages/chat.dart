import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
    File? imageFile;
  TextEditingController fullNameController=TextEditingController();



  void selectImage(ImageSource source) async{
   XFile? pickedFile= await ImagePicker().pickImage(source: source);
   if(pickedFile != null){
     cropImage(pickedFile);
   }

  }
  void cropImage(XFile file) async{
    ImageCropper crop = ImageCropper();
    File? croppedImage =await crop.cropImage(sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),

    );

  }



  void showPhotoOptions(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(
          "Upload Profile Photo"
        ),
        content: Column(
          children: [
            ListTile(
              onTap: ()
                {
                  Navigator.pop(context);
                  selectImage(ImageSource.gallery);
                },
              leading: Icon(Icons.photo_album),
              title:Text("Select From Gallary")
            ),
            ListTile(
                onTap: ()
                {
                  Navigator.pop(context);
                  selectImage(ImageSource.camera);
                },
                leading: Icon(Icons.camera_alt),
                title:Text("Select From Camera")
            ),
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Complete Profile"),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Colors.greenAccent[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 150,),
            Center(
              child: CupertinoButton(
                onPressed: (){
                  showPhotoOptions();
                },
                child: CircleAvatar(
                  radius: 69,
                  backgroundImage: (imageFile != null) ? FileImage(imageFile!) : null,
                  child:(imageFile != null)?  Icon(Icons.person,size:60) :null,
                ),
              ),
            ),
            SizedBox(height: 60,),
            SizedBox(
              height: 100,
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 90,),
            OutlinedButton(
              child: Text('Complete Sign Up'),
              style: OutlinedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {},
            ),


          ],
        ),
      ),
    );
  }
}
