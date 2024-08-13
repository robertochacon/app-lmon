
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive/hive.dart';
import 'package:lmon/screens/auth/register_screen.dart';
import 'package:lmon/screens/main/home_screen.dart';
import 'package:lmon/services/login.dart';

import '../../customs/form_textfield_build.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _FormRequestState();
}

class _FormRequestState extends State<LoginScreen> {
  
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  final LoginService _loginService = LoginService();

  _hive() async {
    return await Hive.openBox('userBox');
  }

  void saveUserData(String token, String identification, String name, String email) async { 
    _hive();
    var box = Hive.box('userBox'); 
    box.put('token', token);
    box.put('identification', identification);
    box.put('name', name);
    box.put('email', email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FormBuilder(
        key: _formkey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: FormBuilderCustom(
                  name: 'Correo', 
                  obscureText: false, 
                  hintText: 'Ingrese su correo', 
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Correo requerido'
                    )
                  ]), 
                  icon: Icons.mail, 
                  keytype: TextInputType.emailAddress
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: FormBuilderCustom(
                  name: 'Clave', 
                  obscureText: true, 
                  hintText: 'Ingrese su clave', 
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Clave requerida'
                    )
                  ]), 
                  icon: Icons.key, 
                  keytype: TextInputType.text
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () async {

                  if (_formkey.currentState?.validate() ?? false) {
                    _formkey.currentState?.save();
                    final email = _formkey.currentState?.value['Correo'] ?? '';
                    final password = _formkey.currentState?.value['Clave'] ?? '';

                    try {

                      final response = await _loginService.login(email, password);

                      if (response['access_token']['token'] != null) {

                        saveUserData(
                          response['access_token']['token'], 
                          response['access_token']['user']['identification'],
                          response['access_token']['user']['name'],
                          response['access_token']['user']['email']
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response['message'])),
                        );
                      }
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Credenciales incorrectas', style: TextStyle(fontSize: 20),)),
                      );
                    }

                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(200, 50),
                ),
                child: const Text("Iniciar", style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[200],
                  minimumSize: const Size(200, 50),
                ),
                child: const Text("Registro", style: TextStyle(color: Colors.white, fontSize: 20),),
              )
            ],
          ),
        ),
      ) 
 
    );
  }
}