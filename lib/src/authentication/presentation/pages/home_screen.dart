import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/main.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_tutorial/src/authentication/presentation/widgets/Loading_colmn.dart';
import 'package:tdd_tutorial/src/authentication/presentation/widgets/add_user_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if(state is CreatedUserState){
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Screen'),
          ),
          body: state is GettingUsersState?const LoadingColumn(message: 'Loading Users',): state is UserLoadedState?ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              title: Text(state.users[index].name),
              subtitle:  Text(state.users[index].createdAt.substring(10)),
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person),
              ),
            );
          }, itemCount: state.users.length,): state is CreatingUserState?const Center(
            child: CircularProgressIndicator(),
          ): const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showDialog(context: context, builder: (context)=>AddUserDialog(nameController: nameController));

            },
            tooltip: 'Add User',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() {
    BlocProvider.of<AuthenticationCubit>(context).getUsers();
  }
}
