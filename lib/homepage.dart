import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FrmEmpleado extends StatefulWidget {
  const FrmEmpleado({super.key});

  @override
  State<FrmEmpleado> createState() => _FrmEmpleadoState();
}

class _FrmEmpleadoState extends State<FrmEmpleado> {
  final _formKey = GlobalKey<FormState>();

  final _txtIdentificacion = TextEditingController();
  final _txtNombre = TextEditingController();
  final _txtCelular = TextEditingController();
  final _txtEmail = TextEditingController();

  final _soloLetras = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$');

  final _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  String? _generoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REGISTRO EMPLEADOS"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _txtIdentificacion,
                  decoration: const InputDecoration(
                    labelText: 'Identificación max 10 dígitos',
                    hintText: 'Solo números',
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "La identificación es obligatoria";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _txtNombre,
                  decoration: const InputDecoration(
                    labelText: "Nombre completo",
                    hintText: "Nombre(s) y apellido(s)",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(_soloLetras),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El nombre es obligatorio";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  initialValue: _generoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Género',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.wc),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Masculino',
                      child: Text('Masculino'),
                    ),
                    DropdownMenuItem(
                      value: 'Femenino',
                      child: Text('Femenino'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _generoSeleccionado = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Selecciona un género";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _txtCelular,
                  decoration: const InputDecoration(
                    labelText: "Celular",
                    hintText: "Solo 10 dígitos",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El número de celular es obligatorio";
                    }
                    if (value.length < 10) {
                      return "El número debe tener 10 dígitos";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _txtEmail,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "alguien@gmail.com",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El correo es obligatorio";
                    }
                    if (!_emailRegex.hasMatch(value)) {
                      return "Formato de correo no válido";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Guardar"),
                  onPressed: () {
                    final esValido = _formKey.currentState!.validate();

                    if (!esValido) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Empleado registrado correctamente"),
                      ),
                    );

                    _txtIdentificacion.clear();
                    _txtNombre.clear();
                    _txtCelular.clear();
                    _txtEmail.clear();

                    setState(() {
                      _generoSeleccionado = null;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
