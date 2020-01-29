import 'package:flutter/material.dart';

class DebtList extends StatefulWidget {
  DebtList(PageStorageKey keyStorageHome) : super(key: keyStorageHome);

  @override
  _DebtListState createState() => _DebtListState();
}

class _DebtListState extends State<DebtList> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding:EdgeInsets.symmetric(horizontal: 16),
        itemCount: 300,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(  child: Text("1"),radius: 25,),
              title: Text("Ahmet Sina BİRDEVRİM"),
              subtitle: Text("Borç:0"),
              trailing: Icon(Icons.more_vert),
              onTap: () {
                debugPrint("onTap $index");
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
    );
  }
}
