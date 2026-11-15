import 'package:flutter/material.dart';

import '../app_scope.dart';

const _forest = Color(0xff19564c);
const _muted = Color(0xff7c8078);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  void _signIn() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    AppScope.of(context).signIn();
    Navigator.of(context).pushReplacementNamed('/app');
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _forest.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Center(
                      child: Text('🥬', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Halo, pencinta rasa!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Kenalan dulu, yuk. Temukan cerita kuliner Nusantara '
                    'dan simpan rasa favoritmu.',
                    style: TextStyle(color: _muted, fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Namamu',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 9),
                  TextFormField(
                    key: const ValueKey('login-name'),
                    initialValue: state.loginName,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'Contoh: Ayu',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    onChanged: state.updateLoginName,
                    onFieldSubmitted: (_) => _signIn(),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Namamu belum diisi.';
                      }
                      if (value.trim().length < 2) {
                        return 'Masukkan setidaknya 2 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton.icon(
                      key: const ValueKey('login-button'),
                      onPressed: _signIn,
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text(
                        'Mulai menjelajah',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Center(
                    child: Text(
                      'Tanpa akun. Langsung jelajah!',
                      style: TextStyle(color: _muted, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
