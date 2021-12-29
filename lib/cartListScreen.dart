import 'package:case_study/dbHelper.dart';
import 'package:case_study/model/cart.dart';
import 'package:case_study/widgets/cartListWidget.dart';
import 'package:flutter/material.dart';

class CartListScreen extends StatefulWidget {
  // const CartListScreen({ Key? key }) : super(key: key);

  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  Future<List<CartGet>> _carts;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    loadCarts();
  }

  void loadCarts(){
    _carts = _databaseHelper.getCarts();
    if(mounted){
      setState(() {});
    }
  }

  @override
  void dispose() {
    // disposing states
    _scaffoldKey?.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Carts",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: (){
          return Future.delayed(Duration(seconds: 2), (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartListScreen()));
          });  
        },
        child: FutureBuilder(
          future: _carts,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }else if(!snapshot.hasData || snapshot.data == null){
              return Center(
                child: Text(
                  "no data"
                )
              );
            }else if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  CartGet cart = snapshot.data[index];
                  return CardListWidget(
                    cart: cart,
                    press: () => print(cart.cartId.toString()),
                    delete: (){
                      _databaseHelper.deleteCart(cart.cartId);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartListScreen()));
                    },
                  );
                },
              );
            }

          },
          
        ),
      )
    );
  }
  
}