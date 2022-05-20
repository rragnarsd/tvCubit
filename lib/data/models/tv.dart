import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  final int id;
  final String name;
  final String permalink;
  final String country;
  final String network;
  final String imageUrl;

  const TvModel({
    required this.id,
    required this.name,
    required this.permalink,
    required this.country,
    required this.network,
    required this.imageUrl,
  });

  factory TvModel.fromJson(Map<String, dynamic> data) {
    return TvModel(
      id: data.containsKey('id') && data['id'] != null ? data['id'] : 0,
      name:
          data.containsKey('name') && data['name'] != null ? data['name'] : '',
      permalink: data.containsKey('permalink') && data['permalink'] != null
          ? data['permalink']
          : '',

      country: data.containsKey('country') && data['country'] != null
          ? data['country']
          : '',
      network: data.containsKey('network') && data['network'] != null
          ? data['network']
          : '',
      imageUrl: data.containsKey('image_thumbnail_path') &&
              data['image_thumbnail_path'] != null
          ? data['image_thumbnail_path']
          : '',
    );
  }

  @override
  List<Object?> get props => [name, permalink, country, network, imageUrl];
}
