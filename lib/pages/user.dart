

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/model/api.dart';
import 'package:chatapp/model/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'SignIn.dart';



class about extends StatefulWidget {
  final Chatuser user;
  const about({Key? key, required this.user}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  final _formkey=GlobalKey<FormState>();
   String? _imagePath;
  @override
  Widget build(BuildContext context) {

      return GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar (
        
          title: Center(
            child: Text(
              'Profile Screen',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () async {
        
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>Signnn()));
        },
          child: const Icon(Icons.add_comment_rounded,)
        
        ),
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Stack(

                      children: [
                        _imagePath != null ?
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(50.0),
                            horizontal: ScreenUtil().setWidth(70.0),
                          ),
                          child: Container(
                            width: ScreenUtil().setWidth(200.0),
                            height: ScreenUtil().setHeight(200.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(70.0)),
                              child: Image.file(
                                  File(_imagePath!),
                                fit: BoxFit.fill,



                              ),
                            ),
                          ),
                        ):
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(50.0),
                            horizontal: ScreenUtil().setWidth(70.0),
                          ),
                          child: Container(
                            width: ScreenUtil().setWidth(200.0),
                            height: ScreenUtil().setHeight(200.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(70.0)),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: widget.user?.image ?? 'fallback_image_url_if_null',
                                errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                         bottom: 40,
                          right: 59,
                    
                          child: MaterialButton(onPressed: (){
                            _showBottomSheet();
                          },
                            child:Icon(FontAwesomeIcons.edit) ,
                          shape: CircleBorder(),
                          color: Colors.greenAccent,),
                        )
                      ],
                    )
                    ,
                    
                    SizedBox(height: 10.h,),
                    Text(widget.user.email),
                    SizedBox(height: 40.h,),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        initialValue: widget.user.name,
                        onSaved: (val)=>Apis.me.name=val ?? ' ',
                          validator: (val)=>val !=null && val.isNotEmpty ? null :'Requird filed',
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'eg. Happy Singh',
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        initialValue: widget.user.about,
                        onSaved: (val)=>Apis.me.about=val ?? ' ',
                        validator: (val)=>val !=null && val.isNotEmpty ? null :'Requird filed',
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                    
                          hintText: 'eg. Happy Singh',
                          labelText: 'About',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    ElevatedButton.icon(
                      onPressed: (){
                        if(_formkey.currentState!.validate()){
                          _formkey.currentState!.save();
                          Apis.UpdateUserInfo().then((value){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Success'),
                                  content: Text('Profile updated successfully!'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          });

                        }
                      },
                      icon: Icon(Icons.edit),  //icon data for elevated button
                      label: Text("Update"), //label text
                    )
                    
                  ],
                ),
              ),
            ),
          ),
        
        
            ),
      );
  }
  void _showBottomSheet(){
    showModalBottomSheet(context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(20.sp), topRight:Radius.circular(20.sp)
          )
        ),
        builder: (_){
      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(20),
          bottom: ScreenUtil().setWidth(20),
        ),
        children: [
          Text("Pick Profile Pic",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.h,fontWeight: FontWeight.w500

          ),),
          SizedBox(height: 30.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(100.w, 100.h),
                ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
// Pick an image.
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
                    if(image!=null){
                      setState(() {
                        _imagePath = image.path;
                      });
                      Apis.updateProfilePicture(File(_imagePath!));
                      Navigator.pop(context);
                    }

                  }, child: Image.asset('assets/images/g.png')

              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(100.w, 100.h),
                ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();


// Capture a photo.
                    final XFile? photo = await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
                    if(photo!=null){
                      setState(() {
                        _imagePath = photo.path;
                      });
                      Apis.updateProfilePicture(File(_imagePath!));
                      Navigator.pop(context);
                    }

                  }, child: Image.asset('assets/images/c.png')

              ),
            ],
          ),
          SizedBox(height: 30.h,),
        ],
      );
    });
  }
}
