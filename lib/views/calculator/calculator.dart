import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lmon/customs/form_textfield_build.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  double _result = 0.0;

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      
      final double amount = double.tryParse(_formKey.currentState?.value['Monto'] ?? '0') ?? 0.0;
      final int quotas = int.tryParse(_formKey.currentState?.value['Cuotas'] ?? '0') ?? 0;
      
      const double interestRate = 0.10;
      final double totalAmount = amount * (1 + interestRate);
      _result = totalAmount / quotas;

      setState(() {});
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    setState(() {
      _result = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: SingleChildScrollView(
          child: 
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  const Center(
                    child: Text("Calculadora de Cuotas", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                  ),
                  const SizedBox(height: 10,),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
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
                                errorText: 'Monto mínimo 3000'
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
                            hintText: 'Ingrese la cantidad de cuotas', 
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Cantidad de cuotas requerida'
                              ),
                              FormBuilderValidators.min(
                                1,
                                errorText: 'Cantidad mínima de cuotas es 1'
                              )
                            ]), 
                            icon: Icons.numbers_outlined, 
                            keytype: TextInputType.number
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _calculate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size(200, 50),
                          ),
                          child: const Text(
                            "Calcular Cuotas",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _reset,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            minimumSize: const Size(200, 50),
                          ),
                          child: const Text(
                            "Resetear",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_result > 0)
                          Text(
                            'Pago mensual: \$${_result.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),
      )
    );
  }
}
