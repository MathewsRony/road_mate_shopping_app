import 'package:flutter/material.dart';
import 'package:road_mate_shopping_app/model/brand_list_model.dart';

class FilterModalContent extends StatefulWidget {
  FilterModalContent(this.brandListData, this.brandFilterLoad, {super.key});

  final Future<void> Function(int selectedBrandId, BuildContext context)
      brandFilterLoad;
  final BrandListData? brandListData;

  @override
  _FilterModalContentState createState() => _FilterModalContentState();
}

class _FilterModalContentState extends State<FilterModalContent> {
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                  ),
                  Text(
                    "Choose your brands",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.cancel_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return FilterListItem(
                      brandData: widget.brandListData?.brandlist?[index],
                      selectedId: selectedId,
                      onChanged: (value) {
                        setState(() {
                          if (selectedId !=
                              widget.brandListData?.brandlist?[index].id)
                            selectedId =
                                widget.brandListData?.brandlist?[index].id;
                          else {
                            selectedId = null;
                          }
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemCount: widget.brandListData?.brandlist?.length ?? 0,
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            if (selectedId != null) {
              widget.brandFilterLoad(selectedId!, context);
            }
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.red,
            ),
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            child: Text(
              "Apply filters",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class FilterListItem extends StatelessWidget {
  final BrandList? brandData;
  final int? selectedId;
  final void Function(bool?)? onChanged;

  const FilterListItem({
    Key? key,
    required this.brandData,
    required this.onChanged,
    this.selectedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: selectedId == brandData?.id ?? false,
        onChanged: onChanged,
        activeColor: selectedId != null ? Colors.red : Colors.grey,
        fillColor: MaterialStateProperty.resolveWith((states) {
          return Colors.red;
        }),
      ),
      title: Text(brandData?.brandName ?? ""),
    );
  }
}
