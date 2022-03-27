import 'package:flutter/material.dart';

import '../../data/models/users_model.dart';
import '../../injection.dart';
import '../bloc/movie_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class RegisPage extends StatefulWidget {
  const RegisPage({Key? key}) : super(key: key);

  @override
  State<RegisPage> createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  final _emailController = TextController();
  final _userNameController = TextController();
  final _passwordController = TextController();
  final _confimrPasswordController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;
  bool _isObscurePassword1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Registration',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: SingleChildScrollView(
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
                text: 'Register',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    UsersModel users = UsersModel(
                        email: _emailController.value,
                        username: _userNameController.value,
                        password: _passwordController.value);
                    sl<MovieCubit>()..registration(users);
                    final snackBar = SnackBar(
                      content: const Text('Register Success'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
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
              if (val != null) {
                if (!pattern.hasMatch(val)) {
                  final snackBar = SnackBar(
                    content: const Text('Masukkan email yang valid'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return 'email is invalid';
                }
              }
            },
          ),
          CustomTextFormField(
            context: context,
            controller: _userNameController,
            hint: 'username',
            label: 'Username',
            validator: (val) {
              if (val != null) {
                if (!RegExp(r"^.{3,}$").hasMatch(val))
                  return 'Username min length is 3 character';
              }
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
          CustomTextFormField(
            context: context,
            label: 'Confirm Password',
            hint: 'confirm password',
            controller: _confimrPasswordController,
            isObscureText: _isObscurePassword1,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword1
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword1 = !_isObscurePassword1;
                });
              },
            ),
            validator: (val) {
              if (val != null) {
                if (!RegExp(r"^.{6,}$").hasMatch(val))
                  return 'Password min length is 6 character';
                if (_passwordController.value != val)
                  return 'Password are not the same';
              }
            },
          ),
        ],
      ),
    );
  }
}
