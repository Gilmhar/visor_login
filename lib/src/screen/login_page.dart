import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:login_visor/comm/gen_text_form_field.dart';
import 'package:login_visor/comm/gen_toast_text_field.dart';
import 'package:login_visor/src/screen/home_form.dart';
import 'package:login_visor/src/screen/register_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _conName = TextEditingController();
  final _conPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future login() async {
    String unombre = _conName.text;
    String upassword = _conPassword.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
        var url = Uri.parse(
            "https://d909-189-234-128-42.ngrok-free.app/visorusers/login.php");
        var response = await http.post(url, body: {
          "nombre": unombre,
          "contrasenia": upassword,
        });
        if (response.body.isNotEmpty) {
          var data = json.decode(response.body);
          print(data);
          if (data['error'] == "Error") {
            alertDialog(context, "Usuario o contraseña erronenas.");
          } else {
            alertDialog(context, "¡Bienvenido!");
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomeForm()));
          }
        } else {
          alertDialog(context, "No se pudo iniciar sesión.");
        }
    } else {
      alertDialog(context, "Hay errores en sus datos.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.cyan.shade300,
                  Colors.cyan.shade800,
                ]),
              ),
              height: 280,
              child: Image.asset("assets/image/beach_wave.png"),
            ),
            Transform.translate(
              offset: const Offset(0, -5),
              child: SingleChildScrollView(
                child: Center(
                  child: Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, top: 260),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GetTextFormfield(
                              controller: _conName,
                              hintName: 'Usuario',
                              icon: Icons.person),
                          const SizedBox(height: 5.0),
                          GetTextFormfield(
                            controller: _conPassword,
                            hintName: 'Contraseña',
                            icon: Icons.person,
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
                              login();
                            },
                            child: const Text(
                              'Iniciar Sesión',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('¿No estás regitrado?'),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.amber[700]),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const RegisterForm(),
                                        ));
                                  },
                                  child: const Text('Registrate')),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
  

  // Future login() async {
  //   TextEditingController unombre = _conUserId;
  //   TextEditingController upassword = _conPassword;
  //   var url = Uri.parse("http://1cfd-189-234-128-42.ngrok-free.app/usuariosvisor/login.php");
  //   final response = await http.get(url);
  //   var data = json.decode(response.body);
  //   print(data);
  //   if (data['nombre'].isNull) {
  //     alertDialog(context, "Ingresa un nombre de usuario");
  //   } else if (data['contrasenia'].isNull) {
  //     alertDialog(context, "Ingresa una contrseña.");
  //   } else if (data == 'Success') {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (_) => const HomeForm()),
  //         (Route<dynamic> route) => false);
  //     alertDialog(context, 'Usuario creado');
  //   } else {
  //     alertDialog(context, "¡Usuario no encontrado!");
  //   }
  // }

  
