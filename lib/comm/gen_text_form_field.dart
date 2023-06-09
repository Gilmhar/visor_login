import 'package:flutter/material.dart';
import 'package:login_visor/comm/gen_toast_text_field.dart';

// ignore: must_be_immutable
class GetTextFormfield extends StatelessWidget {
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;

  GetTextFormfield(
      {super.key,
      required this.controller,
      required this.hintName,
      required this.icon,
      this.isObscureText = false,
      this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa $hintName.';
          } else if (hintName == "E-mail" && !validateEmail(value)) {
            return 'Por favor ingresa un email válido.';
          } else if (hintName == "Contraseña" && !validateContrasenia(value)){
            return '''Contraseña no valida. Debe contener:
              8 caracteres
              Al menos 1 mayúscula
              Al menos 1 minúscula
              Al menos un número
              Un caracter especial 
            ''';
          }
          return null;
        },
        // onSaved: (newValue) => controller.text = newValue!,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.cyan),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: Colors.amber)),
          prefixIcon: Icon(icon),
          hintText: hintName,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
