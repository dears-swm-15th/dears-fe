import 'dart:typed_data';

class ImageData {
  final String name;

  // TODO: handle case where images are too large to be held in memory
  final Uint8List data;

  const ImageData(this.name, this.data);
}
