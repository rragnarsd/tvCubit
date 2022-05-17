class TvInfo {
  TvShow? tvShow;

  TvInfo({this.tvShow});

  TvInfo.fromJson(Map<String, dynamic> json) {
    tvShow =
        json['tvShow'] != null ? TvShow.fromJson(json['tvShow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tvShow != null) {
      data['tvShow'] = tvShow!.toJson();
    }
    return data;
  }
}

class TvShow {
  int? id;
  String? name;
  String? permalink;
  String? url;
  String? description;
  String? descriptionSource;
  String? startDate;
  String? endDate;
  String? country;
  String? status;
  int? runtime;
  String? network;
  String? youtubeLink;
  String? imagePath;
  String? imageThumbnailPath;
  String? rating;
  String? ratingCount;
  //String? countdown;
  List<String>? genres;
  List<String>? pictures;
  List<Episodes>? episodes;

  TvShow(
      {this.id,
      this.name,
      this.permalink,
      this.url,
      this.description,
      this.descriptionSource,
      this.startDate,
      this.endDate,
      this.country,
      this.status,
      this.runtime,
      this.network,
      this.youtubeLink,
      this.imagePath,
      this.imageThumbnailPath,
      this.rating,
      this.ratingCount,
      //  this.countdown,
      this.genres,
      this.pictures,
      this.episodes});

  TvShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    permalink = json['permalink'];
    url = json['url'];
    description = json['description'];
    descriptionSource = json['description_source'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    country = json['country'];
    status = json['status'];
    runtime = json['runtime'];
    network = json['network'];
    youtubeLink = json['youtube_link'];
    imagePath = json['image_path'];
    imageThumbnailPath = json['image_thumbnail_path'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    //countdown = json['countdown'];
    genres = json['genres'].cast<String>();
    pictures = json['pictures'].cast<String>();
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['permalink'] = permalink;
    data['url'] = url;
    data['description'] = description;
    data['description_source'] = descriptionSource;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['country'] = country;
    data['status'] = status;
    data['runtime'] = runtime;
    data['network'] = network;
    data['youtube_link'] = youtubeLink;
    data['image_path'] = imagePath;
    data['image_thumbnail_path'] = imageThumbnailPath;
    data['rating'] = rating;
    data['rating_count'] = ratingCount;
    // data['countdown'] = this.countdown;
    data['genres'] = genres;
    data['pictures'] = pictures;
    if (episodes != null) {
      data['episodes'] = episodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episodes {
  int? season;
  int? episode;
  String? name;
  String? airDate;

  Episodes({this.season, this.episode, this.name, this.airDate});

  Episodes.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    episode = json['episode'];
    name = json['name'];
    airDate = json['air_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['season'] = season;
    data['episode'] = episode;
    data['name'] = name;
    data['air_date'] = airDate;
    return data;
  }
}
