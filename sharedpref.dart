import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref/main.dart';

class Sharedpref extends StatefulWidget {
  const Sharedpref({super.key});

  @override
  State<Sharedpref> createState() => _SharedprefState();
}

class _SharedprefState extends State<Sharedpref>{

  TextEditingController txtname = TextEditingController();
  TextEditingController txtemail = TextEditingController();

  var namevalue;
  var emailvalue;

  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
    check();
  }

  Future<void> check() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    print(email);
    runApp(MaterialApp(home: email == null ? Sharedpref() : MyHomePage(title: 'Home Page')));
  }


  getValue() async
  {
    //get the data from shared preferences

    SharedPreferences pref = await SharedPreferences.getInstance();
    var name  = pref.getString("name");
    var email = pref.getString("email");
    // print(name);
    namevalue = name ?? 'No Data Found';
    emailvalue = email ?? 'No Data Found';

    print(namevalue);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:const Text('Shared Preference')
      ),
      body: Center(
        child: Column(
          children: [
            TextField(controller: txtname,
            decoration: const InputDecoration(
              labelText: 'Enter Name',
              hintText: 'Enter Name'
            ),
            keyboardType: TextInputType.text,
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(controller: txtemail,
              decoration: const InputDecoration(
                  labelText: 'Enter Email',
                  hintText: 'Enter Email'
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () async {
              setState(() async{
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("name", txtname.text.toString());
                pref.setString("email", txtemail.text.toString());
              });
            }, child: const Text('Save')),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(onPressed: () async {
              setState(() {
                getValue();
              });
            }, child: const Text("Get Data")),
            const SizedBox(
              height: 20,
            ),
            Text('$namevalue'),
            const SizedBox(
              height: 20,
            ),
            Text('$emailvalue')
          ],
        ),
      ),
    );
  }

}
