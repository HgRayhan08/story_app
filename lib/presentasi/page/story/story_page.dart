import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_app/domain/model/all_story.dart';
import 'package:story_app/domain/usecase/get_all_story/get_all_story_usecase.dart';
import 'package:story_app/presentasi/provider/usecase/get_all_story.dart';
import 'package:story_app/presentasi/router/router_provider.dart';

class StoryPage extends ConsumerStatefulWidget {
  const StoryPage({super.key});

  @override
  ConsumerState<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends ConsumerState<StoryPage> {
  final ScrollController _scrollController = ScrollController();
  List<ListStory> _stories = [];
  bool _isLoading = false;
  int _page = 0;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _loadStories();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _loadStories();
    }
  }

  Future<void> _loadStories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      GetAllStoryUsecase story = ref.read(getAllStoryUsecaseProvider);
      var result = await story(_page);

      if (result.error != true) {
        setState(() {
          _stories.addAll(result.listStory);
          _page++;
        });
      } else {
        throw Exception("Error fetching stories");
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _stories.isEmpty && _isLoading
          ? const Center(child: Text("data"))
          : ListView.builder(
              controller: _scrollController,
              itemCount: _stories.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _stories.length) {
                  if (index == _stories.length && _stories != null) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      ref.read(routerProvider).pushNamed(
                            "Detail",
                            extra: _stories[index].id,
                          );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: height * 0.02,
                          left: width * 0.05,
                          right: width * 0.05),
                      decoration: const BoxDecoration(
                        color: Color(0xffEEEEEE),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            _stories[index].photoUrl,
                            fit: BoxFit.cover,
                            width: width,
                            height: height * 0.2,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.02,
                              right: width * 0.05,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_stories[index].name),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    _stories[index].createdAt.toString(),
                                  ),
                                ),
                                Text(_stories[index].description),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
