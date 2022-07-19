import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:ibtikar_task/shared/components/cached_image.dart';
import 'package:ibtikar_task/shared/components/conditional_builder.dart';

class ImageDownloader extends StatefulWidget {
  const ImageDownloader({
    Key? key,
    required this.imageUrl,
    this.title,
  }) : super(key: key);

  final String? title;
  final String imageUrl;

  @override
  State<ImageDownloader> createState() => _ImageDownloaderState();
}

class _ImageDownloaderState extends State<ImageDownloader> {
  bool isImageDownloaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: widget.imageUrl,
                child: CachedImage(
                  imageUrl: widget.imageUrl,
                  margin: EdgeInsets.zero,
                  radius: 0,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                  ),
                  onPressed: () {
                    if (!isImageDownloaded) {
                      _saveNetworkImage();
                    }
                  },
                  child: ConditionalBuilder(
                    condition: isImageDownloaded,
                    builder: (context) => const Icon(
                      Icons.done,
                    ),
                    fallback: (context) => const Text(
                      'Download',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveNetworkImage() async {
    if (!isImageDownloaded) {
      GallerySaver.saveImage(widget.imageUrl).then(
        (value) => setState(() => isImageDownloaded = true),
      );
    }
  }
}
