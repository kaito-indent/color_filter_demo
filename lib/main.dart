import 'package:color_filter_demo/color_selector_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';

const List<Color> _colorList = [
  Color(0xFF414141),
  Color(0xFF746459),
  Color(0xFF7a5c34),
  Color(0xFFceb56d),
  Color(0xFF9a8a70),
  Color(0xFFd1909a),
  Color(0xFFc2c2c2),
  Color(0xFF4f85c3),
];

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImagePickerPage(),
    );
  }
}

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  Image image;
  Color _color = Color(0xFF414141);

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.height * 0.30).roundToDouble();

    return Scaffold(
      appBar: AppBar(
        title: Text("color filter demo"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_browser),
        onPressed: () async {
          final _image = await FlutterWebImagePicker.getImage;
          setState(() {
            image = _image;
          });
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: size,
            child: image != null
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      _color,
                      BlendMode.modulate,
                    ),
                    child: image)
                : Center(
                    child: Text(
                      'No data...',
                    ),
                  ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: ColorSelectorField(
            color: _color,
            colorList: _colorList,
            colorChange: _onColorChange,
          )))
        ],
      ),
    );
  }

  _onColorChange(Color color) {
    setState(() => _color = color);
  }
}
