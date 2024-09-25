import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  String email = '';
  bool visibility = true;
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(32),
        children: <Widget>[
          buildEmail(),
          const SizedBox(
            height: 24,
          ),
          buildPassword(),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              //validar form
              //acessar o form e executar a validação
              bool valid = formKey.currentState!.validate();
              if(valid) {
                print('Email: ${emailController.text}');
                print('Password: ${passwordController.text}');
              }
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }

  Widget buildEmail() => TextFormField(
    validator: (value) {
      if(value == null || value.isEmpty || !value.contains('@')) {
        return 'Informe o email';
      }
      return null;
    },
    controller: emailController,
    onChanged: (value) {
      email = value;
    },
        decoration: InputDecoration(
          hintText: 'name@example.com',
          labelText: 'E-mail',
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.email),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              emailController.clear();
            },
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      );

  Widget buildPassword() =>  TextFormField(
        validator: (value) {
        if(value == null || value.isEmpty || value.length <= 6) {
            return 'Informe a senha';
        }
          return null;
        },
        controller: passwordController,
        obscureText: visibility,
        decoration: InputDecoration(
          hintText: 'Your Password...',
          labelText: 'Password',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility), 
            onPressed: () { 
              setState(() {
                visibility = !visibility;
              });
             },
            
          ),
        ),
      );
}