import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'Theme.dart';

// import 'package:now_ui_flutter/screens/trending.dart';
// import 'package:now_ui_flutter/screens/fashion.dart';
// import 'package:now_ui_flutter/screens/notifications.dart';
// import 'package:now_ui_flutter/screens/search.dart';
// import 'package:now_ui_flutter/screens/cart.dart';

import 'input.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool reverseTextcolor;
  final List<RightOptionWidget>? rightOptionWidgets;
  final List<String>? tags;
  final Function? getCurrentPage;
  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;
  final VoidCallback? onSearchIconTap;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  Navbar(
      {this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags,
      this.transparent = false,
      this.rightOptionWidgets,
      this.reverseTextcolor = false,
      this.getCurrentPage,
      this.searchController,
      this.searchOnChanged,
      this.onSearchIconTap,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = NowUIColors.white,
      this.searchBar = false});

  final double _prefferedHeight = 180.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  String? activeTag;

  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    if (widget.tags != null) {
      if(widget.tags!.isNotEmpty){
        activeTag = widget.tags![0];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags!.isEmpty ? false : true);

    return Container(
        height: widget.searchBar
            ? (!categories
                ? (tagsExist ? 211.0 : 178.0)
                : (tagsExist ? 262.0 : 210.0))
            : (!categories
                ? (tagsExist ? 162.0 : 102.0)
                : (tagsExist ? 200.0 : 150.0)),
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? NowUIColors.muted
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: const Offset(0, 5))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                                !widget.backButton
                                    ? Icons.menu
                                    : Icons.arrow_back_ios,
                                color: !widget.transparent
                                    ? (widget.bgColor == NowUIColors.white
                                        ? NowUIColors.text
                                        : NowUIColors.white)
                                    : (widget.reverseTextcolor
                                        ? NowUIColors.text
                                        : NowUIColors.white),
                                size: 24.0),
                            onPressed: () {
                              if (!widget.backButton) {
                                Scaffold.of(context).openDrawer();
                              } else {
                                Navigator.pop(context);
                              }
                            }),
                        Text(widget.title,
                            style: TextStyle(
                                color: !widget.transparent
                                    ? (widget.bgColor == NowUIColors.white
                                        ? NowUIColors.text
                                        : NowUIColors.white)
                                    : (widget.reverseTextcolor
                                        ? NowUIColors.text
                                        : NowUIColors.white),
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                      ],
                    ),
                    widget.rightOptionWidgets != null ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for(var item in widget.rightOptionWidgets!)
                          item
                      ],
                    ) : Container()
                  ],
                ),
                if (widget.searchBar)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 4, left: 15, right: 15),
                    child: Input(
                        placeholder: "What are you looking for?",
                        controller: widget.searchController,
                        onChanged: widget.searchOnChanged,
                        autofocus: widget.searchAutofocus,
                        suffixIcon: const Icon(
                          Icons.zoom_in,
                          color: NowUIColors.time,
                          size: 20,
                        ),
                        onTap: widget.onSearchIconTap,
                      ),
                  ),
                const SizedBox(
                  height: 10.0,
                ),
                if (categories)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Trending()));
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.camera,
                                color: NowUIColors.text, size: 18.0),
                            const SizedBox(width: 8),
                            Text(widget.categoryOne,
                                style: const TextStyle(
                                    color: NowUIColors.text, fontSize: 14.0)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        color: NowUIColors.text,
                        height: 25,
                        width: 1,
                      ),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Fashion()));
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_cart,
                                color: NowUIColors.text, size: 18.0),
                            const SizedBox(width: 8),
                            Text(widget.categoryTwo,
                                style: const TextStyle(
                                    color: NowUIColors.text, fontSize: 14.0)),
                          ],
                        ),
                      )
                    ],
                  ),
                if (tagsExist)
                  Container(
                    height: 40,
                    child: widget.tags != null ? ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.tags!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (activeTag != widget.tags![index]) {
                              setState(() => activeTag = widget.tags![index]);
                              _scrollController.scrollTo(
                                  index:
                                      index == widget.tags!.length - 1 ? 1 : 0,
                                  duration: const Duration(milliseconds: 420),
                                  curve: Curves.easeIn);
                              if (widget.getCurrentPage != null) {
                                widget.getCurrentPage!(activeTag);
                              }
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 46 : 8, right: 8),
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 20, right: 20),
                              // width: 90,
                              decoration: BoxDecoration(
                                  color: activeTag == widget.tags![index]
                                      ? NowUIColors.info
                                      : NowUIColors.tabs,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(54.0))),
                              child: Center(
                                child: Text(
                                  widget.tags![index],
                                    style: TextStyle(
                                        color: activeTag == widget.tags![index]
                                            ? NowUIColors.white
                                            : NowUIColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0)),
                              )),
                        );
                      },
                    ) : Container(),
                  )
              ],
            ),
          ),
        ));
  }
}

class RightOptionWidget extends StatelessWidget {

  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const RightOptionWidget({ Key? key, required this.icon, required this.iconColor, this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
          color: iconColor,
          size: 22.0
      ),
    );
  }
}
