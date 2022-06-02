import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // to hide debug banner
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

// Local State to display items in listview
  late List<String> _demoData;

  @override
  void initState() {
    // initializing states
    _demoData = ['Line 1', 'Line 2', 'Line 3', 'Line 4'];
    _scaffoldKey = GlobalKey();
    super.initState();
  }

// This method will run when widget is unmounting
  @override
  void dispose() {
    // disposing states
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Pull to Refresh'),
        ),
        // Widget to show RefreshIndicator
        body: RefreshIndicator(
          child: ListView.builder(
            itemBuilder: (ctx, idx) {
              // List Item
              return Card(
                child: ListTile(
                  title: Text(_demoData[idx]),
                ),
              );
            },

            // Length of the list
            itemCount: _demoData.length,

            // To make listView scrollable
            // even if there is only a single item.
            physics: const AlwaysScrollableScrollPhysics(),
          ),
          // Function that will be called when
          // user pulls the ListView downward
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
              () {
                setState(() {
                  _demoData.addAll(['Line ${_demoData.length + 1}']);
                });

                // showing snackbar
                // _scaffoldKey.currentState!.showSnackBar(
                //   const SnackBar(
                //     content: Text('Page Refreshed'),
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}
