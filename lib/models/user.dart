import 'package:sapiency/models/wallet_item.dart';

class User {
  final String nickname;
  final String email;
  final String phone;
  final List<WalletItem> wallets;

  User({this.nickname, this.email, this.phone, this.wallets});

  User.fromJson(Map<String, dynamic> json):
    nickname = json['nickname'],
    email = json['email'],
    phone = json['phone'],
    wallets = (json['wallets'] as List).map((it) => WalletItem.fromJson(it)).toList();

  Map<String, dynamic> toJson() => {
    'nickname': nickname,
    'email': email,
    'phone': phone,
    'wallets': wallets.map((it) => it.toJson()).toList()
  };

}