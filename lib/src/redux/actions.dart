
import 'package:login_app/src/Models/advert.dart';

class AddAdvertText{
  final Advert advert;

  AddAdvertText(this.advert);

}

class DeleteAdvert {
  final String AdId;

  DeleteAdvert(this.AdId);
}

class UpdateAdvert {
  final String title;
  final String adId;

  UpdateAdvert(this.title, this.adId);
}