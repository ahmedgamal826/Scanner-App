import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/features/write_page/data/provider/whiteboard_provider.dart';
import 'package:scanner_app/features/write_page/presentation/views/widgets/stroke_width_slider.dart';
import 'package:whiteboard/whiteboard.dart';

class WhiteBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = WhiteboardProvider();
        provider.loadSavedImages();
        return provider;
      },
      child: Consumer<WhiteboardProvider>(
        builder: (context, provider, child) {
          double width = MediaQuery.of(context).size.width;

          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              backgroundColor: Colors.orange,
              title: const Text(
                'Whiteboard',
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // actions: [
              //   IconButton(
              //     icon: const Icon(Icons.image),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => SavedImagesPage(
              //             savedImages: provider.getSavedImages(),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ],
            ),
            body: Row(
              children: [
                Container(
                  width: width * 0.16,
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: provider.clearBoard,
                      ),
                      IconButton(
                        icon: const Icon(Icons.undo),
                        onPressed: provider.undo,
                      ),
                      IconButton(
                        icon: const Icon(Icons.redo),
                        onPressed: provider.redo,
                      ),
                      const Divider(),
                      IconButton(
                        icon: Icon(
                            provider.isErasing ? Icons.brush : Icons.delete),
                        onPressed: provider.toggleEraser,
                      ),
                      // const Divider(),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.save,
                      //     color: provider.isBoardModified
                      //         ? Colors.orange
                      //         : Colors.grey,
                      //   ),
                      //   onPressed: provider.isBoardModified
                      //       ? () => provider.saveImage(context)
                      //       : null, // Disable button if no changes
                      // ),
                      const Divider(),
                      const Text('Colors',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // إضافة اللون الأسود ضمن الألوان
                              GestureDetector(
                                onTap: () {
                                  if (!provider.isErasing) {
                                    provider.setColor(Colors.black);
                                  }
                                },
                                child: Container(
                                  width: width * 0.2,
                                  height: width * 0.10,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                    border: Border.all(
                                      color:
                                          provider.selectedColor == Colors.black
                                              ? Colors.black
                                              : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              ...Colors.primaries.map((color) {
                                return GestureDetector(
                                  onTap: () {
                                    if (!provider.isErasing) {
                                      provider.setColor(color); // Update color
                                    }
                                  },
                                  child: Container(
                                    width: width * 0.2,
                                    height: width * 0.10,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color,
                                      border: Border.all(
                                        color: provider.selectedColor == color
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      const Text(
                        'Stroke Width',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      StrokeWidthSlider(
                        onChanged: (value) {
                          provider.setStrokeWidth(value); // Update stroke width
                        },
                        value: provider.selectedStrokeWidth,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: WhiteBoard(
                    controller: provider.controller,
                    backgroundColor: Colors.white,
                    strokeColor: provider.isErasing
                        ? Colors.white
                        : (provider.selectedColor ?? Colors.transparent),
                    strokeWidth: provider.selectedStrokeWidth,
                    isErasing: provider.isErasing,
                    onRedoUndo: (isRedo, isUndo) {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
