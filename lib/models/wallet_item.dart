class WalletItem {
  final String currency;
  final String value;
  final String lockedValue;
  final String address;

  get id => currency;

  WalletItem({
    this.currency,
    this.value,
    this.lockedValue,
    this.address
  });

  WalletItem.fromJson(Map<String, dynamic> json):
    currency = json['currency'],
    value = json['value'].toString(),
    lockedValue = json['lockedValue'].toString(),
    address = json['address'];

  Map<String, dynamic> toJson() => {
    'currency': currency,
    'value': value,
    'lockedValue': lockedValue,
    'address': address
  };

}