import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple interest calculator',
    home: SIform(),
    theme: ThemeData(
      useMaterial3: true,

        primaryColor:Colors.indigo,
      hintColor:Colors.indigoAccent
    ),
  ));
}
class SIform extends StatefulWidget {
  @override
  State<SIform> createState() => _SIformState();

  final _minimumPadding = 5.0;
}

class _SIformState extends State<SIform> {
  var _currencies = ['Rupees','Dollars','Pounds','Others'];
  var _currentItem = 'Rupees';
  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //resizeToAvoidBottomInset:false ,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),backgroundColor: Colors.lightBlueAccent,
      ),

      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
              child:TextField(
                style: TextStyle(color:Colors.white),
                keyboardType: TextInputType.number,
                controller:principalControlled,
              decoration: InputDecoration(
                labelText: 'Principal',
                hintText: 'Enter Principal eg.12000',
                border: OutlineInputBorder(
                borderRadius:BorderRadius.circular(5.0)
                )
              ),
            )),

            Padding(padding:EdgeInsets.only(top: 5.0,bottom: 5.0),
              child:TextField(
                style: TextStyle(color:Colors.white),
              keyboardType: TextInputType.number,
              controller: roiController,
              decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'In Percent',

                  border: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(5.0)
                  )
              ),
            )),
            Padding(padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
            child: Row(
              children:<Widget>[
                Expanded(child: TextField(
                  style: TextStyle(color:Colors.white),
            keyboardType: TextInputType.number,
              controller: termController,
              decoration: InputDecoration(
                  labelText: 'Term',
                  hintText: 'Time in Years',

                  border: OutlineInputBorder(

                      borderRadius:BorderRadius.circular(5.0)
                  )
              ),
            )),
            Container(width: 15.0,),
            Expanded(child:DropdownButton(
               items: _currencies.map((String value){
                 return DropdownMenuItem<String>(
                   value: value,
                   child: Text(value),
                    );
                }).toList(),
                   //value: 'Rupees',
                   onChanged:(newValueSelected){
                      setState(() {
                        this._currentItem = newValueSelected!;
                      });
                       },

              value: _currentItem,
                    ),
            )],
            )),
            Padding(padding: EdgeInsets.only(top: 5.0),
                child:Row(children:<Widget>[
              Expanded(
                child: ElevatedButton(
                  child: Text('Calculate'),
                  style: ElevatedButton.styleFrom(primary: Colors.white38),
                  onPressed: (){
                    setState(() {
                     this.displayResult= _calculateTotalReturns();
                    });
                  },
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(primary: Colors.white38),
                  onPressed: (){
                    setState(() {
                      _reset();
                    });
                  },
                ),
              )
            ])


            ),
            Padding(padding: EdgeInsets.all(10.0),

            child: Text(this.displayResult,style: TextStyle(color: Colors.white),),),
          ],
        ),
      ),
    );
  }
  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage,width: 200.0,height:200.0,);
    return Container(child: image,margin: EdgeInsets.all(7.0),);
  }
  String _calculateTotalReturns(){

    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalamtpayable = principal + (principal*roi*term)/100;

    String result = 'After $term years, your investment will be worth $totalamtpayable $_currentItem';

    return result;
  }
  void _reset(){
    principalControlled.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = _currencies[0];

  }
}

