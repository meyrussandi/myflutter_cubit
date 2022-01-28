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
    return Scaffold(
      appBar: AppBar(title: const Text('Github User')),
      floatingActionButton: BlocProvider(
        create: (context) => UserGitCubit(UsersGitService()),
        child: FloatingActionButton(
          onPressed: () {
            final users = context.read<UserGitCubit>();
            users.refresh();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Insets.lg),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: MyColors.gradient1),
        child: BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
          if (authState is Authenticated) {
            return BlocBuilder<UserGitCubit, UserGitState>(
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
              return Column(
                children: [
                  Expanded(
                      child: LayoutBuilder(builder: (context, constraint) {
                    return Stack(
                      children: [
                        RefreshIndicator(
                          onRefresh: users.refresh,
                          child: ListView.separated(
                            controller: users.scrollController,
                            itemBuilder: (BuildContext context, int index) =>
                                CardUser(
                                    userGitModel:
                                        userGitState.usersgit[index]),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: userGitState.usersgit.length,
                          ),
                        ),
                        if (userGitState is UserGitLoadMore) ...[
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: Container(
                                  height: 80,
                                  width: constraint.maxWidth,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  )))
                        ]
                      ],
                    );
                  })),
                ],
              );
            });
          }
          return Center(child: Text('Silahkan login'));
        }),
      ),
    );
  }
}
