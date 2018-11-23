import 'package:flutter/material.dart';
import 'package:ui_standards_flutter/contacts/contact.dart';
import 'package:ui_standards_flutter/contacts/contact_list_item.dart';
import 'contact_list.dart';

class ContactListItemAction extends Row implements CustomListItem{

  ContactListItemAction(Contact contact, VoidCallback onEditPressed):
      super(
        children: <Widget>[
          Expanded(
            child: new ContactListItem(contact),
          ),
          Container(
            child: new FlatButton(onPressed: onEditPressed, child: new Icon(Icons.edit, color: Colors.black54,)),
          )

        ],
      );
}