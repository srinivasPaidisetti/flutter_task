import 'package:flutter/material.dart';

import 'email_page.dart';

class EmailAddBottomSheet extends StatefulWidget {
  final Function onEmailStatus;
  final List<Map> emailList;

  const EmailAddBottomSheet({Key key, this.onEmailStatus, this.emailList})
      : super(key: key);

  @override
  _EmailAddBottomSheetState createState() => _EmailAddBottomSheetState();
}

class _EmailAddBottomSheetState extends State<EmailAddBottomSheet> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map> emailList = [];

  @override
  void initState() {
    emailList = widget.emailList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Form(
                key: _formKey,
                child: Expanded(
                  flex: 7,
                  child: TextFormField(
                    validator: validateEmailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                    ),
                    controller: emailController,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      if (mounted) {
                        setState(() {
                          emailList.add({
                            "email": emailController.text.trim(),
                            "isAdded": true
                          });
                        });
                      }
                      emailController.clear();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Add Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: emailList?.length ?? 0,
            itemBuilder: (context, index) {
              return EmailTile(
                showAddButton: true,
                emailList: emailList,
                index: index,
              );
            }),
        SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () {
            widget.onEmailStatus(emailList);
            Navigator.pop(context);
          },
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 60,
              width: 200,
              color: Colors.red,
              child: Center(
                  child: Text(
                'update'.toUpperCase(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
      ],
    );
  }

  String validateEmailAddress(String value) {
    if (value.isEmpty && value.length == 0) {
      return "Email can't be empty";
    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Invalid Email';
    } else {
      return null;
    }
  }
}
