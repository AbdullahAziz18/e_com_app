import 'package:flutter/services.dart' as the_bundle;
import 'package:e_com_app/models/sneakers_model.dart';

// this class fetches data from the json file and return it to the app
class Helper {
  //male
  Future<List<Sneakers>> getMaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/men_shoes.json');

    final maleList = sneakersFromJson(data);

    return maleList;
  }

//female
  Future<List<Sneakers>> getFemaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/women_shoes.json');

    final femaleList = sneakersFromJson(data);

    return femaleList;
  }

//kids
  Future<List<Sneakers>> getKidsSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/kids_shoes.json');

    final kidsList = sneakersFromJson(data);

    return kidsList;
  }

  //single male
  Future<Sneakers> getMaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/men_shoes.json');

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  //single female
  Future<Sneakers> getFemaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/women_shoes.json');

    final femaleList = sneakersFromJson(data);

    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

//single kids
  Future<Sneakers> getKidSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/kids_shoes.json');

    final kidsList = sneakersFromJson(data);

    final sneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
}
