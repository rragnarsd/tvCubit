import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_cubit/data/repositories/tv_repository.dart';

import '../data/models/tv.dart';

part 'tv_state.dart';

class TvCubit extends Cubit<TvState> {
  TvCubit({required this.tvRepository}) : super(const TvState());

  final TvRepository tvRepository;
  List<TvModel> tv = [];
  String query = '';

  Future<void> getTvShows() async {
    emit(state.copyWith(status: TvStatus.loading));

    try {
      final tvShows = await tvRepository.getTvShows();
      tv.addAll(tvShows);
      emit(state.copyWith(status: TvStatus.success, tvList: tvShows));
    } on Exception catch (exception) {
      emit(state.copyWith(status: TvStatus.failure, exception: exception));
    }
  }

  Future<void> getTvInfo() async {
    emit(state.copyWith(status: TvStatus.loading));

    try {
      await tvRepository.getMoreInfo(query);
      emit(state.copyWith(status: TvStatus.success));
    } on Exception catch (exception) {
      emit(state.copyWith(status: TvStatus.failure, exception: exception));
    }
  }

  final List<dynamic> items = [];
  Future<void> searchTvShow() async {
    emit(state.copyWith(status: TvStatus.loading));

    try {
      await tvRepository.searchTvShows(query);
      emit(state.copyWith(status: TvStatus.success));
    } on Exception catch (exception) {
      emit(state.copyWith(status: TvStatus.failure, exception: exception));
    }
  }
}
