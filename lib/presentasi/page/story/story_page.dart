import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_app/presentasi/provider/story/story_all_list.dart';
import 'package:story_app/presentasi/router/router_provider.dart';
import 'package:story_app/presentasi/widget/list_story_item.dart';

class StoryPage extends ConsumerStatefulWidget {
  const StoryPage({super.key});

  @override
  ConsumerState<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends ConsumerState<StoryPage> {
  late EasyRefreshController _refreshController;
  final ScrollController _scrollController = ScrollController();

  var page = 1;

  @override
  void initState() {
    _refreshController = EasyRefreshController();
    Future.microtask(() => ref.read(storyProvider).getAllStory(reset: true));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if (ref.read(storyProvider).isEndPage == false &&
            ref.read(storyProvider).listStoryLoading == false) {
          ref.read(storyProvider).getAllStory(page: page + 1);
          setState(() {
            page++;
          });
        }
      }
    });

    super.initState();
  }

  Future _onRefresh() async {
    setState(() {
      page = 1;
    });
    await ref.read(storyProvider).getAllStory(reset: true);
    if (!mounted) {
      return;
    }

    _refreshController.finishRefresh(IndicatorResult.success, true);

    return;
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storyRef = ref.watch(storyProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "Create",
        onPressed: () async {
          await ref.read(routerProvider).pushNamed("Create");
          _onRefresh();
        },
        child: const Icon(Icons.add),
      ),
      body: EasyRefresh(
        controller: _refreshController,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: storyRef.listStory.listStory!.isEmpty &&
                  !storyRef.listStoryLoading &&
                  !storyRef.listStoryError
              ? const Center(
                  child: Text('No Data'),
                )
              : storyRef.listStoryError
                  ? const Center(child: Text('Database Error!!!'))
                  : Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: storyRef.listStory.listStory!.length,
                          itemBuilder: (context, index) {
                            return ListStoryItem(
                              width: width,
                              height: height,
                              key: ValueKey(
                                  storyRef.listStory.listStory![index]!.id),
                              id: storyRef.listStory.listStory![index]!.id,
                              createdAt: storyRef
                                  .listStory.listStory![index]!.createdAt,
                              description: storyRef
                                  .listStory.listStory![index]!.description,
                              name: storyRef.listStory.listStory![index]!.name,
                              photoUrl: storyRef
                                  .listStory.listStory![index]!.photoUrl,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        ref.watch(storyProvider).listStoryLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ref.watch(storyProvider).isEndPage
                                ? const Center(
                                    child: Text("No Data Found"),
                                  )
                                : const SizedBox(height: 0)
                      ],
                    ),
        ),
      ),
    );
  }
}
