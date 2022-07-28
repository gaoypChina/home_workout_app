import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../constants/constant.dart';

class WriteUsPage extends StatefulWidget {
  const WriteUsPage({Key? key}) : super(key: key);

  @override
  State<WriteUsPage> createState() => _WriteUsPageState();
}

class _WriteUsPageState extends State<WriteUsPage> {
  bool isLoading = false;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        title: Text(
          "Write to us",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Write Your Query",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
             TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: "Message",
                  border: OutlineInputBorder(),
                  label: Text("query")),
            ),
            const Spacer(),
            ElevatedButton(
              child: isLoading ?CircularProgressIndicator(color: Colors.white,): Text("SUBMIT"),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                print(_controller.text);
                Map<String,dynamic> map = {"message":_controller.text};
                String jsonString = json.encode(map);
                Response response = await post(
                  Uri.parse("https://www.decoralley.in/contact/qmobile"),
                  body: jsonString,
                );
                if(response.statusCode == 200){
                  showDialog(context: context, builder: (context){
                    return  AlertDialog(
                      backgroundColor: Theme.of(context).cardColor,
                      title: Text("Query Submitted"),
                      content: Text("We will get back to you within 24 hours."),
                      actions: [TextButton(child: Text("Close",style: TextStyle(color: Theme.of(context).primaryColor),),onPressed: (){
                        Navigator.of(context).pop();
                      },)],
                    );
                  });
                }else{
                  Constants().getToast( "Something went wrong, Please retry");
                }
                print(response.statusCode);
                setState(() {
                  isLoading = false;
                });


              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 50)),
            )
          ],
        ),
      ),
    );
  }
}
