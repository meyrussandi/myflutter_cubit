import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter_cubit/cubits/auth/auth_cubit.dart';
import 'package:myflutter_cubit/cubits/users/usergit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated)
                return Text(authState.userModel.name);
              return Text('Silahkan login');
            }),
          ),
          BlocProvider(
            create: (_)=>UserGitCubit(UsersGitService()),
            child: BlocBuilder<UserGitCubit, UserGitState>(
                builder: (context, userGitState) {
              final users = context.read<UserGitCubit>();
              if (userGitState is UserGitLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (userGitState is UserGitEmpty) {
                return const Center(
                  child: Text('No Data'),
                );
              }
              if (userGitState is UserGitFailed) {
                return const Center(
                  child: Text('Fetching data failed.'),
                );
              }
              return Expanded(
                child: RefreshIndicator(onRefresh: users.refresh,
                child: ListView(
                  children: userGitState.usersgit.map((e) => Text(e.id.toString())).toList()
                ),),
              );
            }),
          )
        ],
      ),
    );
  }
}
