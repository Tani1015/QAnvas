import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spring_button/spring_button.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddQuestionNoteScreen extends StatefulHookConsumerWidget {
  const AddQuestionNoteScreen({Key? key}) : super(key: key);

  @override
  AddQuestionNoteState createState() => AddQuestionNoteState();
}

class AddQuestionNoteState extends ConsumerState<AddQuestionNoteScreen> with SingleTickerProviderStateMixin{
  //ぺインター設定
  static const Color black = Colors.black;
  FocusNode textFocusNode = FocusNode();
  Paint shapePaint = Paint()
    ..strokeWidth = 2
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  late PainterController controller;

  void onFocus() {
    setState(() {});
  }

  //factory of bottomnavigation icon
  static IconData getShapeIcon(ShapeFactory? shapeFactory) {
    if (shapeFactory is LineFactory) return PhosphorIcons.lineSegment;
    if (shapeFactory is ArrowFactory) return PhosphorIcons.arrowUpRight;
    if (shapeFactory is DoubleArrowFactory) {
      return PhosphorIcons.arrowsHorizontal;
    }
    if (shapeFactory is RectangleFactory) return PhosphorIcons.rectangle;
    if (shapeFactory is OvalFactory) return PhosphorIcons.circle;
    return PhosphorIcons.polygon;
  }

  @override
  void initState() {
    super.initState();
    controller = PainterController(
        settings: PainterSettings(

          //テキスト設定
            text: TextSettings(
                focusNode: textFocusNode,
                textStyle: const TextStyle(color: Colors.black, fontSize: 16)),

            //freestyle 設定
            freeStyle:
            const FreeStyleSettings(color: Colors.black, strokeWidth: 2),

            //ペイント設定
            shape: ShapeSettings(paint: shapePaint),

            //scale 設定
            scale: const ScaleSettings(
              enabled: true,
              minScale: 1,
              maxScale: 5,
            )));
    textFocusNode.addListener(onFocus);
  }

