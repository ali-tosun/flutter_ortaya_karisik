
class SevdigiYemekler {

  String yemek;

	SevdigiYemekler.fromJsonMap(Map<String, dynamic> map): 
		yemek = map["yemek"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['yemek'] = yemek;
		return data;
	}
}
