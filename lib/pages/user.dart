import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/model/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignIn.dart';



class about extends StatefulWidget {
  final Chatuser user;
  const about({Key? key, required this.user}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {

      return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar (

        title: Center(
          child: Text(
            widget.user.name,
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
        child: Icon(Icons.man),

      ),
        body: Column(
          children: [
            CachedNetworkImage(
              // width: 40.w,
              // height: 40.h,
              imageUrl:widget .user?.image ?? 'fallback_image_url_if_null',
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person),),
            ),

          ],
        ),


    );
  }
}
