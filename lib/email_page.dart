import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/email_add_bottom_sheet.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  List<Map> emailList = [];
  List<Map> selectedEmailList = [];

  @override
  void initState() {
    getEmails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: selectedEmailList?.length ?? 0,
            itemBuilder: (context, index) {
              return EmailTile(
                emailList: selectedEmailList,
                index: index,
                omRemoveEmail: (index) {
                  if (mounted) {
                    setState(() {
                      selectedEmailList.remove(selectedEmailList[index]);
                    });
                  }
                },
              );
            }),
      ),
      bottomNavigationBar: InkWell(
        onTap: showTemperatureBottomSheet,
        child: Container(
          height: 60,
          color: Colors.red,
          child: Center(
              child: Text(
            'Add Email'.toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  void getEmails() {
    emailList.add({"email": "srinivas@gmail.com", "isAdded": false});
    emailList.add({"email": "sriniva@gmail.com", "isAdded": false});
    emailList.add({"email": "srinias@gmail.com", "isAdded": false});
    emailList.add({"email": "srvas@gmail.com", "isAdded": false});
    emailList.add({"email": "sras@gmail.com", "isAdded": false});
    emailList.add({"email": "inivas@gmail.com", "isAdded": true});
    selectedEmailList =
        emailList.where((element) => element['isAdded'] == true).toList();
  }

  showTemperatureBottomSheet() {
    return showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(46), topRight: Radius.circular(46)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bContext) {
          return EmailAddBottomSheet(
            emailList: emailList,
            onEmailStatus: (emailLis) {
              if (mounted) {
                setState(() {
                  emailList = emailLis;
                  selectedEmailList = emailList
                      .where((element) => element['isAdded'] == true)
                      .toList();
                });
              }
            },
          );
        });
  }
}

class EmailTile extends StatefulWidget {
  final List<Map> emailList;
  final int index;
  final Function omRemoveEmail;
  final bool showAddButton;

  const EmailTile(
      {Key key,
      this.emailList,
      this.index,
      this.omRemoveEmail,
      this.showAddButton = false})
      : super(key: key);

  @override
  _EmailTileState createState() => _EmailTileState();
}

class _EmailTileState extends State<EmailTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.emailList[widget.index]['email']),
            widget.showAddButton
                ? widget.emailList[widget.index]['isAdded']
                    ? Container(
                        child: Text('Added'),
                      )
                    : InkWell(
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              widget.emailList[widget.index]['isAdded'] = true;
                            });
                          }
                        },
                        child: Container(
                          child: Row(
                            children: [Icon(Icons.add), Text('Add')],
                          ),
                        ),
                      )
                : InkWell(
                    onTap: () => widget.omRemoveEmail(widget.index),
                    child: Icon(Icons.cancel))
          ],
        ),
      ),
    );
  }
}
