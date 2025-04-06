import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/main.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameController;
 const AddUserDialog({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Add User',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().createUser(name: nameController.text.trim(), avatar: 'avatar', createdAt: DateTime.now().toString());
                  Navigator.of(context).pop();
                },
                child: const Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
