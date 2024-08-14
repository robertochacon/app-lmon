
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lmon/services/request.dart';
import 'package:lmon/utils/info_user.dart';

import '../../../customs/form_textfield_build.dart';

class FormRequest extends StatefulWidget {
  const FormRequest({super.key});

  @override
  State<FormRequest> createState() => _FormRequestState();
}

class _FormRequestState extends State<FormRequest> {
  
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  final RequestService _requestService = RequestService();

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
      body: 
      Center(
        child: SingleChildScrollView(
          child: 
            FormBuilder(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("¡Préstamo al Instante!", style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                height: 1.2,
                                fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: FormBuilderCustom(
                        name: 'Monto', 
                        obscureText: false, 
                        hintText: 'Ingrese un monto', 
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Monto requerido'
                          ),
                          FormBuilderValidators.min(
                            3000,
                            errorText: 'Monto minimo 3000'
                          )
                        ]), 
                        icon: Icons.monetization_on, 
                        keytype: TextInputType.number
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: FormBuilderCustom(
                        name: 'Cuotas', 
                        obscureText: false, 
                        hintText: 'Cantidad de cuotas', 
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Cuota requerido'
                          ),
                          FormBuilderValidators.min(
                            1,
                            errorText: 'Cuota minima 1'
                          )
                        ]), 
                        icon: Icons.numbers_outlined, 
                        keytype: TextInputType.number
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState?.validate() ?? false) {
                          _formkey.currentState?.save();
        
                          final identification = await InfoUser().getIdentification();
                          final amount = _formkey.currentState?.value['Monto'] ?? 0;
                          final quotas = _formkey.currentState?.value['Cuotas'] ?? 0;
                          final total = _formkey.currentState?.value['Monto'] ?? 0;
        
                          try {
                            final response = await _requestService.register(identification, amount, quotas, total);
        
                            if (response['data'] != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Guardado correctamente!', style: TextStyle(fontSize: 20)),
                                  backgroundColor: Colors.green,
                                ),
                              );
        
                              Navigator.pop(context);
                              await Future.delayed(const Duration(seconds: 2));
        
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response['message'], style: const TextStyle(fontSize: 20))),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Intente más tarde.', style: TextStyle(fontSize: 20))),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text("Solicitar", style: TextStyle(color: Colors.white, fontSize: 20)),
                    )
        
                  ],
                ),
              ),
            ) 
        ),
      ) 
    );
  }
}