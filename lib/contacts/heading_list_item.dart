import 'package:flutter/material.dart';
import 'contact_list_item.dart';

class HeadingListItem extends ListTile implements CustomListItem{
  HeadingListItem(String txt):
      super(
        title: new Text(txt)
      );
}