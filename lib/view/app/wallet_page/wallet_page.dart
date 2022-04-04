import 'package:flutter/material.dart';
import 'package:pyxl_assignment/models/user/user.dart';

class WalletPage extends StatefulWidget {
  final User? user;
  WalletPage({Key? key, required this.user}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Center(child: Text("Wallet Page")),
    );
  }
}
