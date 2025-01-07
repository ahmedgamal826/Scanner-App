import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  TextCard({
    super.key,
    required this.onTap,
    required this.deleteFun,
    required this.btnOkOnPress,
    required this.fileName,
  });

  void Function()? onTap;
  void Function()? deleteFun;
  void Function()? btnOkOnPress;
  String fileName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.text_snippet,
              size: 70,
              color: Colors.orange,
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                fileName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.orange,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.share,
                    color: Colors.orange,
                  ),
                  onPressed: deleteFun,
                  // onPressed: () async {
                  //   String filePath = _textFiles[index].path;
                  //   XFile file = XFile(filePath);
                  //   await Share.shareXFiles([file],
                  //       text: 'Check out this file!');
                  // },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.scale,
                      title: 'Delete File',
                      titleTextStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      descTextStyle: TextStyle(fontSize: 18),
                      desc: 'Are you sure you want to delete this file?',
                      btnCancelOnPress: () {},
                      btnOkOnPress: btnOkOnPress,
                      btnOkColor: Colors.green,
                    ).show();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
