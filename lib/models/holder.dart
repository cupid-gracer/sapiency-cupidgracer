import 'package:sapiency/models/wallet_item.dart';

class Holder {
  final String fullname;
  final String nickname;
  final String symbol;
  final String price;
  final String avatarURL;

  static List<Holder> get holders => [
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  Holder(fullname: "Jhon D", nickname: "JDOE", symbol:"ETH", price: "\$123"),
  ];


  Holder({this.fullname, this.nickname, this.symbol, this.price, this.avatarURL = null});

  Holder.fromJson(Map<String, dynamic> json):
    fullname = json['nickname'],
    nickname = json['nickname'],
    symbol = json['symbol'],
    price = json['price'],
    avatarURL = (json['avatarURL']);

  Map<String, dynamic> toJson() => {
    'fullname': fullname,
    'nickname': nickname,
    'symbol': symbol,
    'price': price,
    'avatarURL': avatarURL 
  };

}