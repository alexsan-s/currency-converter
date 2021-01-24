import 'package:currency_converter/controller/api.dart';
import 'package:currency_converter/models/colors.dart';
import 'package:currency_converter/models/currency.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Value objBlocText = Value();
  Currency objBlocString1 = Currency();
  Name objBlocName = Name();
  Bid objBlocBid = Bid();
  Future<void> currency;
  Map<String, dynamic> list;
  List<String> listCode = <String>[];

  @override
  void initState() {
    super.initState();
    currency = getData();
  }

  @override
  void dispose() {
    super.dispose();
    objBlocString1.close();
  }

  Future<void> getData() async {
    try {
      list = await getHttp();
      list.forEach((String element, dynamic value) {
        listCode.add(element.toString());
      });
      objBlocString1.change(listCode[0].toString());
      objBlocName.change(list[listCode[0]]['name'].toString());
      objBlocBid.change(double.parse(list[listCode[0]]['bid'].toString()));
      objBlocText.change('1');
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WINE,
        title: const Text('Currency Converter'),
        centerTitle: true,
      ),
      backgroundColor: Colors.amber[50],
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: FutureBuilder<void>(
            future: currency,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: WINE,
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Image(
                      height: 150,
                      image: AssetImage('assets/logo_currency_converter.png'),
                    ),
                    Container(
                      child: StreamBuilder<Object>(
                        stream: objBlocString1.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Erro com a stream');
                          } else {
                            return DropdownButton<String>(
                              isExpanded: true,
                              iconEnabledColor: WINE,
                              underline: Container(
                                height: 2,
                                color: WINE,
                              ),
                              items: listCode.map(
                                (String item) {
                                  return DropdownMenuItem<String>(
                                    value: item.toString(),
                                    child: Text(item),
                                  );
                                },
                              ).toList(),
                              onChanged: (String value) {
                                objBlocString1.change(value);
                                objBlocName
                                    .change(list[value]['name'].toString());
                                objBlocBid.change(double.parse(
                                    list[value]['bid'].toString()));
                              },
                              value: objBlocString1.controller.toString(),
                            );
                          }
                        },
                      ),
                    ),
                    TextFormField(
                      cursorColor: WINE,
                      keyboardType: TextInputType.number,
                      controller: objBlocText.controller,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: WINE,
                            width: 2,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: WINE,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 50),
                    ),
                    StreamBuilder<Object>(
                      stream: objBlocName.stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Erro com a stream');
                        } else {
                          return Text(
                            objBlocName.name,
                            style: const TextStyle(
                              color: WINE,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                      },
                    ),
                    StreamBuilder<Object>(
                      stream: objBlocBid.stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Erro com a stream');
                        } else {
                          return Text(
                            'R\$ ${(objBlocBid.bid * double.parse(objBlocText.controller.text)).toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: WINE,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
