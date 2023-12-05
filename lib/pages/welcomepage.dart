import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/chat_user.dart';
import 'chat_user_card.dart';
import '../model/chat_user.dart';

class welco extends StatelessWidget {
  const welco({super.key});

  @override
  Widget build(BuildContext context) {
     List<Chatuser> list=[];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar (

        title: Center(
          child: Text(
            'AisAy Connectify',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
          ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        child: Icon(Icons.add_comment_rounded),

      ),
      body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection('userss').snapshots(),
        builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator(),);
              case ConnectionState.active:
              case ConnectionState.done:


              final data=snapshot.data?.docs;
              list=data?.map((e) => Chatuser.fromJson(e.data())).toList() ?? [];
            }
          if(list.isNotEmpty){
            return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index){
                  return Chatusercard(user:list[index]);
                });
          }else{
            return Center(
              child: Text("No Connection found \n     Please try again",style: TextStyle(
                fontSize: 20.sp
              ),),
            );
          }
        }
      ),

    );
  }
}
