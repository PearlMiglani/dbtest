class MovieModel {
  final int? id;
  final String mname;
  final String dname;
  final String? img;

  const MovieModel(
      {this.id,
      required this.mname,
      required this.dname,
      this.img});

  MovieModel copy({
    int? id,
    String? mname,
    String? dname,
    String? img,
  }) =>
    MovieModel(
          id: id ?? this.id,
          mname: mname ?? this.mname,
          dname: dname ?? this.dname,
          img: img);

  static MovieModel fromJson(Map<String, Object?> json) => MovieModel(
      id: json['id'] as int?,
      mname: json['mname'] as String,
      dname: json['dname'] as String,
      img: json['img'] as String);

  Map<String, Object?> toJson() => {
        'id': id,
        'mname': mname,
        'dname': dname,
        'img': img
      };
}