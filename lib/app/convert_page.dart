import 'dart:async';

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
  final firstTextFieldController = TextEditingController();
    final secondTextFieldController = TextEditingController();
    late Stream<String> dbCall;
      final StreamController<String> _controller =  StreamController<String>();
  
 String fromChangeCurrency = "USD";
   String toChangeCurrency ="TRY";
   

   List<String> currencyList = ['EUR', 'USD', 'TRY'];  
   @override
  void initState() {
    dbCall = _controller.stream;
       firstTextFieldController.text="1";
    myMethod();
    super.initState();
  }
  //void _printLatestValue() {
    //    secondTextFieldController.text =(3 * double.parse(firstTextFieldController.value.text)).toString();

      //}
  @override
  void dispose() {
    firstTextFieldController.dispose();
    firstTextFieldController.removeListener(() { });
    secondTextFieldController.dispose();
    super.dispose();
  }


  Future<DovizModel?> myMethod() async {
    CurrencyViewModel _currencyViewModel =
        Provider.of<CurrencyViewModel>(context, listen: false);
    return await _currencyViewModel.getCurrency();
  }
 

 

    _fromChange(String changeItem){
    setState(() {
       fromChangeCurrency=changeItem;
       

       
    });
  }
  _toChange(String changeItem){
    setState(() {
      toChangeCurrency = changeItem;
      
      
    });
  }


  @override
  Widget build(BuildContext context) {
    /*  var usdtry = _currencyViewModel.dovizModel!.usdTry.toString();
    debugPrint(usdtry); */
    
   // firstTextFieldController.addListener(() {
//secondTextFieldController.text =(double.parse(usdTry) * double.parse(firstTextFieldController.text) ).toString();
  //        },);
   

    return FutureBuilder<DovizModel?>(
        future: myMethod(),
        builder: (context, futureSnapshot) {
          
          
          return Scaffold(
            appBar: AppBar(title: const Text('Doviz Yorumları'),),
            bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.abc),label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.abc),label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.abc),label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.abc),label: "home"),

              ]),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(title: StreamBuilder(
                    
                    builder: (context,snapshot) {
                      return StreamBuilder(
                        stream: dbCall,
                        builder: (context,AsyncSnapshot<String> snapshot) {
                          return TextField(
                          
                          controller: firstTextFieldController,
                          keyboardType: TextInputType.number,
                          onChanged: (value){
                            if(fromChangeCurrency =="USD"&& toChangeCurrency =="TRY")
                            {firstTextFieldController.addListener(() {
secondTextFieldController.text =(futureSnapshot.data!.usdTry * double.parse(firstTextFieldController.text) ).toString();
          },);}
              else if(fromChangeCurrency =="EUR"&& toChangeCurrency =="TRY"){
                firstTextFieldController.addListener(() {
secondTextFieldController.text =(futureSnapshot.data!.eurTry * double.parse(firstTextFieldController.text) ).toString();
          },);
              }
                            
                          },
                            
                          
                          
                );
                        }
                      );
                    }
                  ),
                trailing: _currencyDropDownButton(currencyList,fromChangeCurrency,futureSnapshot),
                ),
                ListTile(title: TextField(
                  controller: secondTextFieldController,
                  keyboardType: TextInputType.number,
                  
                ),
                trailing: _currencyDropDownButton(currencyList,toChangeCurrency, futureSnapshot),
                ),
                ],
                
              ),

            ),
          );
        });


  }
 
  DropdownButton<dynamic> _currencyDropDownButton(List<String> currencyList ,String? selectedItem,AsyncSnapshot<DovizModel?> snapshot) { 
    
    return DropdownButton(
    value: selectedItem,
    items: currencyList.map((value) => DropdownMenuItem(
                                            value: value,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                value,
                                                style: const TextStyle(fontSize: 18),
                                                
                                              ),
                                              
                                            ),
                                            
                                          ))
                                      .toList(), onChanged: ( items){

                                          
                                        if(selectedItem == fromChangeCurrency ){
                                         
                                              firstTextFieldController.addListener(() {
secondTextFieldController.text =(snapshot.data!.usdTry * double.parse(firstTextFieldController.text) ).toString();
          },);
                                            _fromChange(items);
                                           
                                           
                                        }else{

                                            
                                            _toChange(items);
                                        }
                                        
                                        
                                        
                                        
                                      });

  }
  
  
}
