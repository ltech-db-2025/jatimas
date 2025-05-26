// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant/app_color.dart';
import '../../core/model/Search.dart';
import '../../core/services/SearchService.dart';
import '../../views/screens/search_result_page.dart';
import '../../views/widgets/popular_search_card.dart';
import '../../views/widgets/search_history_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchHistory> listSearchHistory = SearchService.listSearchHistory;
  List<PopularSearch> listPopularSearch = SearchService.listPopularSearch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: AppColor.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            'assets/icons/Arrow-left.svg',
            color: Colors.white,
          ),
        ),
        title: SizedBox(
          height: 40,
          child: TextField(
            autofocus: false,
            style: const TextStyle(fontSize: 14, color: Colors.white),
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.3)),
              hintText: 'Find a products...',
              prefixIcon: Container(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset('assets/icons/search.svg', color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              fillColor: Colors.white.withValues(alpha: 0.1),
              filled: true,
            ),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          // Section 1 - Search History
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Search history...',
                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listSearchHistory.length,
                itemBuilder: (context, index) {
                  return SearchHistoryTile(
                    data: listSearchHistory[index],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SearchResultPage(
                            searchKeyword: listSearchHistory[index].title,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColor.primary.withValues(alpha: 0.3),
                    backgroundColor: AppColor.primarySoft,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  ),
                  child: Text(
                    'Delete search history',
                    style: TextStyle(color: AppColor.secondary.withValues(alpha: 0.5)),
                  ),
                ),
              ),
            ],
          ),
          // Section 2 - Popular Search
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Popular search.',
                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                children: List.generate(listPopularSearch.length, (index) {
                  return PopularSearchCard(
                    data: listPopularSearch[index],
                    onTap: () {},
                  );
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
