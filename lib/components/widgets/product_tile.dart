import 'package:flutter/material.dart';
import 'package:qop_timbu/models/product.dart';

//Product List Tile widget
class ProductTile extends StatefulWidget {
  final Product productInfo;
  final void Function() tapped;
  final void Function() onAddToBag;

  const ProductTile({
    super.key,
    required this.productInfo,
    required this.tapped,
    required this.onAddToBag,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.tapped,
              child: Container(
                height: 140,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.productInfo.imageUrl.isNotEmpty
                        ? NetworkImage(widget.productInfo.imageUrl)
                        : const NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFKwpAYLdgVvhphi1bbppMkQhSmYHBJ2OtpRAVqVuocx5qoXzuHcNjGWHjXBRGJR9uoHM&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 6.0,
              children: [
                GestureDetector(
                  onTap: widget.tapped,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      widget.productInfo.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                Text(
                  widget.productInfo.currentPrice != null
                      ? 'N${widget.productInfo.currentPrice}'
                      : 'Price not available',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 3.0,
                  children: [
                    const CircleAvatar(
                        radius: 4, backgroundColor: Color(0x9E9E8570)),
                    Text(
                      widget.productInfo.category,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0x9E9E8570),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 19),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      widget.onAddToBag();
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black45, width: 1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Add To Bag',
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1.0,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
