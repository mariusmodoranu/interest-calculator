import 'dart:ui';

import 'package:calculator/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/entry_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Compound Interest Calculator',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Calculator'),
          ),
          body: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _valid = false;

  String startBalance;
  String annualReturn;
  String years;
  String periodicAddition;

  final List<Widget> myTabs = [
    Tab(text: 'Yearly'),
    Tab(text: 'Quarterly'),
    Tab(text: 'Monthly'),
    Tab(text: 'Weekly')
  ];

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);

    super.initState();
  }

  _handleTabSelection() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_tabController.indexIsChanging &&
        _formKey.currentState != null &&
        _formKey.currentState.validate()) {
      setState(() {
        _valid = true;
      });
    }
  }

  _buildEntry(String entry, String hintText, bool hasSuffix, int type,
      {String suffix, IconData prefixIcon, String prefix}) {
    InputDecoration decoration = hasSuffix
        ? InputDecoration(
            isDense: true,
            suffixText: suffix,
            suffixStyle: TextStyle(
              color: Colors.green,
            ),
            border: new OutlineInputBorder(
              borderSide: new BorderSide(),
            ),
            hintText: hintText,
          )
        : InputDecoration(
            isDense: true,
            prefixIcon: Icon(
              prefixIcon,
              size: 24,
            ),
            border: new OutlineInputBorder(
              borderSide: new BorderSide(),
            ),
            hintText: hintText,
          );

    return Container(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(entry),
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty ||
                    double.tryParse(value) == null ||
                    double.tryParse(value) < 0) {
                  return 'Invalid value';
                }
                switch (type) {
                  case 0:
                    {
                      startBalance = value;
                      break;
                    }
                  case 1:
                    {
                      annualReturn = value;
                      break;
                    }
                  case 2:
                    {
                      years = value;
                      break;
                    }
                  case 3:
                    {
                      periodicAddition = value;
                      break;
                    }
                }
                return null;
              },
              style: TextStyle(
                color: Colors.green,
              ),
              keyboardType: TextInputType.number,
              decoration: decoration,
            ),
          )
        ],
      ),
    );
  }

  _buildTab(Periods period) {
    if (_valid) {
      return Result(EntryModel(
          double.tryParse(startBalance),
          double.tryParse(annualReturn),
          double.tryParse(years).toInt(),
          double.tryParse(periodicAddition),
          period));
    }
    return Container(
      height: 150,
      child: Center(child: Text('Please enter valid data')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    "Compound Interest Calculator",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                ),
              ),
              _buildEntry(
                "Starting Balance",
                "1000",
                false,
                0,
                prefixIcon: Icons.attach_money,
              ),
              _buildEntry("Annual Return Rate (%)", "7", true, 1, suffix: "%"),
              _buildEntry("Duration (Years)", "30", true, 2, suffix: "years"),
              _buildEntry("Periodic Addition", "30", false, 3,
                  prefixIcon: Icons.attach_money),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.redAccent,
                  tabs: myTabs,
                ),
              ),
              ConstrainedBox(
                constraints: new BoxConstraints(
                  minHeight: 270.0,
                ),
                child: Container(
                  color: Colors.amberAccent,
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: [
                        _buildTab(Periods.YEARLY),
                        _buildTab(Periods.QUARTERLY),
                        _buildTab(Periods.MONTHLY),
                        _buildTab(Periods.WEEKLY),
                      ][_tabController.index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
