
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'files_page.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('File Picker'),
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: 400),
        padding: EdgeInsets.all(32),
        alignment: Alignment.center,
        child: ElevatedButton(
          child: Text('Pick File'),
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['pdf','jpeg','jpg'],
            );
            if (result == null) return;

            //open
          //  final file = result.files.first;
            openFiles(context, result.files);
/*
            print('Name: ${file.name}');
                        print('Bytes: ${file.bytes}');
                                    print('Size: ${file.size}');
                                                print('Extension: ${file.extension}');
                                                            print('Path: ${file.path}');

            final newFile  = await saveFilePermanently(file);
            print('From Path: ${file.path!}');
                        print('To Path: ${newFile.path!}');

                        */
            
          },
        ),
      ),
    );

      void openFiles(context , List<PlatformFile> files) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FilesPage(
        files:files,
        onOpenFile : openFile,
        ),
        ));
      void openFile(PlatformFile file) {
  OpenFile.open(file.path!);
}
   /*  Future<File> saveFilePermanently(PlatformFile file) async
    {
      final appStorage = await getApplicationDocumentsDirectory();
      final newFile = File('${appStorage.path}/${file.name}');
       var path;
       return File(file.path!).copy(newFile.path);
    }*/
 
  }

  
 

