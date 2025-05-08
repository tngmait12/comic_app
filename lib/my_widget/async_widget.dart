import 'package:flutter/material.dart';

class AsyncWidget extends StatelessWidget {
  const AsyncWidget({super.key, required this.snapshot, this.loading, this.error, required this.builder});

  final AsyncSnapshot snapshot;
  final Widget Function()? loading;
  final Widget Function()? error;
  final Widget Function(BuildContext context, AsyncSnapshot snapshot) builder;

  @override
  Widget build(BuildContext context) {
    if(snapshot.hasError){
      print(snapshot.error);
      return error==null ? Center(child: const Text("Super Loi!!!", style: TextStyle(color: Colors.red),)) : error!();
    }

    if(!snapshot.hasData){
      return loading==null ? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text("Loading...", style: TextStyle(color: Colors.blueGrey, fontSize: 30))
        ],
      ),) : loading!();
    }
    return builder(context, snapshot);
  }
}
