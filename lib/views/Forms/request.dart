
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../customs/form_textfield_build.dart';

class FormRequest extends StatefulWidget {
  const FormRequest({super.key});

  @override
  State<FormRequest> createState() => _FormRequestState();
}

class _FormRequestState extends State<FormRequest> {
  
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prestamo", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 35, // Cambia el color del botón "Back"
        ),
      ),
      body: FormBuilder(
        key: _formkey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: FormBuilderCustom(
                  name: 'Correo', 
                  obscureText: false, 
                  hintText: 'Ingrese su correo', 
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Monto requerido'
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
                height: 10,
              ),
              ElevatedButton(
                onPressed: (){

                  _formkey.currentState?.save();

                  if (_formkey.currentState?.validate() == true) {
                    final v = _formkey.currentState?.value;
                    print(v?['Correo']);
                    print(v?['Clave']);
                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue
                ),
                child: const Text("Solicitar", style: TextStyle(color: Colors.white),),
              )
              
            ],
          ),
        ),
      ) 
 
    );
  }
}