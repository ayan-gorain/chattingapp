import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/model/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/api.dart';

class chatting extends StatefulWidget {
  final Chatuser user;
  const chatting({super.key, required this.user});


  @override
  State<chatting> createState() => _chattingState();
}

class _chattingState extends State<chatting> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: SafeArea(
            child: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: _appBar(),

            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: Apis.getallmessage(),

                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        //return const Center(child: CircularProgressIndicator(),);
                      case ConnectionState.active:
                      case ConnectionState.done:
                         final data=snapshot.data?.docs;
                      log('data:${(jsonEncode(data![0].data()))}');
                      //     list=data?.map((e) => Chatuser.fromJson(e.data())).toList() ?? [];
                      // }
                        final list = ['HI','HELLO'];
                        if (list.isNotEmpty) {
                          return ListView.builder(
                              itemCount: list.length,
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(10)),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Text('Message: ${list [index]}');
                              });
                        } else {
                          return Center(
                            child: Text(
                              "Say Hi! ✋",
                              style: TextStyle(
                                  fontSize: 20.sp
                              ),),
                          );
                        }
                    }
                  },),
            ),
            _chatInput(),
          ],
        ),
      ),
    );
  }


  Widget _appBar() {
    return InkWell(
      onTap: (){},
      child: Row(
        children: [


          IconButton(onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back,color: Colors.black54,)),
          ClipRRect(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(70.0)),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: widget.user?.image ?? 'fallback_image_url_if_null',
              errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(widget.user.name,style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 2,),
              Text('last seen not available',style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.w500
              ),),


            ],
          ),
        ],

      ),
    );

  }
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setWidth(20),
          horizontal: ScreenUtil().setWidth(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                  onPressed: (){},
              icon: const Icon(Icons.emoji_emotions,color: Colors.blueAccent,),
              ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Text Something....',
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none,
                    ),

                  ),
                ),

                IconButton(
                  onPressed: (){},
              icon: const Icon(Icons.image,color: Colors.blueAccent,),
              ),
                IconButton(
                  onPressed: (){},
              icon: const Icon(Icons.camera,color: Colors.blueAccent,),
              ),


                ],
              ),
            ),
          ),
          MaterialButton(onPressed: (){},
            minWidth: 0,
            shape: CircleBorder(),
            color: Colors.blueAccent,
            child: Icon(Icons.send,color: Colors.white,size: 28,),
          )
        ],
      ),
    );
  }

}
