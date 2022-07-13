import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/components.dart';
import 'package:newsapp/modules/news_app/search_screen.dart';
import 'package:newsapp/news_app/cubit/cubit.dart';
import 'package:newsapp/news_app/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            title: const Text(
              'Garyedgit ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            actions: [
              IconButton(
                icon:  const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
              ),
            ],
          ),
          body: Row(
            children: <Widget>[
              NavigationRail(
                indicatorColor: Colors.deepOrange,
                selectedIndex: cubit.currentIndex,
                onDestinationSelected: (int index) {
                  cubit.changeNavRail(index);
                },
                labelType: NavigationRailLabelType.selected,
                destinations: cubit.railItem
              ),
              const VerticalDivider(thickness: 2, width: 1),
              Expanded(child: cubit.screens[cubit.currentIndex])
            ],
          ),

        );
      },
    );
  }
}
