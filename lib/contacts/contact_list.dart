import 'package:flutter/material.dart';
import 'package:ui_standards_flutter/contacts/contact.dart';
import 'package:ui_standards_flutter/contacts/contact_list_item.dart';
import 'heading_list_item.dart';
import 'package:ui_standards_flutter/details/detail_page.dart';


class ContactList extends StatefulWidget {

  List<Contact> _contacts;

  ContactList(this._contacts);

  @override
  State createState() => new ContactListState(_contacts);

}

class ContactListState extends State<ContactList>{

  List<Contact> _contacts;

  ContactListState(this._contacts);

  List<CustomListItem> l;
  
  @override
  void initState() {
    int counter = -1;
    int headerCounter = -1;
    l = List.generate(_contacts.length+(_contacts.length/4).ceil(), (index){
      if(index % 5 != 0){
        counter+=1;
        return new ContactListItem(_contacts[counter]);
      }else{
        headerCounter+=1;
        return new HeadingListItem('Heading $headerCounter');
      }
    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    /*return new ListView.separated(itemBuilder: (context, index){

      _startDetailsActivity() async{
        var result = await Navigator.push(context, new MaterialPageRoute(builder: (context)=>new DetailPage(_contacts[index])));
        var resMap = result as Map<String, String>;
        var newContact = Contact(fullName: resMap['name'], email: resMap['email'], id: _contacts[index].id);
        setState(() {
          var idx = _contacts.indexOf(_contacts[index]);
          _contacts[idx] = newContact;
        });
      }

      return Dismissible(
        key: new Key(_contacts[index].id),
        background: DeleteBackground(),
        onDismissed: (direction){
          setState(() {
            _contacts.removeAt(index);
          });
        },
        child: GestureDetector(
            child: new ContactListItem(_contacts[index]),
            onTap: () => _startDetailsActivity()),
      );
    }, separatorBuilder: (context, index){
      if(index % 4 == 0){
        return new Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 8.0),
          child: new ListTile(title: new Text("Heading $index"),),
        );
      }else{
        return Divider();
      }
    }, itemCount: _contacts.length);*/
    return new ListView.builder(
      itemCount: l.length,
      itemBuilder: (context, index){

        if(l[index] is ContactListItem){
          var cName = ((l[index] as ContactListItem).title as Text).data;
          var c = _contacts.firstWhere((cont)=> cont.fullName == cName);

          _startDetailsActivity() async{
            var result = await Navigator.push(context, new MaterialPageRoute(builder: (context)=>new DetailPage(c)));
            var resMap = result as Map<String, String>;
            var newContact = Contact(fullName: resMap['name'], email: resMap['email'], id: c.id);
            setState(() {
              var idx = _contacts.indexOf(c);
              _contacts[idx] = newContact;
              l[index] = new ContactListItem(newContact);
            });
          }

          return Dismissible(
              key: new Key(c.id),
              background: DeleteBackground(),
              onDismissed: (direction){
                setState(() {
                  l.removeAt(index);
                });
              },
              child: GestureDetector(
                child: new ContactListItem(c),
                onTap: () => _startDetailsActivity()),
              );

        }else{
          return l[index] as HeadingListItem;
        }

      },
    );
  }
}

class DeleteBackground extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.red,
      child: new Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          Expanded(
            child: new Text(''),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: Icon(Icons.delete, color: Colors.white),
          )
          


        ],
      ),
    );
  }
}