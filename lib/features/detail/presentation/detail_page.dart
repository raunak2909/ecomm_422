import 'package:ecomm_422/features/dashboard/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  ProductModel currProduct;
  ProductDetailPage({required this.currProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 45,
                  child: Container(
                    color: Colors.grey.shade200,
                  )),
              Expanded(
                  flex: 55,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(41))
                    ),
                  ))
            ],
          ),
          Positioned(
            bottom: 0,
              child: Container(
                margin: EdgeInsets.all(21),
            padding: EdgeInsets.only(left: 21, right: 11),
            width: MediaQuery.of(context).size.width-42,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50)
            ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2
                          ),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Text("-", style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: 16,
                          ),
                          Text("1", style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: 16,
                          ),
                          Text("+", style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 11),
                      height: double.infinity,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.deepOrangeAccent
                      ),
                      child: Center(
                        child: Text('Add to Cart', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
          ))
        ],
      ),

    );
  }
}
