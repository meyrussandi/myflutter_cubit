part of 'usergit_cubit.dart';

class UserGitState extends Equatable {
  final int since;
  final List<UserGitModel> usersgit;
  const UserGitState({this.since = 0,this.usersgit = const []});

  UserGitState copyWith({
  int? since,
    List<UserGitModel>? usersgit
}){
    return UserGitState(since: since ?? this.since, usersgit: usersgit??this.usersgit);
  }

  @override
  List<Object?> get props => [since, usersgit];
}

class UserGitInitial extends UserGitState {}

class UserGitFetched extends UserGitState {
  const UserGitFetched({required int since,required List<UserGitModel> items})
      : super(usersgit: items, since: since);
}

class UserGitLoading extends UserGitState {}

class UserGitEmpty extends UserGitState {
}

class UserGitFailed extends UserGitState {}
class UserGitLoadMore extends UserGitFetched {
  const UserGitLoadMore({
    required int since,
    required List<UserGitModel> items
}) : super(items: items, since: since);
}
