import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'home.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  final String text = "Followers";
  File? _image ;
  final picker = ImagePicker();


  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance ;

  DatabaseReference databaseRef= FirebaseDatabase.instance.ref('Post') ;


   getImageGallery()async{
     // debugPrint("image");
    final pickedFile = await picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
    // debugPrint("image"+pickedFile!.path.toString());
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else {
        // print('no image picked');
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildcontent(),
          // NumbersWidget(),

        ],
      )
    );
  }

  Widget buildTop() {
    final bottom = profileHeight/2;
    final top = coverHeight - profileHeight/2;
   return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
       Container(
         margin: EdgeInsets.only(bottom: bottom),
       child:  buildCoverImage(),
       ),
        Positioned(
          top: top,
          child: buildProfileImage(),),
        Positioned(
          top: 200,
          left: 200,
          child: buildButtons(),)
      ],
    );
  }
  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.asset('images/cover.jpg',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
    ),
  );
  Widget buildProfileImage() => _image != null ? Container(
    height: 120,
    width: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(290),

      image: DecorationImage(


          image: FileImage(_image!.absolute,),fit: BoxFit.cover,
      ),
    ),

  ):const
  Text("Select your image");

//   Widget buildProfileImage() => _image != null ? CircleAvatar(
//     radius: profileHeight/2,
//     backgroundColor: Colors.grey.shade800,
//   backgroundImage: NetworkImage("https://scontent.fpew4-1.fna.fbcdn.net/v/t1.6435-9/84348838_691689641378722_1800703062193471488_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=174925&_nc_eui2=AeHyIqaQauF1Q_ZUCDYO58w11oOhKuaEUKzWg6Eq5oRQrJjGoxazlxqhjvy6MgFRlW-13X-q9LE78nWHivHHnvvZ&_nc_ohc=ipg3gJcgFWIAX-tznkt&_nc_ht=scontent.fpew4-1.fna&oh=00_AfA4pIeKd9CjbCPVyUzCxs5B4Fyipnq3gIKFAPMR0Jwerg&oe=6406F663"),
//   );

Widget  buildButtons() => FloatingActionButton.small(onPressed: (){

  getImageGallery();
},
  hoverColor: Colors.blueGrey,
  backgroundColor: const Color(0xff2bb741),
  child: const Icon(Icons.camera_enhance_outlined
  , size: 20,)
  ,);
  Widget buildcontent() => Column(

    children: [
      const SizedBox(height: 8,),
       const Text('Haider Ali'
        ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const Text('Flutter Developer'
        ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    const SizedBox(height: 16,),
      const Divider(),
      const SizedBox(height: 16,),
      const NumbersWidget(),
  const SizedBox(
    height: 10,
  ),

  ElevatedButton(
  child: const Text("Get User Data"),
  onPressed: () {
  FirebaseAuth.instance.signOut().then((value) {
  // print("Signed Out");
  Navigator.push(context,
  MaterialPageRoute(builder: (context) => const Home()));
  });
  },
  ),
      const SizedBox(
        height: 10,
      ),
      ElevatedButton(
        child: const Text("Logout"),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            // print("Signed Out");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          });
        },
      ),

      ElevatedButton(
        child: const Text("Logout"),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            // print("Signed Out");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          });
        },
      ),

    ],

  );

  Widget buildButton({
    required String text,
    required int value,
}) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('$value',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2,),
            Text(text,
            style: const TextStyle(fontSize: 6),)
          ],
        ),
      );
}
class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildButton(text: 'projects', value:39),
      buildDivider(),
      buildButton(text: 'Followers', value:10000000),
      buildDivider(),
      buildButton(text: 'Following', value:39),


    ],
  );
  Widget buildDivider() => Container(
    height: 24,
    child: const VerticalDivider(),
  );
  Widget buildButton({
    required String text,
    required int value,
}) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                '$value',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 2,),
            Text(
              text,
              style: const TextStyle( fontSize: 16),
            ),
          ],
        ),


      );
}
