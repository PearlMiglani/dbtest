import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movielist/database.dart';
import 'package:movielist/edit.dart';
import 'package:movielist/form.dart';


class MListScreen extends StatefulWidget {
  const MListScreen({ Key? key }) : super(key: key);

  @override
  _MListScreenState createState() => _MListScreenState();
}

class _MListScreenState extends State<MListScreen> {
  late bool load;
  List mlist=[];
  void fetch() async{
    setState(() {
      load=true;
    });
  mlist= await mdata.instance.movielist();
  setState(() {
    load = false;
  });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xFF0F044C),
      body: SafeArea(bottom:false,child: Container(
        child: Column(children: [
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: 
                  [Text(
                    "MOVIE WATCH LIST",
                    style: TextStyle(color: Colors.white70, fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: IconButton(onPressed: () async{
                      await Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieInsert()));
                      setState(() {
                        
                        fetch();
                      });
                    },icon: Icon(Icons.add_to_photos_rounded, color: Colors.white70, size: 50,)),
                  )
                  ]
                  ),
              ),
            ),
            height: MediaQuery.of(context).size.height*0.15,
            width: double.infinity,
            
          ),
          Expanded(
            child: load?Center(child: CircularProgressIndicator(),):Container(
              //height: MediaQuery.of(context).size.height*0.80,
              width: double.infinity,
              
              decoration: BoxDecoration(
                color: Color(0xFF787A91),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
              ),
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right:25),
              child: mlist.length==0?Center(child: Text('No movies to display', style: TextStyle(fontSize: 18),),):ListView.builder(itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 170,
                    
                    decoration: BoxDecoration(
                      color: Color(0xFF0F044C),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
  
                        IconButton(onPressed:()async {
                                await Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieEdit(mlist[index])));
                                setState(() {
                                  fetch();
                                });
                              },icon: Icon(Icons.edit, color: Colors.white70,)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            
                            Container(
                              height: 120,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Color(0xFF0F044C),
                                borderRadius: BorderRadius.circular(15),
                                image:mlist[index].img==''?null:DecorationImage(image: FileImage(File('${mlist[index].img}'),),fit: BoxFit.cover)
                              ),
                            ),
                            Text(
                              "${mlist[index].mname}, ${mlist[index].dname}",
                              style: TextStyle(color: Colors.white70),
                            ),

                          
                          
                          ],
                        ),
                    IconButton(onPressed:()async{
                      await mdata.instance.delete(mlist[index].id);
                      setState(() {
                        fetch();
                      });
                    },icon: Icon(Icons.delete, color: Colors.white70,)),

                      ],
                    ),
                  ),
                );
              },
              itemCount: mlist.length,),
              
            ),  
            ),
            
          ),
          
        ],),
        
      ),),
    );
  }
}