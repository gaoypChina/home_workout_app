import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'package:full_workout/navigation/navigation_service.dart';
import 'package:share/share.dart';

class MainMenuItem {
  String name;
  IconData iconData;
  Color color;
  MainMenuItem(this.name,this.iconData,this.color);
}
class MainMenu extends StatefulWidget {
  int currentIndex;
  MainMenu({this.currentIndex});
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation<Offset> _animation;

  var items = [
    MainMenuItem("Wink Wack",Icons.swipe,Colors.red.shade400),
    MainMenuItem("Explore",EvaIcons.globe,Colors.blue.shade400),
    MainMenuItem("Messages",EvaIcons.messageCircle,Colors.green.shade400),
    MainMenuItem("Super Powers",EvaIcons.flash,Colors.pink.shade400),
    MainMenuItem("Challenges",Icons.star_rate_rounded,Colors.orange.shade400),
    MainMenuItem("Share",Icons.share_rounded,Colors.deepPurple.shade400),
    MainMenuItem("Settings",Icons.settings_rounded,Colors.indigo.shade400),
  ];
  final NavigationService _navigationService = GetIt.instance.get();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration:Duration(milliseconds: 250),reverseDuration: Duration(milliseconds: 250),vsync:this);
    _animation = Tween<Offset>(
      end: Offset.zero,
      begin: const Offset(0.0, 3.0),
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate,
        reverseCurve: Curves.decelerate
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              await _animationController.reverse();
              Navigator.of(context).pop();
            },
            behavior: HitTestBehavior.opaque,
            child: Container(),
          ),
          SlideTransition(
            position: _animation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Dismissible(
                key: GlobalKey(),
                direction: DismissDirection.down,
                onDismissed: (direction){
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade800 : Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Container()
                            ),
                            SizedBox(width: 16,),
                            Expanded(
                              child: Text("akash"?? "",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            ),
                            FlatButton(
                              height: 32,
                              onPressed: (){
                                _navigationService.navigate("/editProfile");
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              child: Text("Edit Profile",style:TextStyle(color:Colors.blue.shade700,fontSize: 12)),
                              padding: EdgeInsets.symmetric(horizontal: 16),

                              color: Colors.blue.shade100,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(),
                      ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          var item = items[index];
                          return InkWell(
                            onTap: () async{
                              if(item.name == "Wink Wack"){
                                setState(() {
                                  widget.currentIndex = 0;
                                });
                                Navigator.pop(context,widget.currentIndex);
                              }else if(item.name == "Explore"){
                                setState(() {
                                  widget.currentIndex = 1;
                                });
                                Navigator.pop(context,widget.currentIndex);
                              }else if(item.name == "Messages"){
                                setState(() {
                                  widget.currentIndex = 2;
                                });
                                Navigator.pop(context,widget.currentIndex);
                              }else if(item.name == "Super Powers"){
                                setState(() {
                                  widget.currentIndex = 3;
                                });
                                Navigator.pop(context,widget.currentIndex);
                              }else if(item.name == "Settings"){
                                _navigationService.navigate("/settings");
                              }else if(item.name == "Challenges"){
                                final result = await _navigationService.navigate("/challenges");
                                _navigationService.goBack();
                              }else if(item.name == "Share"){
                                await Share.share("https://play.google.com/store/apps/details?id=com.winkwack.app");
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
                              child: Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                        color: item.color,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Center(
                                      child: Icon(item.iconData,color:Colors.white,size: 20,),
                                    ),
                                  ),
                                  SizedBox(width:16),
                                  Text(item.name,style: TextStyle(),)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
