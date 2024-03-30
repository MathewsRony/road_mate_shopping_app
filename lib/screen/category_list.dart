import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  final String? title;
  final VoidCallback? ontap;
  final bool selected;

  const CategoryListItem(
      {Key? key, this.title, this.ontap, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap!,
      child: Column(
        children: [
          Card(
            elevation: selected ? 5 : 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              width: 100,
              height:60,
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 6),
              alignment: Alignment.center,
              child: Text(title!,
                  style: TextStyle(
                    color: selected ? Colors.red : Colors.black,
                  ),
                  textAlign: TextAlign.center),
            ),
          ),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: selected ? Colors.red : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class CategoryIconListItem extends StatelessWidget {
  final String? image;
  final VoidCallback? ontap;
  final bool selected;

  const CategoryIconListItem(
      {Key? key, this.image, this.ontap, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap!,
      child: Column(
        children: [
          Card(
            elevation: selected ? 5 : 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              width: 100,
              height:60,
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Image.network(
                  "https://roadmate.in/admin/public/market/$image",
                ),
              ),
            ),
          ),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: selected ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
