// ignore_for_file: avoid_single_cascade_in_expression_statements, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tomiwa_project/constant/Colors.dart';

import '../NetworkPage/link.dart';

class FileUploadForm extends StatefulWidget {
  const FileUploadForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FileUploadFormState createState() => _FileUploadFormState();
}

class _FileUploadFormState extends State<FileUploadForm> {
  GlobalKey<FormState> formstate = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  String? _filePath;
  bool isloading = false;
  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    }
  }

  String? selectedCategory;
  List categoryList = [];

  Future getCategory() async {
    var uri = Uri.parse(linkgetCategory);
    var response = await http.get(
      uri,
      headers: {"Accept": "application/json"},
    );
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      categoryList = jsonData;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  Future<void> _submitForm() async {
    if (_filePath == null) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        desc: "File and Category Cant be Empty",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            width: 120,
            child: const Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }
    setState(() {
      isloading = false;
    });
    if (_filePath != null) {
      final title = _titleController.text;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(linkaddBook),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'book',
          _filePath!,
        ),
      );

      request.fields['title'] = title;
      request.fields['category'] = selectedCategory!;
      setState(() {
        isloading = true; // Set isLoading to true when submitting.
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "SUCCESS",
          desc: "File Upload Successfully",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "COOL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      } else {
        print('Upload failed with status: ${response.statusCode}');
        setState(() {
          isloading = false; // Set isLoading to false after submitting.
        });
      }
      setState(() {
        isloading = false; // Set isLoading to false after submitting.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myPurple,
        title: const Text('Add Textbook'),
      ),
      body: Form(
        key: formstate,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              titleForm(),
              const SizedBox(height: 20),
              selectCat(),
              ElevatedButton(
                onPressed: _pickPDF,
                child: const Text('Pick PDF File'),
              ),
              Text(_filePath ?? 'No file selected'),
              submitIt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitIt() {
    return InkWell(
      onTap: () {
        if (formstate.currentState!.validate()) {
          isloading = true;
          setState(() {});
          _submitForm();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: myPink, borderRadius: BorderRadius.circular(20)),
        child: isloading
            ? const CircularProgressIndicator()
            : const Text(
                " Add Book",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget selectCat() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0.5)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: DropdownButton(
        value: selectedCategory,
        isExpanded: true,
        hint: const Text("Select the Category"),
        items: categoryList.map((list) {
          return DropdownMenuItem(
            value: list['id'],
            child: Text(list['category']),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCategory = value as String?;
          });
        },
      ),
    );
  }

  Widget titleForm() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Title cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Title"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Title",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      controller: _titleController,
    );
  }
}
