import 'package:flutter/material.dart';
import 'package:general_market/constants/konstants.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return  Scaffold(
      body: SizedBox(
        height:height,
        width: width,
        child:
        CustomScrollView(
                 slivers: <Widget>[
                   SliverAppBar(
                     expandedHeight: 450,
                     pinned: true,
                     floating: false,
                     snap: false,
                     stretch: true,

                     flexibleSpace: FlexibleSpaceBar(
                       title: buildText( context, fontWeight: FontWeight.w800, size: 18, text: 'Name of Business',),
                       background: const Hero(
                           tag:'tag',child: Image(image: AssetImage('images/mechanicgarage.png',),fit:BoxFit.fitHeight)),
                     ),
                   ),
                   SliverList(
                     delegate: SliverChildBuilderDelegate((context, index) => Container(
                       color: index.isOdd ? Colors.indigo : Colors.tealAccent,
                       height: 100,child: Center(child: Text('$index', textScaleFactor: 10,),),
                     ),
                     childCount: 20,
                     ),
                   )
                 ]

        ),
      ),
    );
  }
}
