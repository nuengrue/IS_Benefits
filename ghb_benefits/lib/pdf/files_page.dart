import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FilesPage extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenFile;
  

  const FilesPage({Key? key,
  required this.files,
  required this.onOpenFile, 
  }) : super(key: key);

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
     title: Text('All File'),
      centerTitle: true,
      ),
      body: Center(
        child: GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ), 
          itemCount: widget.files.length,
          itemBuilder: (context,index)
          {
            final file = widget.files[index];

            return buildFile(file);

          },
          ),
      ),
    );

Widget buildFile(PlatformFile file){
  final kb = file.size / 1024;
  final mb = kb / 1024;
  final fileSize = 
  mb>=1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toString()}';
  final extension = file.extension ?? 'none';
  //final Color = getColor(extension);

return InkWell(
  onTap:  () => widget.onOpenFile(file),
  child: Container(
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '.$extension',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ),
        const SizedBox(height: 8),
        Text(
          file.name,
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        Text(fileSize,
        style: TextStyle(fontSize: 16),),
      ],
    ),
  ),

);
}
}