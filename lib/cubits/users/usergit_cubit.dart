import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:myflutter_cubit/cubits/users/usergit_service.dart';
import 'package:myflutter_cubit/models/usergit_model.dart';

part 'usergit_state.dart';

class UserGitCubit extends Cubit<UserGitState> {
  final UsersGitService _service;

  UserGitCubit(this._service) : super(UserGitInitial()){
   _init();
  }

  Future<void> _init()async{
    emit(UserGitLoading());

    final items = await _service.getUsers(0);

    if(items == null){
      emit(UserGitFailed());
    }else if(items.isEmpty){
      emit(UserGitEmpty());
    }else{
      emit(UserGitFetched(items: items, since: items.last.id!));
    }
  }

  Future<void> _fetch()async{
    emit(UserGitLoadMore(since: state.since, items: state.usersgit));

    final items = await _service.getUsers(state.since);

    if(items != null){
      emit(UserGitFetched(since: state.usersgit.last.id!,items: [...state.usersgit, ...items]));
    }
  }

  Future<void> refresh()async{
    final currentState = state;
    final items = await _service.getUsers(0);
    
    if(items is List && items!.isNotEmpty){
      emit(UserGitFetched(since: items.last.id!, items: items));
    }else{
      emit(currentState);
    }
  }
}
