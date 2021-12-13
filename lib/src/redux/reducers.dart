
import 'package:login_app/src/Models/advert.dart';
import 'package:login_app/src/redux/actions.dart';
import 'package:login_app/src/redux/app_state.dart';

AppState reducer(AppState state, dynamic action) {
  if(action is AddAdvertText) {
    List<Advert> adList = state.advert;
    adList.add(action.advert);
    return AppState(state.advert = adList);
  }
  if(action is DeleteAdvert) {
    List<Advert> adList = state.advert;
    adList.removeWhere((item) => item.adId == action.AdId);
    return AppState(state.advert = adList);
  }
  if(action is UpdateAdvert) {
    List<Advert> adList = state.advert;
    for(var a in adList){
      if(a.adId == action.adId){
        a.title = action.title;
      }
    }
    return AppState(state.advert = adList);
  }
  return state;
}