import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Вход выполнен: ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                user.email!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                child: const Text('Выйти'),
                onPressed: () => FirebaseAuth.instance.signOut(),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/collections/employees');
                },
                child: const Text('next page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
