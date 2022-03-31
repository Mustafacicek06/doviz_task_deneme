import 'dart:async';

import 'package:doviz_task/constant/colors.dart';
import 'package:doviz_task/model/currency_model.dart';
import 'package:doviz_task/viewmodel/currency_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({Key? key}) : super(key: key);

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage>
    with SingleTickerProviderStateMixin {
  final firstTextFieldController = TextEditingController();
  final secondTextFieldController = TextEditingController();
  late Stream<String> dbCall;
  final StreamController<String> _controller = StreamController<String>();

  String fromChangeCurrency = "USD";
  String toChangeCurrency = "TRY";
  TabController? tabController;

  List<String> currencyList = ['EUR', 'USD', 'TRY'];
  @override
  void initState() {
    dbCall = _controller.stream;
    firstTextFieldController.text = "1";
    myMethod();
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    firstTextFieldController.dispose();
    firstTextFieldController.removeListener(() {});
    secondTextFieldController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  Future<DovizModel?> myMethod() async {
    CurrencyViewModel _currencyViewModel =
        Provider.of<CurrencyViewModel>(context, listen: false);
    return await _currencyViewModel.getCurrency();
  }

  void _fromChange(String changeItem) {
    setState(() {
      fromChangeCurrency = changeItem;
    });
  }

  void _toChange(String changeItem) {
    setState(() {
      toChangeCurrency = changeItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DovizModel?>(
        future: myMethod(),
        builder: (context, futureSnapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Doviz Yorumları'),
            ),
            bottomNavigationBar: myCustomBottomNavigationBar(),
            body: convertMethod(context, futureSnapshot),
          );
        });
  }

  Container convertMethod(
      BuildContext context, AsyncSnapshot<DovizModel?> futureSnapshot) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: StreamBuilder(builder: (context, snapshot) {
              return StreamBuilder(
                  stream: dbCall,
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      controller: firstTextFieldController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (fromChangeCurrency == "USD" &&
                            toChangeCurrency == "TRY") {
                          firstTextFieldController.addListener(
                            () {
                              secondTextFieldController.text =
                                  (futureSnapshot.data!.usdTry *
                                          double.parse(
                                              firstTextFieldController.text))
                                      .toString();
                            },
                          );
                        } else if (fromChangeCurrency == "EUR" &&
                            toChangeCurrency == "TRY") {
                          firstTextFieldController.addListener(
                            () {
                              secondTextFieldController.text =
                                  (futureSnapshot.data!.eurTry *
                                          double.parse(
                                              firstTextFieldController.text))
                                      .toString();
                            },
                          );
                        }
                      },
                    );
                  });
            }),
            trailing: _currencyDropDownButton(
                currencyList, fromChangeCurrency, futureSnapshot),
          ),
          ListTile(
            title: TextField(
              controller: secondTextFieldController,
              keyboardType: TextInputType.number,
            ),
            trailing: _currencyDropDownButton(
                currencyList, toChangeCurrency, futureSnapshot),
          ),
        ],
      ),
    );
  }

  Material myCustomBottomNavigationBar() {
    return Material(
      color: MyColors.instance.myPrimaryColor,
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        tabs: const [
          Tab(
            icon: Icon(
              Icons.badge,
              color: Colors.grey,
              size: 35,
            ),
            text: "Portföy",
          ),
          Tab(
            icon: Icon(
              Icons.analytics,
              color: Colors.grey,
              size: 35,
            ),
            text: "Piyasalar",
          ),
          Tab(
            icon: Icon(
              Icons.calculate,
              color: Colors.grey,
              size: 35,
            ),
            text: "Çevirici",
          ),
          Tab(
            icon: Icon(
              Icons.message,
              color: Colors.grey,
              size: 35,
            ),
            text: "Yorumlar",
          ),
          Tab(
            icon: Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: 35,
            ),
            text: "Profil",
          ),
        ],
      ),
    );
  }

  DecoratedBox _currencyDropDownButton(List<String> currencyList,
      String? selectedItem, AsyncSnapshot<DovizModel?> snapshot) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
            color: MyColors.instance.myPrimaryColor,
            width: 3), //border of dropdown button
        borderRadius:
            BorderRadius.circular(10), //border raiuds of dropdown button
      ),
      child: DropdownButton(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          value: selectedItem,
          underline: const SizedBox(),
          items: currencyList
              .map((value) => DropdownMenuItem(
                    value: value,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 18,
                            color: MyColors.instance.selectedItomColor),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (items) {
            if (selectedItem == fromChangeCurrency) {
              firstTextFieldController.addListener(
                () {
                  secondTextFieldController.text = (snapshot.data!.usdTry *
                          double.parse(firstTextFieldController.text))
                      .toString();
                },
              );
              _fromChange(items as String);
            } else {
              _toChange(items as String);
            }
          }),
    );
  }
}
