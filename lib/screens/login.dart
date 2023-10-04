import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_word_search/providers/providers.dart';
import 'package:flutter_word_search/repository/firebase_repo.dart';
import 'package:flutter_word_search/screens/homepage.dart';
import 'package:flutter_word_search/screens/widget/sizes.dart';
import 'package:flutter_word_search/screens/widget/text_form_field.dart';
import 'package:flutter_word_search/screens/widget/toast.dart';
import 'package:flutter_word_search/services/local_storage.dart';
import 'package:flutter_word_search/utils/helpers/validators.dart';

class LoginScreen extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final WordRepository _wordRepository = WordRepository();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoginLoading = ref.watch(isLoading);
    signIn() async {
      if (_formKey.currentState!.validate()) {
        ref.read(isLoading.notifier).state = true;
        var storage = await LocalStorageService.getInstance();

        try {
          final email = emailController.text;
          final password = passwordController.text;

          final userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          final user = userCredential.user;
          storage.saveDataToDisk("token", user!.uid);
          ref.read(token.notifier).state = user.uid;

          if (context.mounted) {
            ref.read(isLoading.notifier).state = false;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        } catch (e) {
          ref.read(isLoading.notifier).state = false;
          log(e.toString());
          ToastResp.toastMsgError(resp: "Invalid login details");
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: isLoginLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    heightSpace(100),
                    AppTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: emailController,
                      validator: emailValidation,
                      hintText: "Email Address",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    heightSpace(20),
                    AppTextFormField(
                      prefixIcon: const Icon(Icons.lock),
                      validator: passwordValidation,
                      textEditingController: passwordController,
                      hintText: "Password",
                      isPassword: true,
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            const Size(200, 60), // Adjust the size as needed
                      ),
                      onPressed: signIn,
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
