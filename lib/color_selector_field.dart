import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


enum ColorType { red, green, blue }

class ColorSelectorField extends StatelessWidget {
  final Color color;
  final List<Color> colorList;
  final Function colorChange;

  const ColorSelectorField({
    Key key,
    this.color,
    this.colorList,
    this.colorChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          _buildFixedColorSelector(context),
          const SizedBox(height: 10.0),
          _buildFreeColorMaker(),
        ],
      ),
    );
  }

  Widget _buildFixedColorSelector(BuildContext context) {
    return Row(
      children: [
        for (var color in colorList)
          _buildColorContainer(
            color,
            colorChange,
            context,
          ),
      ],
    );
  }

  Widget _buildColorContainer(Color color, Function colorChange, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: this.color == color ? Colors.blue : Colors.black12,
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            colorChange(color);
          },
          child: Container(
            width: 25,
            height: 25,
          ),
        ),
      ),
    );
  }

  Widget _buildFreeColorMaker() {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 6.0),
            ColorPicker(
              colorPickerWidth: 400,
              showLabel: false,
              enableAlpha: false,
              pickerColor: color,
              onColorChanged: colorChange,
              pickerAreaHeightPercent: 0.45,
              pickerAreaBorderRadius: BorderRadius.circular(10.0),
            ),
            _buildColorSlider(color, ColorType.red, colorChange),
            _buildColorSlider(color, ColorType.green, colorChange),
            _buildColorSlider(color, ColorType.blue, colorChange),
          ],
        ),
      ],
    );
  }

  Widget _buildColorSlider(Color color, ColorType type, Function colorChange) {
    String colorName;
    double colorValue;
    Color sliderColor;
    Function onChanged;
    Function onPlusPress;
    Function onMinusPress;
    switch (type) {
      case ColorType.red:
        colorName = "R";
        colorValue = color.red.toDouble();
        sliderColor = Colors.red;
        onChanged = (double value) {
          Color tempColor = color.withRed(value.toInt());
          colorChange(tempColor);
        };
        onPlusPress = () {
          if (color.red < 255) {
            Color tempColor = color.withRed(color.red + 1);
            colorChange(tempColor);
          }
        };
        onMinusPress = () {
          if (color.red > 0) {
            Color tempColor = color.withRed(color.red - 1);
            colorChange(tempColor);
          }
        };
        break;
      case ColorType.green:
        colorName = "G";
        colorValue = color.green.toDouble();
        sliderColor = Colors.green;
        onChanged = (double value) {
          Color tempColor = color.withGreen(value.toInt());
          colorChange(tempColor);
        };
        onPlusPress = () {
          if (color.green < 255) {
            Color tempColor = color.withGreen(color.green + 1);
            colorChange(tempColor);
          }
        };
        onMinusPress = () {
          if (color.green > 0) {
            Color tempColor = color.withGreen(color.green - 1);
            colorChange(tempColor);
          }
        };
        break;
      case ColorType.blue:
        colorName = "B";
        colorValue = color.blue.toDouble();
        sliderColor = Colors.blue;
        onChanged = (double value) {
          Color tempColor = color.withBlue(value.toInt());
          colorChange(tempColor);
        };
        onPlusPress = () {
          if (color.blue < 255) {
            Color tempColor = color.withBlue(color.blue + 1);
            colorChange(tempColor);
          }
        };
        onMinusPress = () {
          if (color.blue > 0) {
            Color tempColor = color.withBlue(color.blue - 1);
            colorChange(tempColor);
          }
        };
        break;
      default:
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        children: [
          Text(
            colorName,
            style: TextStyle(color: sliderColor),
          ),
          IconButton(
            icon: Icon(Icons.remove, color: sliderColor),
            onPressed: onMinusPress,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackShape: _CustomTrackShape(),
              ),
              child: Slider(
                activeColor: sliderColor,
                value: colorValue.toDouble(),
                onChanged: onChanged,
                min: 0,
                max: 255,
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.add, color: sliderColor),
            onPressed: onPlusPress,
          ),
          SizedBox(
            width: 25,
            child: FittedBox(
              child: Text(
                colorValue.toInt().toString().padLeft(3),
                style: TextStyle(color: sliderColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
