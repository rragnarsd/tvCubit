import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  final int id;
  final String name;
  final String permalink;
  // final DateTime startDate;
  // final DateTime endDate;
  final String country;
  final String network;
  final String image;

  const TvModel({
    required this.id,
    required this.name,
    required this.permalink,
    // required this.startDate,
    // required this.endDate,
    required this.country,
    required this.network,
    required this.image,
  });

  factory TvModel.fromJson(Map<String, dynamic> data) {
    return TvModel(
      id: data.containsKey('id') && data['id'] != null ? data['id'] : 0,
      name:
          data.containsKey('name') && data['name'] != null ? data['name'] : '',
      permalink: data.containsKey('permalink') && data['permalink'] != null
          ? data['permalink']
          : '',
      // startDate: data['startDate'],
      // endDate: data['endDate'],
      country: data.containsKey('country') && data['country'] != null
          ? data['country']
          : '',
      network: data.containsKey('network') && data['network'] != null
          ? data['network']
          : '',
      image: data.containsKey('image') && data['image'] != null
          ? data['image']
          : '',
    );
  }

  @override
  List<Object?> get props => [name, permalink, country, network, image];
}