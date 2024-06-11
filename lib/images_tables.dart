import 'package:flutter/material.dart';
import 'package:myapp/images.dart';

class ImagesTables extends StatelessWidget {
  const ImagesTables({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      ImageData("image_name", "image_url"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Images"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Table(
          border: TableBorder.all(),
          children: [
            const TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Image name"),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Image url"),
                  ),
                ),
              ],
            ),
            for (ImageData image in images)
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        image.name,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        image.url,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
