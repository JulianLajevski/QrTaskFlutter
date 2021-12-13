
class Advert {
  String userId;
  String adId;
  String title;
  String desc;
  String image;
  String price;

  Advert(this.userId, this.adId, this.title, this.desc, this.image, this.price);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'userId': userId,
      'adId': adId,
      'title': title,
      'description': desc,
      'image': image,
      'price': price,
    };
    return map;
  }

  Advert.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    adId = map['adId'];
    title = map['title'];
    desc = map['description'];
    image = map['image'];
    price = map['price'];
  }
}
