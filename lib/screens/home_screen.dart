// ignore: unnecessary_import
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:chat_app/helper.dart';
import 'package:chat_app/pages/calls_page.dart';
import 'package:chat_app/pages/contacts_page.dart';
import 'package:chat_app/pages/messages_page.dart';
import 'package:chat_app/pages/notifications_page.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/action_button.dart';

// ignore: camel_case_types
class Home_Screen extends StatelessWidget {
  Home_Screen({Key? key}) : super(key: key);

  //to maintain value change like one page to other page
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier("Messages");

  //button navigation bar
  //all pages list
  final pages = const [
    Message_Page(),
    Calls_Page(),
    Notifications_Page(),
    Contacts_Page()
  ];
  //for setting button navigation item selected in appbar we need
  //a list of item like below
  final pagesTitle = const ["Messages", "Calls", "Notifications", "Contacts"];

  //for set navigation item lin body and appbar
  void _onNavigationItemSelected(index) {
    title.value = pagesTitle[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    pageIndex.addListener(() {
      print(pageIndex.value);
    });
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(
              value,
              style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold,
                //color: AppColors.textFaded
              ),
            );
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {
              print("to do search");
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(url: Helpers.randomPictureUrl()),
          )
        ],
      ),
      //change state
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

//we need to make this as statefull becouse after selecting
//one button we need to change icon colors
class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);
  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleitemselected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
            //for row mainaxis alienment is horizontal
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItems(
                index: 0,
                lable: "Messages",
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                isSelected: (selectedIndex == 0),
                onTaped: handleitemselected,
              ),
              _NavigationBarItems(
                index: 1,
                lable: "Calls",
                icon: CupertinoIcons.phone_fill,
                isSelected: (selectedIndex == 1),
                onTaped: handleitemselected,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 8.0),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: CupertinoIcons.add,
                  onPressed: () {
                    print("add button");
                  },
                ),
              ),
              _NavigationBarItems(
                index: 2,
                lable: "Notifications",
                icon: CupertinoIcons.bell_solid,
                isSelected: (selectedIndex == 2),
                onTaped: handleitemselected,
              ),
              _NavigationBarItems(
                index: 3,
                lable: "Contacts",
                icon: CupertinoIcons.person_2_fill,
                isSelected: (selectedIndex == 3),
                onTaped: handleitemselected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//navigation bar item
class _NavigationBarItems extends StatelessWidget {
  const _NavigationBarItems(
      {Key? key,
      required this.onTaped,
      required this.lable,
      required this.icon,
      required this.index,
      this.isSelected = false})
      : super(key: key);

  final ValueChanged<int> onTaped;
  final int index;
  final String lable;
  final bool isSelected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //thats mean evan if u touch near button it will work
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTaped(index);
        // print(index);
      },
      child: SizedBox(
        width: 70,
        height: 65,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 20, color: isSelected ? AppColors.secondary : null),
            SizedBox(height: 8),
            Text(
              lable,
              style: isSelected
                  ? TextStyle(
                      fontSize: 11,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold)
                  : TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
