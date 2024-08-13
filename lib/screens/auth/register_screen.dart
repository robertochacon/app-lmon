
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lmon/screens/auth/login_screen.dart';
import 'package:lmon/screens/main/home_screen.dart';

import '../../customs/form_textfield_build.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _FormRequestState();
}

class _FormRequestState extends State<RegisterScreen> {
  
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();

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
                  name: 'Cédula', 
                  obscureText: false, 
                  hintText: 'Ingrese su cédula', 
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Cédula requerida'
                    )
                  ]), 
                  icon: Icons.perm_identity, 
                  keytype: TextInputType.emailAddress
                ),
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
                onPressed: (){

                  _formkey.currentState?.save();

                  if (_formkey.currentState?.validate() == true) {
                    final v = _formkey.currentState?.value;
                    print(v?['Correo']);
                    print(v?['Clave']);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );

                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(200, 50),
                ),
                child: const Text("Registrar", style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[200],
                  minimumSize: const Size(200, 50),
                ),
                child: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 20),),
              )
            ],
          ),
        ),
      ) 
 
    );
  }
}