import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalDetailsScreen extends StatelessWidget {
  static const routeName = '/personal';
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _dob = FocusNode();
  final _gender = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Checking',style: TextStyle(color: Colors.white),),
        actions: [
          DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              }),
        ],
      ),
      backgroundColor: Color.fromARGB(218, 11, 9, 9),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SizedBox(height: 80),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(top: 8, left: 5),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final textPainter = TextPainter(
                    text: TextSpan(
                      text: 'add personal details',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                    textDirection: TextDirection.ltr,
                  );
                  textPainter.layout();
                  final width = textPainter.size.width;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 3),
                        child: Text(
                          'add personal details',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: width,
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'helps to verify your identity during account recovery',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(_dob);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  labelText: 'Display Name',
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                  suffixIcon: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10, left: 20),
                              width: double.infinity,
                              child: Text(
                                'visible to everyone',
                                style: TextStyle(color: Colors.white70),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
                                focusNode: _dob,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(_gender);
                                },
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  labelText: 'Date of birth',
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10, left: 20),
                              width: double.infinity,
                              child: Text(
                                'dd-mm-yyyy',
                                style: TextStyle(color: Colors.white70),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
                                focusNode: _gender,
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  labelText: 'Gender',
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 280,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromRGBO(177, 159, 184, 1).withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  'AGREE & CONTINUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
