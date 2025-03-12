import 'package:flutter/material.dart';
import 'package:dotby1/youtubeplayer.dart';
import 'package:google_fonts/google_fonts.dart';

class Talk extends StatefulWidget {
  const Talk({super.key});

  @override
  State<Talk> createState() => _TalkState();
}

class _TalkState extends State<Talk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Talk Shows',style: GoogleFonts.aDLaMDisplay(fontSize:30,color: Colors.black),),
        elevation: 0,),
      body: SingleChildScrollView(
        child: 
        Center(child:  Column(
         
          children: [
            SizedBox(height: 50,),
     const       YouTubePlayerWidget(videoId: '7a8WMmFnP7s'), 
            SizedBox(height: 20),
       const     YouTubePlayerWidget(videoId: 'knLGO_7_y8Q'), 
             SizedBox(height: 20),
           
      SizedBox(height: 20),
  const          YouTubePlayerWidget(videoId: 'SQBwBHiczMM'), 
             SizedBox(height: 20),
     const       YouTubePlayerWidget(videoId: 'UfIDIBMpO6Q'), 
             SizedBox(height: 20),
    const        YouTubePlayerWidget(videoId: 'sdGLmsWTWPE'), 
             SizedBox(height: 20),
      const      YouTubePlayerWidget(videoId: 'bUplF7Gemj4'), 
             SizedBox(height: 20),
          
      ],),)
      ),
    );
  }
}