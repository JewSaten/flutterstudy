import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

const String viewType = 'platform-view';
const Map<String, dynamic> creationParams = <String, dynamic>{};

void main() => runApp(const MaterialApp(
      home: MixModeViewPage(),
    ));


abstract class NativeViewPage extends StatelessWidget{

  const NativeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 80),
            child: buildNativeView(),
          )) ,
    );
  }

  Widget buildNativeView();
  String getTitle();
}

class MixModeViewPage extends NativeViewPage {
  const MixModeViewPage({super.key});

  @override
  Widget buildNativeView() {
    return PlatformViewLink(
        surfaceFactory: (context, controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <
                Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener(
                params.onPlatformViewCreated)
            ..create();
        },
        viewType: viewType);
  }

  @override
  String getTitle() => 'PlatformViewLink';
}

class VirtualDisplayViewPage extends NativeViewPage {
  const VirtualDisplayViewPage({super.key});

  @override
  Widget buildNativeView() {
    return const AndroidView(
     viewType: viewType,
     layoutDirection: TextDirection.ltr,
     creationParams: creationParams,
     creationParamsCodec: StandardMessageCodec(),
   );
  }

  @override
  String getTitle() => 'VirtualDisplayView';
}
