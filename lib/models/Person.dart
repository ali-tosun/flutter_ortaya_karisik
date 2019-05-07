import 'package:flutter_burc_rehberi/models/sevdigi_yemekler.dart';

class Person {

  String adi;
  String soyadi;
  int yas;
  List<SevdigiYemekler> sevdigiYemekler;

	Person.fromJsonMap(Map<String, dynamic> map): 
		adi = map["adi"],
		soyadi = map["soyadi"],
		yas = map["yas"],
		sevdigiYemekler = List<SevdigiYemekler>.from(map["sevdigiYemekler"].map((it) => SevdigiYemekler.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['adi'] = adi;
		data['soyadi'] = soyadi;
		data['yas'] = yas;
		data['sevdigiYemekler'] = sevdigiYemekler != null ? 
			this.sevdigiYemekler.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
