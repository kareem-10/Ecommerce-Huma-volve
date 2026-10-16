import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  final String productId;
  const ShareProductButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final productLink =
            " https://souq-corner-a996a.web.app/products/$productId";
        final String shareMessage = "Link to the product: $productLink";
        await SharePlus.instance.share(
          ShareParams(text: shareMessage, subject: "Check out this product"),
        );
      },
      icon: const Icon(Icons.share),
    );
  }
}
