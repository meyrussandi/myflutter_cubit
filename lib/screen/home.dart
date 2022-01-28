import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter_cubit/config/config.dart';
import 'package:myflutter_cubit/cubits/auth/auth_cubit.dart';
import 'package:myflutter_cubit/cubits/users/usergit.dart';
import 'package:myflutter_cubit/utils/page_primary.dart';
import 'package:myflutter_cubit/widgets/card/card_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagePrimary(
      appBar: AppBar(
        title:  const Text('Github User')
      ),
      child: Column(
        children: [
          BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
            if (authState is Authenticated) {
              return BlocProvider(
                create: (_) => UserGitCubit(UsersGitService()),
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
                          child: RefreshIndicator(
                            onRefresh: users.refresh,
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) =>
                                  CardUser(userGitModel: userGitState.usersgit[index]),
                              separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                              itemCount: userGitState.usersgit.length,
                            ),
                          ));
                    }),
              );
            }
            return Center(child: Text('Silahkan login'));
          }),
          verticalSpace(Insets.lg),

        ],
      ),
    );
  }
}
