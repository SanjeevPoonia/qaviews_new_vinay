import 'package:flutter/material.dart';

class CartWidget extends StatelessWidget {
  Function onDeleteTap;
  int pos;
  CartWidget(this.onDeleteTap,this.pos);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10, top: 5),
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Color(0xFFf6f6f6)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 7),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/cement_bg.png'),
                        )),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 60,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/minus_ic.png',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 6),
                        Text('1',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        SizedBox(width: 6),
                        Image.asset(
                          'assets/plus_ic.png',
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(width: 7),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text('Birla Shakthi Cement PPC',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 2),
                  Text('Quantity 75 Bags',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3F4C58).withOpacity(0.5))),
                  SizedBox(height: 2),
                  Text('Estimate Delivery Time : 16 July 2022',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF00DB00).withOpacity(0.5))),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Text('₹ 24,200.00',
                          style: TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFc4c4c4))),
                      Text(' incl. GST',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFc4c4c4))),
                      Spacer(),

                      GestureDetector(
                        onTap: (){
                          onDeleteTap();
                        },

                        child: Image.asset(
                          'assets/trash_ic.png',
                          width: 19.6,
                          height: 21.5,
                        ),

                      ),
                      SizedBox(width: 15)
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('₹ 17,608.00',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.red)),
                      Text(' Per Unit Price',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('Move to Wishlist',
                      style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: Color(0XFfC15D27))),

                  pos==0?    SizedBox(height: 10):Container(),
                  pos==0?    Container(
                    height: 25,
                    margin: EdgeInsets.only(right: 15),
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5,left: 5),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3)
                    ),
                    child:  Text('Price Increase simply dummy text',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white)),

                  ):Container(),


                ],
              ))
            ],
          ),
        ),
        SizedBox(height: 15),




      ],
    );
  }
}
/*Container(
height: 22,

decoration: BoxDecoration(
borderRadius: BorderRadius.circular(2),
color: Colors.red,
),
)*/


class PaymentWidget extends StatelessWidget {
  final int pos;
  final bool secondOption;
  PaymentWidget(this.pos,this.secondOption);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10, top: 5),
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Color(0xFFf6f6f6)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 7),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/cement_bg.png'),
                        )),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 60,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/minus_ic.png',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 6),
                        Text('1',
                            style:
                            TextStyle(fontSize: 15, color: Colors.black)),
                        SizedBox(width: 6),
                        Image.asset(
                          'assets/plus_ic.png',
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(width: 7),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('Birla Shakthi Cement PPC',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      SizedBox(height: 2),
                      Text('Quantity 75 Bags',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF3F4C58).withOpacity(0.5))),
                      SizedBox(height: 2),
                      Text('Estimate Delivery Time : 16 July 2022',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF00DB00).withOpacity(0.5))),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text('₹ 24,200.00',
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFc4c4c4))),
                          Text(' incl. GST',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFc4c4c4))),
                          Spacer(),
                          Image.asset(
                            'assets/trash_ic.png',
                            width: 19.6,
                            height: 21.5,
                          ),
                          SizedBox(width: 15)
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text('₹ 17,608.00',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red)),
                          Text(' Per Unit Price',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red)),
                        ],
                      ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Move to Wishlist',
                              style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  color: Color(0XFfC15D27))),


                         secondOption? Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text('Move to Non COD',
                                style: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    color: Color(0XFfC15D27))),
                          ):Container()                        ],
                      ),


                  pos==0?    SizedBox(height: 10):Container(),
                  pos==0?    Container(
                        height: 22,
                        margin: EdgeInsets.only(right: 15),
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 5,left: 5),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3)
                    ),
                        child:  Text('Price Increase simply dummy text',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white)),

                      ):Container(),


                      SizedBox(height: 10),



                    ],
                  ))
            ],
          ),
        ),
        SizedBox(height: 15),




      ],
    );
  }
}
