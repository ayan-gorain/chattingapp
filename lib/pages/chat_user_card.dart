import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/model/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class Chatusercard extends StatefulWidget {

   final Chatuser user;
   const  Chatusercard({required this.user});

   @override
  State<Chatusercard> createState() => _ChatusercardState();
}

class _ChatusercardState extends State<Chatusercard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 5.sp,vertical: 4.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: (){},
        child: ListTile(
          leading:ClipOval(
            child: CachedNetworkImage(
              width: 40.w,
              height: 40.h,
              imageUrl: widget.user?.image ?? 'fallback_image_url_if_null',
             // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person),),
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about,maxLines: 1,),
          trailing: Container(
            width: 15.w,
            height: 15.h,
            decoration: BoxDecoration(color: Colors.greenAccent.shade400,
              borderRadius: BorderRadius.circular(10)
            ),

          ),


        ),
      ),
    );
  }
}
