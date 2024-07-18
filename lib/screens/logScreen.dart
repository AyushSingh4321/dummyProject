import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahil/screens/personal_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:math';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});
  static const routeName = '/log';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(21, 0, 31, 1),
                  Color.fromRGBO(66, 1, 51, 1),
                  Color.fromRGBO(32, 1, 47, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.4, 0.75, 0.9],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                  ),
                  Container(
                    width: double.infinity,
                    // margin: EdgeInsets.only(bottom: 20.0),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Center(
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      bottom: 25.0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Text(
                        'welcome back we missed you',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: Auth(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  var _hide;
  @override
  void initState() {
    _hide = true;
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    // Use the values saved in _userEmail, _userName, and _userPassword
    try {
      setState(() {
        _isLoading = true;
      });
      UserCredential userCredential;
      if (_isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: _userEmail.trim(), password: _userPassword.trim());
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: _userEmail.trim(), password: _userPassword.trim());
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': _userName,
        'email': _userEmail,
      });
       setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred please check your credentials!';
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.purple[300],
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            if(!_isLogin)
            Container(
              margin: EdgeInsets.only(
                left: 12,
              ),
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Text(
                'Username',
                style: TextStyle(color: Colors.white70, fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            if(!_isLogin)
            Container(
              margin: EdgeInsets.only(left: 13, right: 15, bottom: 5),
              child: TextFormField(
                key: ValueKey('Username'),
                style: TextStyle(color: Colors.white70, fontSize: 20),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.white70,
                  ),
                  labelText: 'Username',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white54,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                // keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) {
                    return 'Please enter at least 4 characters';
                  }
                },
                onSaved: (value) {
                  _userName = value!;
                },
              ),
            ),
            
              Container(
                margin: EdgeInsets.only(
                  left: 12,
                ),
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Text(
                  'E-mail',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
            
              Container(
                margin: EdgeInsets.only(left: 13, right: 15, bottom: 5),
                child: TextFormField(
                  key: ValueKey('email'),
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.white70,
                    ),
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  // keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || value.contains('@') == false) {
                      return 'Please enter a valid e-mail';
                    }
                  },
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
              ),
            Container(
              margin: EdgeInsets.only(
                left: 12,
              ),
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Text(
                'Password',
                style: TextStyle(color: Colors.white70, fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 13, right: 15),
              child: TextFormField(
                key: ValueKey('password'),
                style: TextStyle(color: Colors.white70, fontSize: 20),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.white70,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _hide = !_hide;
                      });
                    },
                    icon: _hide
                        ? Icon(
                            Icons.visibility,
                            color: Colors.white70,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Colors.white70,
                          ),
                  ),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white54,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                obscureText: _hide ? true : false,
                // controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (value) {
                  _userPassword = value!;
                },
              ),
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(right: 15),
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushNamed(PersonalDetailsScreen.routeName);
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.white54),
                    ))),
            SizedBox(
              height: _isLogin ? 30 : 20,
            ),
            if(_isLoading)
            CircularProgressIndicator(),
            if(!_isLoading)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                    Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                ),
              ),
              width: double.infinity,
              margin: EdgeInsets.only(left: 13, right: 15, bottom: 5),
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _isLogin ? 'Sign In' : 'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if(!_isLoading)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                    Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                ),
              ),
              width: double.infinity,
              margin: EdgeInsets.only(left: 13, right: 15, bottom: 13),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin ? 'Sign Up' : 'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
