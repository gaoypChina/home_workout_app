import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  Metadata? mData;

  var rData;

  @override
  void initState() {
    fun();
    super.initState();
  }

  fun() async {
    final myURL = 'https://amzn.to/3Jwi7JG';

    // Use the `MetadataFetch.extract()` function to fetch data from the url
    var data = await MetadataFetch.extract(myURL);

    print(data?.title); // Flutter - Beautiful native apps in record time

    print(data
        ?.description); // Flutter is Google's UI toolkit for crafting beautiful...

    print(data?.image); // https://flutter.dev/images/flutter-logo-sharing.png

    print(data?.url); // https://flutter.dev/

    var dataAsMap = data?.toMap();
    mData = data;
    rData = dataAsMap;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log("img url");
    log(mData!.image.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Store",
        ),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Text(rData.toString()),
          Image.network("https" + mData!.image!),
        ],
      ),
    );
  }
}
