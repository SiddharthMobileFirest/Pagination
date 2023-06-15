import 'package:bloc_project_using_event/model/data_model.dart';
import 'package:bloc_project_using_event/screens/home_page/bloc/data_bloc.dart';
import 'package:bloc_project_using_event/screens/home_page/bloc/data_event.dart';
import 'package:bloc_project_using_event/screens/home_page/bloc/data_state.dart';
import 'package:bloc_project_using_event/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Utils utils = Utils();
  final scrollController = ScrollController();
  List<Datum> oldData = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DataBloc>(context).add(const DataEvent([], true));
  }

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<DataBloc>(context).add(DataEvent(oldData, false));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    ScreenUtil.init(context, designSize: Size(width, height));
    setupScrollController(context);
    return Scaffold(
      body: BlocConsumer<DataBloc, DataState>(
        listener: (context, state) {
          if (state is DataErrorState) {
            utils.showTostMessage(
                context: context, message: state.errorMessage, isError: true);
          }
        },
        builder: (context, state) {
          if (state is DataLoadingState && state.isFirstFetch) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Datum> data = [];
          bool isloading = false;
          if (state is DataLoadingState) {
            data = state.oldData;
            isloading = true;
          }
          if (state is DataLoadedState) {
            data = state.data;
            oldData = data;
          }
          return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index < data.length) {
                  return Card(
                      child: Center(
                          child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.06.sh),
                    child: Text(data[index].firstName),
                  )));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: data.length + (isloading ? 1 : 0));
        },
      ),
    );
  }
}
