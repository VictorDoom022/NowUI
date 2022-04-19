import 'package:flutter/material.dart';
import 'Theme.dart';
import 'drawer-tile.dart';

class NowDrawer extends StatelessWidget {

  final Color? backgroundColor;
  final String? currentPage;
  final Widget? drawerHeader;
  final List<DrawerTile> tiles;
  final List<NowDrawerSection>? drawerSection;

  NowDrawer({this.backgroundColor = NowUIColors.primary, this.currentPage, this.drawerHeader, required this.tiles, this.drawerSection});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: backgroundColor,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    drawerHeader != null ? drawerHeader! : Container(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: IconButton(
                          icon: Icon(Icons.menu,
                              color: NowUIColors.white.withOpacity(0.82),
                              size: 24.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: const EdgeInsets.only(top: 36, left: 8, right: 16),
            children: [
              for(var item in tiles)
                item
            ],
          ),
        ),
        if(drawerSection != null)
        for(var item in drawerSection!)
          item
      ]),
    ));
  }
}

class NowDrawerSection extends StatelessWidget {

  final String sectionTitle;
  final List<DrawerTile> sectionDrawerTile;

  const NowDrawerSection({ Key? key, required this.sectionTitle, required this.sectionDrawerTile }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                  height: 4,
                  thickness: 0,
                  color: NowUIColors.white.withOpacity(0.8)),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                child: Text(sectionTitle,
                    style: TextStyle(
                      color: NowUIColors.white.withOpacity(0.8),
                      fontSize: 13,
                    )),
              ),
              for(var item in sectionDrawerTile)
                item
            ],
          )),
        );
  }
}
