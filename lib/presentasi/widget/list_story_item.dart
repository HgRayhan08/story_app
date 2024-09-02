import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_app/presentasi/router/router_provider.dart';

class ListStoryItem extends ConsumerStatefulWidget {
  final String id;
  final String name;
  final String photoUrl;
  final String createdAt;
  final String description;
  final double height;
  final double width;

  const ListStoryItem(
      {super.key,
      required this.id,
      required this.name,
      required this.photoUrl,
      required this.createdAt,
      required this.description,
      required this.height,
      required this.width});

  @override
  ConsumerState<ListStoryItem> createState() => _ListStoryItemState();
}

class _ListStoryItemState extends ConsumerState<ListStoryItem> {
  bool animated = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        animated = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(animated ? 0 : -100, 0, 0),
      child: GestureDetector(
        onTap: () {
          ref.read(routerProvider).pushNamed(
                "Detail",
                extra: widget.id,
              );
        },
        child: Container(
          margin: EdgeInsets.only(
              bottom: widget.height * 0.02,
              left: widget.width * 0.05,
              right: widget.width * 0.05),
          decoration: const BoxDecoration(
            color: Color(0xffEEEEEE),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.photoUrl,
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height * 0.2,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widget.width * 0.02,
                  right: widget.width * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        widget.createdAt.toString(),
                      ),
                    ),
                    Text(widget.description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
