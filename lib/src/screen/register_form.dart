import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:login_visor/comm/gen_text_form_field.dart';
import 'package:login_visor/comm/gen_toast_text_field.dart';
import 'package:login_visor/src/screen/login_page.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _conName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPhone = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future register() async {
    String unombre = _conName.text;
    String uemail = _conEmail.text;
    String uphone = _conPhone.text;
    String upassword = _conPassword.text;
    String ucpassword = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (upassword != ucpassword) {
        alertDialog(context, "Las contraseñas no coinciden");
      } else {
        _formKey.currentState?.save();
        var url = Uri.parse(
            "https://d909-189-234-128-42.ngrok-free.app/visorusers/registro.php");
        var response = await http.post(url, body: {
          "nombre": unombre,
          "correo": uemail,
          "celular": uphone,
          "contrasenia": upassword,
        });

        if (response.body.isNotEmpty) {
          var data = json.decode(response.body);

          if (data['error'] == 'Error') {
            alertDialog(context, "El usuario ya existe.");
          } else {
            alertDialog(context, "¡Usuario creado!");
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const LoginPage()));
          }
        } else {
          alertDialog(context, "No se pudo realizar el registro");
        }
      }
    } else {
      alertDialog(context, "Hay errores en sus datos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Registra un usuario'),
        backgroundColor: Colors.amber[700],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Transform.translate(
            offset: const Offset(0, -250),
            child: Center(
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GetTextFormfield(
                        controller: _conName,
                        hintName: 'Nombre',
                        icon: Icons.person,
                        inputType: TextInputType.name,
                      ),
                      GetTextFormfield(
                        controller: _conEmail,
                        hintName: 'E-mail',
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                      ),
                      GetTextFormfield(
                        controller: _conPhone,
                        hintName: 'Teléfono',
                        icon: Icons.phone,
                        inputType: TextInputType.phone,
                      ),
                      GetTextFormfield(
                        controller: _conPassword,
                        hintName: 'Contraseña',
                        icon: Icons.lock,
                        isObscureText: true,
                      ),
                      GetTextFormfield(
                        controller: _conCPassword,
                        hintName: 'Confirma tu contraseña',
                        icon: Icons.lock,
                        isObscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.cyan,
                            padding: const EdgeInsets.all(20)),
                        onPressed: () {
                          register();
                        },
                        child: const Text(
                          'Crear Usuario',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('¿Ya estás regitrado?'),
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.amber[700]),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginPage()),
                                    (Route<dynamic> route) => false);
                              },
                              child: const Text('Inicia Sesión')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
