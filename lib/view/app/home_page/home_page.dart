import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/home_page/homepage_bloc.dart';
import 'package:pyxl_assignment/bloc/home_page/homepage_event.dart';
import 'package:pyxl_assignment/bloc/home_page/homepage_state.dart';
import 'package:pyxl_assignment/bloc/send_money/send_money_bloc.dart';
import 'package:pyxl_assignment/bloc/send_money/send_money_event.dart';
import 'package:pyxl_assignment/bloc/send_money/send_money_state.dart';
import 'package:pyxl_assignment/models/portfolio/portfolio.dart';
import 'package:pyxl_assignment/models/transaction/transaction.dart';
import 'package:pyxl_assignment/models/user/user.dart';
import 'package:pyxl_assignment/utils/colors/colors.dart';
import 'package:pyxl_assignment/utils/styles/styles.dart';
import 'package:pyxl_assignment/utils/utils.dart';
import 'package:pyxl_assignment/view/widgets.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  final User? user;
  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController _amountTextController =
      TextEditingController(text: "75.00");
  List cardDetails = [
    {
      "name": "Physical ebl card",
      "assets": "assets/card_logo/mastercard.png",
      "height": 16.0,
    },
    {
      "name": "Virtual ebl card",
      "assets": "assets/card_logo/visa.png",
      "height": 8.0,
    },
    {
      "name": "Ebl debit card",
      "assets": "assets/card_logo/amex.png",
      "height": 10.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => HomePageBloc(),
            child: BlocBuilder<HomePageBloc, HomePageState>(
              builder: (homeContext, homeState) {
                if (homeState.portfolio.accountNumber.isEmpty) {
                  BlocProvider.of<HomePageBloc>(homeContext).add(
                    GetPortfolioAndTransactionHistory(
                      userName: widget.user!.username,
                    ),
                  );
                }
                return Column(
                  children: [
                    vSpace(20),
                    homeAppBar(
                      context,
                      Text(
                        "Good day, ${widget.user!.secondName}",
                        style: actionFront18Black,
                      ),
                      widget.user!.image,
                      "assets/icons/search.png",
                    ),
                    vSpace(20),
                    _portfolioCard(homeState.isError, homeState.portfolio),
                    vSpace(24),
                    _features(homeContext),
                    vSpace(24),
                    _transactionHistoryCard(
                        homeState.isError, homeState.transactions),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _portfolioCard(bool isError, Portfolio portfolio) {
    if (!isError && portfolio.accountType.isEmpty)
      return SizedBox(
        height: 167,
        width: MediaQuery.of(context).size.width,
        child: Shimmer.fromColors(
          baseColor: primaryColor,
          highlightColor: primaryColor.withOpacity(0.5),
          child: Container(
            height: 167,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      );
    else
      return Container(
        height: 167,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  portfolio.accountType,
                  style: h3.copyWith(color: Colors.white.withOpacity(0.6)),
                ),
                Text(
                  widget.user!.firstName + " " + widget.user!.secondName,
                  style: h3.copyWith(color: Colors.white.withOpacity(0.6)),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "\$${portfolio.balance.toStringAsFixed(2)}",
                  style: h6BigFont36,
                ),
                Text(
                  "Total balance",
                  style: h3,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Added card:${portfolio.numberOfCards}",
                  style: h3.copyWith(color: Colors.white.withOpacity(0.6)),
                ),
                Text(
                  "Ac. no. ${portfolio.accountNumber}",
                  style: h3.copyWith(color: Colors.white.withOpacity(0.6)),
                ),
              ],
            ),
          ],
        ),
      );
  }

  Widget _features(BuildContext homeContext) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Features",
              style: actionFront18Black,
            ),
            Text(
              "See more",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: black100,
              ),
            ),
          ],
        ),
        vSpace(16),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _sendMoneyModal(homeContext);
                },
                child: _featureButtons("assets/icons/money-send.png", "Send"),
              ),
            ),
            hSpace(12),
            Expanded(
                child: _featureButtons(
                    "assets/icons/money-recive.png", "Receive")),
            hSpace(12),
            Expanded(
                child: _featureButtons("assets/icons/Award 6.png", "Rewards")),
          ],
        ),
      ],
    );
  }

  Widget _featureButtons(String asset, String text) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            asset,
            height: 20,
            width: 20,
          ),
          hSpace(12),
          Text(
            text,
            style: h3Black,
          ),
        ],
      ),
    );
  }

  Widget _transactionHistoryCard(bool isError, List<Transaction> transactions) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent activity",
              style: actionFront18Black,
            ),
            Row(
              children: [
                Text(
                  "All",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: black100,
                  ),
                ),
                hSpace(10),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: black100,
                ),
              ],
            ),
          ],
        ),
        vSpace(12),
        if (!isError && transactions.length == 0)
          SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.width,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (_, __) => Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          )
        else
          Column(
            children: List.generate(
              transactions.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    Image.asset(
                      transactions[index].contact.image,
                      height: 64,
                      width: 64,
                    ),
                    hSpace(12),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                transactions[index].contact.fullName(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: black100,
                                ),
                              ),
                              Text(
                                "${transactions[index].isOutGoing ? '-' : '+'} \$" +
                                    transactions[index]
                                        .amount
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: transactions[index].isOutGoing
                                      ? redText
                                      : primaryColor,
                                ),
                              ),
                            ],
                          ),
                          vSpace(6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getDate(transactions[index].date),
                                style: h2Black,
                              ),
                              Text(
                                getTime(transactions[index].date),
                                style: h2Black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _sendMoneyModal(BuildContext homeContext) {
    Widget getCardList() {
      return SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 16.0, left: index == 0 ? 25 : 0),
              child: Container(
                height: 38,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: index == 0 ? primaryColor : black10,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      cardDetails[index]['assets'],
                      height: cardDetails[index]['height'],
                      color: index == 0 ? null : black100,
                    ),
                    hSpace(12),
                    Text(
                      cardDetails[index]['name'],
                      style: index == 0 ? h2 : h2Black,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    Widget getSearchContacts() {
      return Column(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: BlocBuilder<SendMoneyBloc, SendMoneyState>(
                    builder: (sendMoneyContext, state) {
                      return TextField(
                        onChanged: (value) {
                          BlocProvider.of<SendMoneyBloc>(sendMoneyContext)
                              .add(SearchUserInputChanged(searchText: value));
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: "Type name/card/phone number/email",
                        ),
                      );
                    },
                  ),
                ),
                Image.asset(
                  "assets/icons/Security Safe.png",
                  height: 24,
                  width: 24,
                ),
              ],
            ),
          ),
          vSpace(12),
          BlocBuilder<SendMoneyBloc, SendMoneyState>(
            builder: (sendMoneyContext, state) {
              return SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.contacts.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<SendMoneyBloc>(sendMoneyContext).add(
                              SelectContact(
                                  selectedContact: state.contacts[index]));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              state.contacts[index].image,
                              height: 64,
                              width: 64,
                            ),
                            vSpace(4),
                            Text(
                              state.contacts[index].fullName(),
                              style: h2Black.copyWith(
                                  color: state.selectedContact ==
                                          state.contacts[index]
                                      ? primaryColor
                                      : black100),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      );
    }

    Widget getAmountTextField() {
      return Container(
        height: 156,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: TextField(
            textAlign: TextAlign.center,
            controller: _amountTextController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: h6BigFont36Black,
            decoration: InputDecoration.collapsed(hintText: ""),
          ),
        ),
      );
    }

    showBottomSheet(
      enableDrag: true,
      context: context,
      builder: (_) {
        return BlocProvider(
          create: (context) => SendMoneyBloc(),
          child: Container(
            height: MediaQuery.of(context).size.height -
                90 -
                MediaQuery.of(context)
                    .padding
                    .top, // 90 = app bar height(50) + top bottom spacing(20+20)
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSpace(12),
                  Center(
                    child: Container(
                      height: 5,
                      width: 68,
                      decoration: BoxDecoration(
                        color: black60,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  vSpace(16),
                  Center(
                    child: Text("Send money", style: h5SecondaryBigFont24),
                  ),
                  vSpace(25),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Select card",
                      style: actionFront18Black,
                    ),
                  ),
                  vSpace(16),
                  getCardList(),
                  vSpace(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose recipient",
                          style: actionFront18Black,
                        ),
                        vSpace(16),
                        getSearchContacts(),
                        vSpace(24),
                        Text(
                          "Amount",
                          style: actionFront18Black,
                        ),
                        vSpace(16),
                        getAmountTextField(),
                      ],
                    ),
                  ),
                  vSpace(16),
                  BlocConsumer<SendMoneyBloc, SendMoneyState>(
                    listener: (context, state) {
                      if (state.isError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.responseMessage),
                          ),
                        );
                        return;
                      } else if (state.isSuccess) {
                        Transaction newTransaction = Transaction(
                          contact: state.selectedContact!,
                          amount: state.amount,
                          date: DateTime.now(),
                          isOutGoing: true,
                        );
                        BlocProvider.of<HomePageBloc>(homeContext)
                            .add(AddTransaction(transaction: newTransaction));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.responseMessage),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: GestureDetector(
                            onTap: () {
                              if (state.selectedContact == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Choose a recipient"),
                                  ),
                                );
                                return;
                              }
                              BlocProvider.of<SendMoneyBloc>(context).add(
                                SendMoneyTransaction(
                                  contacts: state.contacts,
                                  selectedContact: state.selectedContact!,
                                  amount:
                                      double.parse(_amountTextController.text),
                                  responseMessage: "",
                                ),
                              );
                            },
                            child: Container(
                              height: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: primaryColor,
                              ),
                              child: Center(
                                  child:
                                      Text("Send money", style: actionFront18)),
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
