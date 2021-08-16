import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movielist/database.dart';
import 'package:movielist/model.dart';
class MovieEdit extends StatefulWidget {
  MovieModel m;
  MovieEdit(this.m);

  @override
  _MovieEditState createState() => _MovieEditState();
}

class _MovieEditState extends State<MovieEdit> {
  static String path='';
  static String ms='';
  static String d ='';
  late TextEditingController mnamec;
   late TextEditingController dnamec;

  void addm() async {
    MovieModel mov = MovieModel(id:widget.m.id,mname: mnamec.text, dname: dnamec.text, img: path);
    await mdata.instance.update(mov);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mnamec = TextEditingController(text:widget.m.mname);
    dnamec = TextEditingController(text:widget.m.dname);
    path = widget.m.img!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Edit a movie"),
      ),
      backgroundColor: Color(0xFF0F044C),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
          alignment: Alignment.center,
          child: Container(
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 1, color: Colors.white70, style: BorderStyle.solid)),
            child: TextFormField(
              controller: mnamec,
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                  hintText: 'Enter movie name',
                  hintStyle: TextStyle(
                    color: Colors.white70
                  ),
                  contentPadding: EdgeInsets.all(15),
                  border: InputBorder.none),
              onChanged: (value) {},
            ),
          ),
          
        ),
        Container(
         
          alignment: Alignment.center,
          child: Container(
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 1, color: Colors.white70, style: BorderStyle.solid)),
            child: TextFormField(
              controller: dnamec,
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                
                  hintText: 'Enter director name',
                  hintStyle: TextStyle(
                    color: Colors.white70
                  ),
                  contentPadding: EdgeInsets.all(15),
                  border: InputBorder.none),
              onChanged: (value) {},
            ),
          ),
          
        ),
        ElevatedButton(
          onPressed: () async{
            ImagePicker picker=ImagePicker();
            var image= await picker.pickImage(source: ImageSource.gallery);
            setState(() {
              path=image!.path;
            });
          },
          child: Container(
            
            height: 50,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_file, color: Colors.white70,),
                Text(
                  "Attach Poster",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              //color: Color(0xFF787A91),
              border: Border.all(
                      width: 1, color: Colors.white70, style: BorderStyle.solid)),
            ),
        ),
          TextButton(
            onPressed: (){
               addm();
               Navigator.pop(context);
              
            },
            child: Container(
            
            height: 50,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "Add to list",
                  style: TextStyle( fontSize: 16),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF787A91),
            ),
            ),
          ),
        
            ],
          ),
        ),
      ),
    );
  }
}