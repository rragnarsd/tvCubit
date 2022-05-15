import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_cubit/models/tv.dart';
import 'package:tv_cubit/data/tv_repository.dart';

part 'tv_state.dart';

class TvCubit extends Cubit<TvState> {
  TvCubit({required this.tvRepository}) : super(const TvState());

  final TvRepository tvRepository;
  List<TvModel> tv = [];

  Future<void> getTvShows() async {
    emit(state.copyWith(status: TvStatus.loading));

    try {
      final tvShows = await tvRepository.getMovies();
      tv.addAll(tvShows);
      emit(state.copyWith(status: TvStatus.success, tvList: tvShows));
    } on Exception catch (exception) {
      emit(state.copyWith(status: TvStatus.failure, exception: exception));
    }
  }
}

