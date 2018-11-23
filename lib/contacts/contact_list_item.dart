import 'package:flutter/material.dart';
import 'package:ui_standards_flutter/contacts/contact.dart';

abstract class CustomListItem{}

class ContactListItem extends ListTile implements CustomListItem{

  ContactListItem(Contact contact) :
        super(
          title : new Text(contact.fullName),
          subtitle: new Text(contact.email, maxLines: 1, overflow: TextOverflow.ellipsis,),
          leading: new CircleAvatar(
              child: new Text(contact.fullName[0]),
            maxRadius: 30.0,
          )
      );

}