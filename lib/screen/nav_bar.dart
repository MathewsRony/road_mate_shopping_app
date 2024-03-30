import 'dart:io';

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int? pageIndex;
  final Function(int)? onTap;

  const NavBar({
    super.key,
     this.pageIndex,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomAppBar(
        elevation: 10.0,
        child: Container(
          height: 60,
          color: Colors.white,
          child: Row(
            children: [
              navItem(
                Icons.home_outlined,
                "Home",
                pageIndex == 0,
                onTap: () => onTap!(0),
              ),
              navItem(
                Icons.message_outlined,
                "Services",
                pageIndex == 1,
                onTap: () => onTap!(1),
              ),
              const SizedBox(width: 80),
              navItem(
                Icons.notifications_none_outlined,
                "Market",
                pageIndex == 2,
                onTap: () => onTap!(2),
              ),
              navItem(
                Icons.person_outline,
                "My Shop",
                pageIndex == 3,
                onTap: () => onTap!(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String title, bool selected,
      {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
