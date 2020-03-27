import 'dart:math';
import 'IMCModelo.dart';
import 'PantallaResultado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PantallaIMCStateful extends StatefulWidget {
  @override
  _PantallaIMCState createState() => _PantallaIMCState();
}



class _PantallaIMCState extends State<PantallaIMCStateful> {
  double _alturaUsuario = 100.0;
  double _pesoUsuario = 40.0;
  double _imc = 0;

  IMCModelo _IMCModelo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                child: SvgPicture.asset("assets/images/emoticon-happy-outline.svg", fit: BoxFit.contain,),
              ),
              SizedBox(
                height: 8,
              ),
              Text("IMC", style: TextStyle(color: Colors.lightGreen, fontSize: 34, fontWeight: FontWeight.w700),),
              Text("Nos preocupa tu salud", style: TextStyle(color: Colors.lightBlue, fontSize: 15, fontWeight: FontWeight.w400),),
              SizedBox(
                height: 32,
              ),
              Text("Altura (cm)", style: TextStyle(color: Colors.lightBlue, fontSize: 24, fontWeight: FontWeight.w400),),

              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Slider(
                  min: 80.0,
                  max: 250.0,
                  onChanged: (height){
                    setState(() {
                      _alturaUsuario = height;
                    });
                  },
                  value: _alturaUsuario,
                  divisions: 100,
                  activeColor: Colors.lime,
                  label: "${_alturaUsuario.toStringAsFixed(2)}",
                ),
              ),

              Text("${_alturaUsuario.toStringAsFixed(2)} cm", style: TextStyle(color: Colors.lightGreen, fontSize: 18, fontWeight: FontWeight.w900),),

              SizedBox(height: 24,),

              Text("Peso (kg)", style: TextStyle(color: Colors.lightBlue, fontSize: 24, fontWeight: FontWeight.w400),),

              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Slider(
                  min: 30.0,
                  max: 120.0,
                  onChanged: (height){
                    setState(() {
                      _pesoUsuario = height;
                    });
                  },
                  value: _pesoUsuario,
                  divisions: 100,
                  activeColor: Colors.lime,
                  label: "${_pesoUsuario.toStringAsFixed(2)}",
                ),
              ),

              Text("${_pesoUsuario.toStringAsFixed(2)} kg", style: TextStyle(color: Colors.lightGreen, fontSize: 18, fontWeight: FontWeight.w900),),

              SizedBox(height: 16,),
              Container(
                child: FlatButton.icon(onPressed: (){
                  setState(() {
                    _IMCModelo = new IMCModelo();
                    _imc = (pow((_pesoUsuario/_alturaUsuario), 2))*100;
                    _imc = double.parse(_imc.toStringAsFixed(2));
                    print("Imc = $_imc");
                    _IMCModelo.imc = _imc;
                    if(_imc > 18.5 && _imc < 25.00){
                      _IMCModelo.esNormal = true;
                    }else{
                      _IMCModelo.esNormal = false;
                    }

                    var res = "Normal";
                    if(_imc <= 18.5){
                      res = "Bajo de peso";
                    }else if(_imc > 18.5 && _imc <= 24.9){
                      res = "Peso ideal";
                    }else if(_imc >= 25 && _imc <= 29.9){
                      res = "Sobrepeso";
                    }else{
                      res = "Obesidad";
                    }
                    _IMCModelo.resultado = res;

                  });
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ResultadoIMC(imcModelo: _IMCModelo,)
                  ));
                },
                  icon: Icon(Icons.favorite, color: Colors.white,),
                  label: Text("Mide tu IMC"),
                  textColor: Colors.white,
                  color: Colors.lime,

                ),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              )
            ],
          ),
        ),
      ),
    );
  }



}