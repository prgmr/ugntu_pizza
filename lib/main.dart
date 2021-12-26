import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Pizza'),
    );
  }
}

enum sauseTypes { spicy, sweetAndSour, cheesy }
List<bool> doughTypesList = [true, false];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _doughPriceRatio = 1.3;
  double _size = 25;
  sauseTypes? _sauseType = sauseTypes.spicy;
  double _sausePrice = 0;
  bool _needCheese = true;
  int _price = 0;

  int getPrice() {
    var cheesePrice = _needCheese ? 50 : 0;
    return (_size * 10 * _doughPriceRatio + _sausePrice + cheesePrice).round();
  }

  @override
  void initState() {
    super.initState();
    _price = getPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/pizza.png',
                    height: 123,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Калькулятор пиццы",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  "Выберите параметры:",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(16),
                //     color: Colors.grey[200]),
                child: ToggleButtons(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _doughPriceRatio = 1.3;
                          _price = getPrice();
                        });
                      },
                      child: Text(
                        "Обычное тесто",
                        style: TextStyle(fontFamily: "Roboto", fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _doughPriceRatio = 1;
                          _price = getPrice();
                        });
                      },
                      child: Text(
                        "Тонкое тесто",
                        style: TextStyle(fontFamily: "Roboto", fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                    ),
                  ],
                  isSelected: doughTypesList,
                  onPressed: (int index) {
                    setState(() {
                      doughTypesList[index] = !doughTypesList[index];
                    });
                  },
                  // fillColor: Colors.white,
                  // borderColor: null,
                  renderBorder: false,
                  // disabledColor: Colors.grey[200],
                  // borderRadius: BorderRadius.circular(16),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Размер:",
                  style: TextStyle(fontFamily: "Roboto", fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${_size.round()}"),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Color(0xFFC4C4C4),
                        inactiveTrackColor: Colors.grey[200],
                        // trackShape: RoundedRectSliderTrackShape(),
                        // trackHeight: 4.0,
                        // thumbShape:
                        //     RoundSliderThumbShape(enabledThumbRadius: 10.0),
                        // thumbColor: Colors.redAccent,
                        // overlayColor: Colors.red.withAlpha(32),
                        // overlayShape:
                        //     RoundSliderOverlayShape(overlayRadius: 28.0),
                        // tickMarkShape: RoundSliderTickMarkShape(),
                        // activeTickMarkColor: Colors.red[700],
                        // inactiveTickMarkColor: Colors.red[100],
                        // valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        // valueIndicatorColor: Colors.redAccent,
                        // valueIndicatorTextStyle: TextStyle(
                        //   color: Colors.white,
                        // ),
                      ),
                      child: Slider(
                          min: 12,
                          max: 30,
                          value: _size,
                          divisions: 18,
                          onChanged: (double value) {
                            setState(() {
                              _size = value;
                              _price = getPrice();
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Соус:",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text("Острый"),
                    trailing: Transform.scale(
                      scale: 1,
                      child: Radio<sauseTypes>(
                        activeColor: Colors.green,
                        groupValue: _sauseType,
                        value: sauseTypes.spicy,
                        onChanged: (sauseTypes? value) {
                          setState(() {
                            _sauseType = value;
                            _sausePrice = 30;
                            _price = getPrice();
                          });
                        },
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Кисло-сладкий"),
                    trailing: Radio<sauseTypes>(
                      activeColor: Colors.green,
                      groupValue: _sauseType,
                      value: sauseTypes.sweetAndSour,
                      onChanged: (sauseTypes? value) {
                        setState(() {
                          _sauseType = value;
                          _sausePrice = 50;
                          _price = getPrice();
                        });
                      },
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Сырный"),
                    trailing: Radio<sauseTypes>(
                      activeColor: Colors.green,
                      groupValue: _sauseType,
                      value: sauseTypes.cheesy,
                      onChanged: (sauseTypes? value) {
                        setState(() {
                          _sauseType = value;
                          _sausePrice = 100;
                          _price = getPrice();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/cheese.png',
                      height: 34,
                    ),
                    Text(
                      "Дополнительный сыр",
                      style: TextStyle(fontFamily: "Inter", fontSize: 16),
                    ),
                    Switch(
                        value: _needCheese,
                        onChanged: (value) {
                          setState(() {
                            _needCheese = value;
                            _price = getPrice();
                          });
                        })
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                child: Text(
                  "Стоимость:",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Text("$_price", style: TextStyle(fontSize: 20)),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: 154,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Заказать",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
