









import 'package:alarm_app/model_class/mode_class.dart';
import 'package:alarm_app/pages/user_dashboard.dart';
import 'package:alarm_app/services/user_services.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _userName = TextEditingController();
  var _fullName = TextEditingController();
  var _email = TextEditingController();
  var _password = TextEditingController();


  bool _validUserName = false;
  bool _validFullName = false;
  bool _validEmail = false;
  bool _validPassword = false;


  var _userServices = UserServices();


  bool _hideMe = true;

  void _toggleIcon(){
    setState(() {
      _hideMe = !_hideMe;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        //title: Text('SignUp Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              key: _formKey,
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                   image: DecorationImage(
                     fit: BoxFit.cover,
                     image: AssetImage('assets/img.png'),
                   ),
                 ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _userName,
                  decoration:  InputDecoration(
                    labelText: 'UserName',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    errorText: _validUserName
                        ? 'UserName field cannot be empty' : null,
                      suffixIcon: Icon(Icons.account_circle,color: Colors.grey,)
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _fullName,
                  decoration:  InputDecoration(
                    labelText: 'FullName',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    errorText: _validFullName
                        ? 'FullName field cannot be empty' : null,
                    suffixIcon: Icon(Icons.account_circle, color: Colors.grey,)
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _email,
                  decoration:  InputDecoration(
                    errorText: _validEmail
                        ? 'Email field cannot be empty' : null,
                    labelText: 'Email Id',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    suffixIcon: Icon(Icons.email, color: Colors.grey,)
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  obscureText: _hideMe,
                  keyboardType: TextInputType.text,
                  controller: _password,
                  decoration:  InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    errorText: _validPassword
                    ? 'Password field cannot be empty' : null,
                    suffixIcon: InkWell(
                      onTap: _toggleIcon,
                      child: _hideMe? Icon(Icons.visibility_off, color:Colors.grey ,) : Icon(Icons.visibility,color: Colors.grey,),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.purple.withAlpha(30),
                  ),
                  margin: EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: () async{
                      setState(() {
                        _userName.text.isEmpty ? _validUserName = true: _validUserName =false;
                        _fullName.text.isEmpty ? _validFullName = true: _validFullName =false;
                        _email.text.isEmpty ? _validEmail = true: _validEmail =false;
                        _password.text.isEmpty ? _validPassword = true: _validPassword =false;
                      });

                      if (_validUserName == false &&
                          _validFullName == false &&
                      _validEmail == false &&
                      _validPassword == false
                      ) {
                        print('Thumbs up');
                        var _userData = UserData();
                        _userData.userName = _userName.text;
                        _userData.fullName = _fullName.text;
                        _userData.email = _email.text;
                        _userData.password = _password.text;
                        var result = await _userServices.SaveUser(_userData);
                        print(result);

                        String username = _userName.text;

                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard(userNameOk:username,)),
                        );
                      }
                      else {
                        return null;
                      }

                    },
                    child: Text('Sign Up', style: TextStyle(color: Colors.black, fontSize: 17),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
