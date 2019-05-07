
class Burc{


  String _burcIsim;
  String _burcTarih;

  Burc(this._burcIsim, this._burcTarih);

  String get burcTarih => _burcTarih;

  set burcTarih(String value) {
    _burcTarih = value;
  }

  String get burcIsim => _burcIsim;

  set burcIsim(String value) {
    _burcIsim = value;
  }


}