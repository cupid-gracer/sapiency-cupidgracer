import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sapiency/configs/theme.dart';
import 'package:sapiency/models/wallet_item.dart' as Model;

class WalletItem extends StatelessWidget {
  final Model.WalletItem item;

  WalletItem(this.item);

  @override
  Widget build(BuildContext context) {
    final __textTheme = Theme.of(context).textTheme;

    return Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
                bottom: BorderSide(width: 0, color: Colors.grey)
            )
        ),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: SapiencyTheme.primaryColor,
                child: FittedBox(
                  child: Text(item.currency[0]),
                ),
                foregroundColor: Colors.white,
              ),
              title: Text(
                item.currency + " name",
                style: __textTheme.subtitle1,
              ),
              subtitle: Text(
                item.currency,
                style: __textTheme.subtitle2,
              ),
              trailing: Column(
                children: [
                  Text(
                    item.value,
                    style: __textTheme.subtitle1,
                  ),
                  Text(
                    '\$0.00',
                    style: __textTheme.subtitle2,
                  )
                ],
              ),
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              color: SapiencyTheme.primaryColor,
              foregroundColor: Colors.white,
              caption: 'Send',
              icon: Icons.send_rounded,
    //          onTap: () => _showSnackBar('More'),
            ),
            IconSlideAction(
              color: SapiencyTheme.primaryColor,
              foregroundColor: Colors.white,
              caption: 'Deposit',
              icon: Icons.add_box_rounded,
    //          onTap: () => _showSnackBar('Delete'),
            ),
            IconSlideAction(
              color: SapiencyTheme.primaryColor,
              foregroundColor: Colors.white,
              caption: 'Trade',
              icon: Icons.track_changes_rounded,
              //          onTap: () => _showSnackBar('Delete'),
            ),
          ],
        )
    );
  }

}
