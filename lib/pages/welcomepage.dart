import 'dart:math';

import 'package:chatapp/pages/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/api.dart';
import '../model/chat_user.dart';
import 'chat_user_card.dart';



class welco extends StatefulWidget {

  const welco({super.key});

  @override
  State<welco> createState() => _welcoState();
}

class _welcoState extends State<welco> {
  List<Chatuser> list=[];
  final List<Chatuser> _searchList=[];
  bool  _isSerching =false;
  @override
  void initState(){
    super.initState();
    Apis.getselfInfo();
  }
  Widget build(BuildContext context) {



    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if(_isSerching){
            setState(() {
              _isSerching=!_isSerching;
            });
            return Future.value(false);
          }else{

            return Future.value(true);
          }
        },

        child: Scaffold(
          backgroundColor: Colors.white,
          appBar:AppBar (
            title: _isSerching?
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,hintText: 'Name,Email,.....',
                  ),
                  autofocus: true,
                  style: TextStyle(fontSize: 17,letterSpacing: 0.5),
                  onChanged: (val){
                    _searchList.clear();
                    for(var i in list){
                      if(i.name.toLowerCase().contains(val.toLowerCase())&&i.email.toLowerCase().contains(val.toLowerCase())){
                        _searchList.add(i);
                      }
                      setState(() {
                        _searchList;
                      });
                    }
                  },
                ):
            Center(
              child: Text(
                'AisAy Connectify',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSerching=!_isSerching;
                  });
                }, icon: Icon(_isSerching?CupertinoIcons.clear_circled_solid:Icons.search_rounded),

              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => about(user: Apis.me),
                    ),
                  );
                }, icon: Icon(Icons.more_vert),

              ),
            ],

          ),
          floatingActionButton: FloatingActionButton(onPressed: () {  },
            child: Icon(Icons.add_comment_rounded),

          ),
          body:StreamBuilder(
              stream: Apis.getallusers(),
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
                    itemCount: _isSerching?_searchList.length:list.length,
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return Chatusercard(user:
                          _isSerching ? _searchList[index] : list[index]
                      );
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

        ),
      ),
    );
  }
}
