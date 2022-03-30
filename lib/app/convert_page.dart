import 'package:doviz_task/model/currency_model.dart';
import 'package:doviz_task/viewmodel/currency_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({Key? key}) : super(key: key);

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  @override
  void initState() {
    myMethod();
    super.initState();
  }

  Future<DovizModel?> myMethod() async {
    CurrencyViewModel _currencyViewModel =
        Provider.of<CurrencyViewModel>(context, listen: false);
    return await _currencyViewModel.getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    /*  var usdtry = _currencyViewModel.dovizModel!.usdTry.toString();
    debugPrint(usdtry); */

    return FutureBuilder<DovizModel?>(
        future: myMethod(),
        builder: (context, snapshot) {
          String usdTry = snapshot.data?.usdTry.toString() ?? "";
          String euroTry = snapshot.data?.eurTry.toString() ?? "";

          List<String> item = ["item1", "item2"];

          String? selectedItem;

          var dropDownItems = ['EUR', 'USD', 'TRY'];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Döviz Yorumları'),
            ),
            body: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            maxLines: 1,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.zero)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                // Red border with the width is equal to 5
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).backgroundColor)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  value: selectedItem,
                                  alignment: Alignment.center,
                                  hint: Text(selectedItem ?? ''),
                                  focusColor: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  items: dropDownItems
                                      .map((e) => DropdownMenuItem(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                e,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            value: e,
                                          ))
                                      .toList(),
                                  selectedItemBuilder: (BuildContext context) =>
                                      dropDownItems
                                          .map((e) => Center(
                                                child: Text(
                                                  e,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.amber,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ))
                                          .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedItem = value;
                                    });
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 25.0, left: 25.0, top: 15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            maxLines: 1,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.zero)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                // Red border with the width is equal to 5
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).backgroundColor)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  alignment: Alignment.center,
                                  focusColor: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  items: dropDownItems.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {});
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  DropdownButton<String>(
                    hint: Text(selectedItem ?? ''),
                    style: TextStyle(color: Colors.black),
                    value: selectedItem,
                    onChanged: (changesValue) {
                      setState(() {
                        selectedItem = changesValue;
                        debugPrint(selectedItem);
                      });
                    },
                    items: item.map((valueItem) {
                      return DropdownMenuItem(
                        child: Text(valueItem),
                        value: valueItem,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
