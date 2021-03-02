import 'package:money_converter/core/enums/convertertype.dart';
import 'package:money_converter/core/enums/viewstates.dart';
import 'package:money_converter/core/models/currency.dart';
import 'package:money_converter/core/viewmodels/home_viewmodel.dart';
import 'package:money_converter/ui/views/views.dart';
import 'package:flutter/material.dart';
import 'package:money_converter/ui/widgets/dropdown.dart';
import 'package:money_converter/ui/widgets/form_input.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Currency firstCurrencySelectedItem, secondCurrencySelectedItem;
  TextEditingController firstAmountController;
  TextEditingController secondAmountController;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BaseView<HomeModel>(
      //wants to access the model functions?
      onModelReady: (model) async {
        await model.initSetup();
        firstAmountController = TextEditingController(text: model.firstAmount);
        secondAmountController =
            TextEditingController(text: model.secondAmount);
      },
      //the model will call that function getuser.
      builder: (context, model, child) => Scaffold(
        //wants to listen to model state: busy or idle?
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: "Welcome ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: model.user == null
                                            ? ""
                                            : model.user.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Icon(Icons.notifications),
                            SizedBox(width: 12),
                            GestureDetector(
                              child: Icon(Icons.logout),
                              onTap: () async {
                                var status = await model.logout();
                                if (status) {
                                  Navigator.pushNamed(context, "/signin");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    converterCard(size, model),
                    SizedBox(height: 14),
                    Card(
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "History",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget converterCard(dynamic size, HomeModel model) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Currency Converter",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey[400],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      onChanged: (value) => amountChanged(1, value, model),
                      controller: firstAmountController,
                      decoration: InputDecoration.collapsed(
                        hintText: "0",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.45,
                    child: myDropdown(
                      currencies: currencies,
                      selectedItem: model.firstCurrency,
                      hintText: "Select Currency",
                      model: model,
                      onChanged: firstCurrency,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey[400],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: secondAmountController,
                      onChanged: (value) => amountChanged(2, value, model),
                      decoration: InputDecoration.collapsed(
                        hintText: "0",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.45,
                    child: myDropdown(
                      currencies: currencies,
                      selectedItem: model.secondCurrency,
                      hintText: "Select Currency",
                      model: model,
                      onChanged: secondCurrency,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  firstCurrency(Currency currency, HomeModel model) {
    print("First Currency: ${currency.toString()}");
    //set it to model
    model.setCurrency(firstOrSecond: 1, currency: currency);

    var newFirstAmount = firstAmountController.text;
    var newSecondAmount = secondAmountController.text;
    //update the model's amount value accordingly
    //trigger the convertercalculator from model
    model.convertTheMoney(
      firstAmount: newFirstAmount,
      secondAmount: newSecondAmount,
      converterType: ConverterType.Currency,
    );
  }

  secondCurrency(Currency currency, HomeModel model) {
    print("Second Currency: ${currency.toString()}");

    model.setCurrency(firstOrSecond: 2, currency: currency);
    var newFirstAmount = firstAmountController.text;
    var newSecondAmount = secondAmountController.text;
    //update the model's amount value accordingly
    //trigger the convertercalculator from model
    model.convertTheMoney(
      firstAmount: newFirstAmount,
      secondAmount: newSecondAmount,
      converterType: ConverterType.Currency,
    );
  }

  amountChanged(int firstOrSecond, String amount, HomeModel model) {
    var newFirstAmount = firstAmountController.text;
    var newSecondAmount = secondAmountController.text;
    //update the model's amount value accordingly
    //trigger the convertercalculator from model
    model.convertTheMoney(
      firstAmount: newFirstAmount,
      secondAmount: newSecondAmount,
      converterType: ConverterType.Amount,
    );
  }
}
