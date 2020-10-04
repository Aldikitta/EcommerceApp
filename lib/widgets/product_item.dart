import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: Container(
        decoration: (BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        )),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(90),
                  // For  demo we use fixed height  and width
                  // Now we dont need them
                  // height: 180,
                  // width: 160,
                  decoration: BoxDecoration(
                    // color: Color(0xFF3D82AE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child: Container(),
                ),
                Positioned(
                  right: 0,
                  child: Consumer<Product>(
                    builder: (ctx, product, _) => IconButton(
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        product.toggleFavoriteStatus(
                          authData.token,
                          authData.userId,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              // margin: EdgeInsets.all(15),
              padding: EdgeInsets.only(left: 15, top: 5),
              // height: 100,
              decoration: BoxDecoration(
                color: Color(0xff46515E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xffffffff),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      cart.addItem(product.id, product.price, product.title);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Added item to cart!',
                          ),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(product.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
