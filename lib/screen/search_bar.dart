import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onSearchTap;
  final void Function()? onClearTap;
  final void Function(String)? onSubmitted;
  final bool autoFocus;
  final bool showCancel;
  final bool readOnly;
  final bool hasBorder;
  final String hintText;

  SearchBarWidget({
    this.onSearchTap,
    this.readOnly = false,
    this.autoFocus = false,
    this.showCancel = false,
    this.hasBorder = true,
    this.controller,
    this.onChanged,
    this.onClearTap,
    this.onSubmitted,
    this.hintText = "Search",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSearchTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
        decoration: BoxDecoration(
          border: hasBorder ? Border.all(color: Colors.grey) : null,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                onTap: onSearchTap,
                onSubmitted: onSubmitted,
                cursorColor: Colors.red,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(color: Colors.grey),
                autofocus: autoFocus,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 15),
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Color(0xFF333333)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            if (controller?.text.isNotEmpty == true)
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: InkWell(
                  onTap: onClearTap,
                  child: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 20,bottom:
                5),
                child: SizedBox(
                  height: 14,
                  width: 14,
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
