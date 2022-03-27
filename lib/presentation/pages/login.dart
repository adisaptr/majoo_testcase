import 'package:flutter/material.dart';

import '../../data/models/login_model.dart';
import '../../injection.dart';
import '../bloc/movie_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'home.dart';
import 'regis.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextController();
  final _passwordController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Login",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _form(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Login',
                  onPressed: () {
                    if (formKey.currentState!.validate()) login();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Register',
                  isSecondary: true,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            context: context,
            controller: _emailController,
            isEmail: true,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null)
                return pattern.hasMatch(val) ? null : 'email is invalid';
            },
          ),
          CustomTextFormField(
            context: context,
            label: 'Password',
            hint: 'password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
            ),
            validator: (val) {
              if (val != null) {
                if (!RegExp(r"^.{6,}$").hasMatch(val))
                  return 'Password min length is 6 character';
              }
            },
          ),
        ],
      ),
    );
  }

  void login() {
    LoginModel login = LoginModel(
        email: _emailController.value, password: _passwordController.value);
    sl<MovieCubit>()
      ..login(login)
      ..stream.listen((state) {
        if (state is Error) {
          snackBar();
        } else if (state is LoggedIn) {
          snackBar(success: true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Home(),
            ),
          );
        }
      });
  }

  void snackBar({bool success = false}) {
    String message = success
        ? 'Login Berhasil'
        : 'Login Gagal, Periksa kembali inputan anda';
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
