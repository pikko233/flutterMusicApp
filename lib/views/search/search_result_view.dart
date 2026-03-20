import 'package:flutter/material.dart';
import 'package:flutter_music_app/constants/app_colors.dart';
import 'package:flutter_music_app/widgets/search_song_cell.dart';
import 'package:get/get.dart';

class SearchResultView extends StatefulWidget {
  const SearchResultView({super.key});

  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView>
    with TickerProviderStateMixin {
  late String _keyword; // 从上个页面带来的搜索参数
  final TextEditingController _searchController =
      TextEditingController(); // 搜索框控制器
  late TabController _tabController;
  var _isPlayingIndex = 0;

  List<Widget> get _tabs {
    return const [
      Tab(text: "歌曲"),
      Tab(text: "歌手"),
      Tab(text: "专辑"),
      Tab(text: "歌单"),
    ];
  }

  List<Widget> get _tabViews {
    return [
      ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return SearchSongCell(
            isPlaying: index == _isPlayingIndex,
            image: "assets/images/ar_2.png",
            title: "晴天",
            subtitle: "周杰伦 • 叶惠美 • 4:23",
            onPressedPlay: () {
              setState(() {
                _isPlayingIndex = index;
              });
            },
            onPressedMore: () {},
          );
        },
      ),
      Center(child: Text("歌手")),
      Center(child: Text("专辑")),
      Center(child: Text("歌单")),
    ];
  }

  // 取消搜索
  void _cancelSearch() {
    _searchController.text = '';
  }

  @override
  void initState() {
    super.initState();
    _keyword = Get.arguments['keyword'] ?? '';
    _searchController.text = _keyword;
    _tabController = TabController(length: _tabs.length, vsync: this);
    print('上一个页面带来的搜索参数: $_keyword');
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            hintText: "想听点啥～",
            hintStyle: TextStyle(color: AppColors.textHint),
            filled: true,
            fillColor: AppColors.bgCard,
            prefixIcon: Icon(Icons.search, color: AppColors.textHint),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _cancelSearch();
              setState(() {});
            },
            child: Text(
              "取消",
              style: TextStyle(color: AppColors.textHint, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kToolbarHeight - 10,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(25),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.textHint,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              tabs: _tabs,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "找到 1,284 首相关歌曲",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: _tabViews),
          ),
        ],
      ),
    );
  }
}
