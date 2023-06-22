// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class ProfileImage {
  String? imageUrl;
  ProfileImage({
    this.imageUrl,
  });
  


  ProfileImage copyWith({
    String? imageUrl,
  }) {
    return ProfileImage(
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
    };
  }

  factory ProfileImage.fromMap(Map<String, dynamic> map) {
    return ProfileImage(
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileImage.fromJson(String source) => ProfileImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProfileImage(imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant ProfileImage other) {
    if (identical(this, other)) return true;
  
    return 
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => imageUrl.hashCode;
}