  @override
  Widget build(BuildContext context) {


    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textheight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
        child: AppBar(
          title: SizedBox(
            width: weight * 0.4,
            height: height * 0.07,
            child: Image.asset("assets/images/QAnvas_title.png"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          actions: [
            SizedBox(
              width: weight * 0.25,
              child: SpringButton(
                SpringButtonType.WithOpacity,
                Padding(
                  padding: const EdgeInsets.all(12.5),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: const Center(
                      child: Text(
                        '投稿する',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  context.go("投稿する");
                },
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: textheight),
          child: Column(
              children: <Widget>[
                ValueListenableBuilder<PainterControllerValue>(
                    valueListenable: controller,
                    builder: (context, _, child) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height: height * 0.1,
                                width: weight * 0.2,
                                child: IconButton(
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  onPressed: () {
                                    controller.selectedObjectDrawable == null
                                        ? null
                                        : removeSelectedDrawable();
                                  },
                                  icon: const Icon(Icons.delete),
                                )),
                            SizedBox(
                                height: height * 0.1,
                                width: weight * 0.2,
                                child: IconButton(
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  tooltip: "画像反転",
                                  onPressed: () {
                                    controller.selectedObjectDrawable != null &&
                                        controller.selectedObjectDrawable
                                        is ImageDrawable
                                        ? flipSelectedImageDrawable()
                                        : null;
                                  },
                                  icon: const Icon(Icons.flip),
                                )),
                            SizedBox(
                                height: height * 0.1,
                                width: weight * 0.2,
                                child: IconButton(
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  onPressed: controller.canUndo ? undo : null,
                                  icon: const Icon(Icons.undo),
                                )),
                            SizedBox(
                                height: height * 0.1,
                                width: weight * 0.2,
                                child: IconButton(
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  onPressed: controller.canRedo ? redo : null,
                                  icon: const Icon(Icons.redo),
                                ))
                          ]);
                    }),
                Center(
                    child: Container(
                      color: Colors.grey.shade200,
                      width: weight,
                      height: height * 0.7 - textheight * 0.8,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          FlutterPainter(
                              controller: controller
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: ValueListenableBuilder(
                              valueListenable: controller,
                              builder: (context, _ , __) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 400,
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.vertical(top: Radius.circular(20)),
                                        color: Colors.white54,
                                      ),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (controller.freeStyleMode != FreeStyleMode.none) ...[
                                              // Control free style stroke width
                                              Row(
                                                children: [
                                                  const Expanded(flex: 1, child: Text("太さ")),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Slider.adaptive(
                                                        min: 2,
                                                        max: 25,
                                                        value: controller.freeStyleStrokeWidth,
                                                        onChanged: setFreeStyleStrokeWidth),
                                                  ),
                                                ],
                                              ),
                                              if (controller.freeStyleMode == FreeStyleMode.draw)

                                                Row(
                                                  children: [
                                                    const Expanded(
                                                        flex: 1, child: Text("色")),
                                                    // Control free style color hue
                                                    Expanded(
                                                      flex: 8,
                                                      child: Slider.adaptive(
                                                          min: 0,
                                                          max: 359.99,
                                                          value: HSVColor.fromColor(controller.freeStyleColor).hue,
                                                          activeColor: controller.freeStyleColor, onChanged: setFreeStyleColor),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                            if (textFocusNode.hasFocus) ...[
                                              Row(
                                                children: [
                                                  const Expanded(
                                                      flex: 2, child: Text("サイズ")),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Slider.adaptive(
                                                        min: 8,
                                                        max: 96,
                                                        value:
                                                        controller.textStyle.fontSize ?? 14,
                                                        onChanged: setTextFontSize),
                                                  ),
                                                ],
                                              ),
                                              // Control text color hue
                                              Row(
                                                children: [
                                                  const Expanded(flex: 2, child: Text("色")),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Slider.adaptive(
                                                        min: 0,
                                                        max: 359.99,
                                                        value: HSVColor.fromColor(
                                                            controller.textStyle.color ?? black).hue,
                                                        activeColor: controller.textStyle.color,
                                                        onChanged: setTextColor),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            if (controller.shapeFactory != null) ...[
                                              const Text(""),
                                              // Control text color hue
                                              Row(
                                                children: [
                                                  const Expanded(
                                                      flex: 1, child: Text("太さ")),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Slider.adaptive(
                                                        min: 2,
                                                        max: 25,
                                                        value: controller
                                                            .shapePaint?.strokeWidth ??
                                                            shapePaint.strokeWidth,
                                                        onChanged: (value) => setShapeFactoryPaint(
                                                            (controller.shapePaint ?? shapePaint).copyWith(strokeWidth: value,))
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Control shape color hue
                                              Row(
                                                children: [
                                                  const Expanded(flex: 1, child: Text("色")),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Slider.adaptive(
                                                        min: 0,
                                                        max: 360,
                                                        value: HSVColor.fromColor(
                                                            (controller.shapePaint ?? shapePaint).color).hue,
                                                        activeColor: (controller.shapePaint ?? shapePaint).color,
                                                        onChanged: (hue) =>
                                                            setShapeFactoryPaint((controller.shapePaint
                                                                ?? shapePaint).copyWith(color: HSVColor.fromAHSV(1, hue, 1, 1).toColor(),))
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Expanded(
                                                      flex: 1, child: Text("塗る")),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Center(
                                                      child: Switch(
                                                          value: (controller.shapePaint ?? shapePaint).style == PaintingStyle.fill,
                                                          onChanged: (value) =>
                                                              setShapeFactoryPaint(
                                                                  (controller.shapePaint ?? shapePaint).copyWith(
                                                                    style: value
                                                                        ? PaintingStyle.fill
                                                                        : PaintingStyle.stroke,
                                                                  )
                                                              )
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ]
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),
              ]
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, _, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Free-style eraser
            IconButton(
              icon: Icon(
                Icons.auto_fix_high,
                color: controller.freeStyleMode == FreeStyleMode.erase
                    ? Colors.red
                    : null,
              ),
              onPressed: toggleFreeStyleErase,
            ),
            // Free-style drawing
            IconButton(
              icon: Icon(
                Icons.brush,
                color: controller.freeStyleMode == FreeStyleMode.draw
                    ? Colors.red
                    : null,
              ),
              onPressed: toggleFreeStyleDraw,
            ),
            // Add text
            IconButton(
              icon: Icon(
                Icons.title,
                color: textFocusNode.hasFocus
                    ? Colors.red
                    : null,
              ),
              onPressed: addText,
            ),
            // Add sticker image
            IconButton(
              icon: const Icon(
                Icons.image,
              ),
              onPressed: (){print("image");},
            ),
            // Add shapes
            if (controller.shapeFactory == null)
              PopupMenuButton<ShapeFactory?>(
                tooltip: "Add shape",
                itemBuilder: (context) => <ShapeFactory, String>{
                  LineFactory(): "直線",
                  ArrowFactory(): "関数線",
                  DoubleArrowFactory(): "両矢印",
                  RectangleFactory(): "四角形",
                  OvalFactory(): "円形",
                }
                    .entries
                    .map((e) => PopupMenuItem(
                    value: e.key,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          getShapeIcon(e.key),
                          color: Colors.black,
                        ),
                        Text(" ${e.value}")
                      ],
                    )))
                    .toList(),
                onSelected: selectShape,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    getShapeIcon(controller.shapeFactory),
                    color: controller.shapeFactory != null
                        ? Colors.red
                        : null,
                  ),
                ),
              )
            else
              IconButton(
                icon: Icon(
                  getShapeIcon(controller.shapeFactory),
                  color: Colors.red,
                ),
                onPressed: () => selectShape(null),
              ),
          ],
        ),
      ),
    );
  }

  void undo() {
    controller.undo();
  }

  void redo() {
    controller.redo();
  }

  void toggleFreeStyleDraw() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.draw
        ? FreeStyleMode.draw
        : FreeStyleMode.none;
  }

  void toggleFreeStyleErase() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.erase
        ? FreeStyleMode.erase
        : FreeStyleMode.none;
  }

  void addText() {
    if (controller.freeStyleMode != FreeStyleMode.none) {
      controller.freeStyleMode = FreeStyleMode.none;
    }
    controller.addText();
  }

  void setFreeStyleStrokeWidth(double value) {
    controller.freeStyleStrokeWidth = value;
  }

  void setFreeStyleColor(double hue) {
    controller.freeStyleColor = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
  }

  void setTextFontSize(double size) {
    // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
    setState(() {
      controller.textSettings = controller.textSettings.copyWith(
          textStyle:
          controller.textSettings.textStyle.copyWith(fontSize: size));
    });
  }

  void setShapeFactoryPaint(Paint paint) {
    // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
    setState(() {
      controller.shapePaint = paint;
    });
  }

  void setTextColor(double hue) {
    controller.textStyle = controller.textStyle
        .copyWith(color: HSVColor.fromAHSV(1, hue, 1, 1).toColor());
  }

  void selectShape(ShapeFactory? factory) {
    controller.shapeFactory = factory;
  }

  void removeSelectedDrawable() {
    final selectedDrawable = controller.selectedObjectDrawable;
    if (selectedDrawable != null) controller.removeDrawable(selectedDrawable);
  }

  void flipSelectedImageDrawable() {
    final imageDrawable = controller.selectedObjectDrawable;
    if (imageDrawable is! ImageDrawable) return;

    controller.replaceDrawable(
        imageDrawable, imageDrawable.copyWith(flipped: !imageDrawable.flipped));
  }
}
