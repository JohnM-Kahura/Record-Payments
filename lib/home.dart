import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:record_payment/sheets_api.dart';
import 'package:record_payment/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        
        title: const Center(child: Text('Home'))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 25, top: 25),
              width: MediaQuery.of(context).size.width - 100,
             
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: "Paste Message Here ...",
                  hintStyle: TextStyle(fontSize: 15),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 5,
                maxLines: 15,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    FlutterClipboard.paste().then((value) {
                      // Do what ever you want with the value.
                      setState(() {
                        messageController.text=value;
                      });
                    });
                  },
                  child: Text(
                    'Paste',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow)),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      messageController.text='';
                    });
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow)),
                ),
                TextButton(
                  onPressed: () async{
                    final user={
                      UserFields.id:1,
                      UserFields.name:"John",
                      UserFields.email:"johnmungai392@gmail.com",
                      UserFields.age:15,
                    };
                    await UserSheetsApi.insert([user]);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
