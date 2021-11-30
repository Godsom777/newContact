import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:general_market/constants/konstants.dart';
import 'package:general_market/screens/profileview.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: height * .5,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 80,
                  centerTitle: true,
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildText(context,
                            fontWeight: FontWeight.w800,
                            size: 28,
                            text: 'Contacts')
                      ]),
                  pinned: true,
                  floating: true,
                  snap: true,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Center(
                          child: SizedBox(
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(CupertinoIcons.search),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                      CupertinoIcons.ellipsis_vertical),
                                  onPressed: () {},
                                )
                              ]),
                        ),
                      )),
                      stretchModes: const [
                        StretchMode.fadeTitle,
                        StretchMode.zoomBackground
                        //StretchMode.blurBackground,
                      ],
                      background: Container(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : black,
                        child: Padding(
                          /* used padding to keep the icons at the center

                     /// suggested to be implemented as an upgrade
                     comment it out and use latter after proper back-ending
                       */

                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: width - 150,
                                child: CupertinoSearchTextField(
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : white,
                                  ),
                                  itemSize: 20,
                                  itemColor: white,
                                  suffixIcon: const Icon(CupertinoIcons.clear),
                                  backgroundColor: white.withOpacity(0.4),
                                ),
                              ),
                              Row(
                                children: [
                                  CupertinoButton(
                                      //TODO: Implement advanced search
                                      onPressed: () async {
                                        await FirebaseAuth.instance.signOut();
                                        setState(() {});
                                      },
                                      child: buildText(
                                        context,
                                        text: 'Advanced',
                                        size: 14,
                                        fontWeight: FontWeight.w300,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: black,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(CupertinoIcons.search),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.ellipsis_vertical),
                            onPressed: () {},
                          )
                        ]),
                  ),
                ),

                /* Body of the search results The [SliverList]
            generate the list dynamically later
            TODO make the list dynamic

             */

                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) => SizedBox(
                    height: height * 0.58,
                    width: width,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(_createRoute());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(children: [
                          Container(
                            height: height / 4,
                            width: width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.withOpacity(0.4)
                                      : white.withOpacity(0.0),
                                  offset: const Offset(0, 5),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                )
                              ],
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                  bottom: Radius.circular(0)),
                              image: const DecorationImage(
                                image: AssetImage('images/mechanicgarage.png'),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                width: 0.3,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                              height: height / 4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                /* color of the container
                            /////////////////////////
                             */
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : black,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(0),
                                    bottom: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    /* ////////////////////////////////////

                                Box Shadow goes transparent when the phone is in
                                dark mode and makes it grey when in light mode
                                ///////////////////////////////////////////////
                                 */

                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.grey.withOpacity(0.4)
                                        : white.withOpacity(0.0),
                                    offset: const Offset(0, 2),
                                    blurRadius: 5,
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              /* Add some properties to the body
                      of the card, details of the card owner
                       */
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      const CircleAvatar(
                                          maxRadius: 18,
                                          child: Icon(CupertinoIcons
                                              .person_crop_circle)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      buildText(context,
                                          text: 'Name',
                                          size: 18,
                                          fontWeight: FontWeight.w400)
                                    ]),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    buildText(
                                      context,
                                      text:
                                          'I am a prolific shoe mender and I finish my job on time, really',
                                      size: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      height: height * 0.06,
                                      child: buildText(
                                        context,
                                        text:
                                            'I am a prolific shoe mender and I finish my job on time, really Those who are interested should hook me up for their cool designs and quick repairs on any foot wear',
                                        size: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const Divider(
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    /* contact info for each card
                                 TODO: Implement back End later
                             */
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: width * 0.4,
                                              height: 50,
                                              child: Text(
                                                'ADDRESS: \n36 Elekwerenwa street, '
                                                'by Tetlow street opposite ezinwanne ajacent ajah rumuola Maitama',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? black
                                                      : white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                              )),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CupertinoButton.filled(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: const Icon(
                                                  CupertinoIcons.text_bubble,
                                                  semanticLabel: 'Message',
                                                ),
                                                onPressed: () {},
                                              ),
                                              const Text('Message')
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CupertinoButton.filled(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: const Icon(
                                                  CupertinoIcons.phone,
                                                  semanticLabel: 'Call',
                                                ),
                                                onPressed: () {},
                                              ),
                                              const Text('Call')
                                            ],
                                          ),
                                        ]),

                                    // RatingBar(ratingWidget: ratingWidget, onRatingUpdate: onRatingUpdate)
                                  ],
                                ),
                              )),
                          //////////////////////////Image of the container//////////////
                        ]),
                      ),
                    ),
                  ),
                  childCount: 7,
                ))
              ]),
        ),
      ),
    );
  }

  Row buildRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(CupertinoIcons.heart, color: white, size: 18),
        buildText(
          context,
          text: 'Favorites',
          size: 16,
          fontWeight: FontWeight.w400,
        )
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(CupertinoIcons.text_bubble, color: white, size: 18),
        buildText(
          context,
          text: 'Messages',
          size: 16,
          fontWeight: FontWeight.w400,
        )
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(CupertinoIcons.clock, color: white, size: 18),
        buildText(context,
            text: 'Recent', size: 16, fontWeight: FontWeight.w400)
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(CupertinoIcons.person, color: white, size: 18),
        buildText(context,
            text: 'Profile', size: 16, fontWeight: FontWeight.w400)
      ])
    ]);
  }
}

Route<Object?> _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ProfileView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(50, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubicEmphasized;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 500));
}

ktext(
        {required String inputText,
        required FontWeight thickness,
        required Color textColor,
        required double size}) =>
    Text(inputText,
        style:
            TextStyle(fontWeight: thickness, color: textColor, fontSize: size));
