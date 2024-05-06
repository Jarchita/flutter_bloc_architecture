part of notification_screen;


/// Purpose : main notification list
class NotificationListView extends StatefulWidget {
  const NotificationListView(this.t, {Key? key}) : super(key: key);
  final AppLocalizations? t;
  @override
  _NotificationListViewState createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView>
    with UtilityMixin {
  final list = <String>[];

  int totalCount = 0;
  int skipCount = 0;

  late NotificationBloc _bloc;

  final RefreshController _refreshController = RefreshController();

  void _reset() {
    list.clear();
    totalCount = 0;
    skipCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<NotificationBloc>(context);
    return BlocListener<NotificationBloc, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          if (state.isRefresh) {
            _reset();
          }
        }
        if (state is SuccessState ||
            state is ConnectionFailedState ||
            state is FailedState) {
          _refreshController
            ..loadComplete()
            ..refreshCompleted();
        }
      },
      child: BlocBuilder<NotificationBloc, BaseState>(
        builder: (context, state) {
          if (state is SuccessState) {
            if (state.data.items is List<String>) {
              if (!listEquals(list, state.data.items)) {
                list.addAll(state.data.items);
              }
              final int itemLength = state.data.items.length;
              totalCount = state.data.totalCount;
              if (list.length < totalCount) {
                skipCount = skipCount + itemLength;
              } else {
                _refreshController.loadNoData();
              }
            }
          }

          var isLoading = false;
          if (state is LoadingState) {
            isLoading = state.isLoading;
          }
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: list.isNotEmpty ? 70 : 0),
                  child: SmartRefresher(
                    enablePullUp: list.isNotEmpty,
                    controller: _refreshController,
                    onLoading: () {
                      _bloc.add(GetListEvent(
                          skipCount: skipCount,
                          maxResultCount: NumericConstants.listMaxResultCount));
                    },
                    onRefresh: () {
                      _bloc.add(const GetListEvent(
                          isRefresh: true,
                          skipCount: 0,
                          maxResultCount: NumericConstants.listMaxResultCount));
                    },
                    footer: CustomLoader.footer(),
                    child: !isLoading && list.isEmpty
                        ? _placeholder(context)
                        : _listView(),
                  ),
                ),
                if (list.isNotEmpty)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: InkWell(
                          onTap: _onTapClear,
                          child: Text(widget.t?.lblClearAll ?? ""),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _onTapClear() async {
    _bloc.add(const ClearNotificationEvent());
  }

  Widget _listView() =>Container();/* GroupedListView<NotificationItem, String>(
        elements: list,
        groupBy: (element) => getSimpleDate(element.creationTime!),
        // groupComparator: (value1, value2) => value2.compareTo(value1),
        // itemComparator: (item1, item2) => getFormattedDate(
        //         convertUtcToLocal(item1.creationTime!),
        //         format: DateFormats.ddMYyyy)
        //     .compareTo(getFormattedDate(convertUtcToLocal(item2.creationTime!),
        //         format: DateFormats.ddMYyyy)),
        order: GroupedListOrder.DESC,
        padding: const EdgeInsets.all(
          AppStyles.pageSideMargin,
        ),
        groupSeparatorBuilder: (value) => Padding(
          padding: EdgeInsets.only(bottom: 10, top: isToday(value) ? 0 : 25),
          child: Text(
            isToday(value)
                ? (widget.t?.lblToday ?? "")
                : getFormattedDate(convertUtcToLocal(value),
                    format: DateFormats.ddMYyyy),
            style: const TextStyle(
              color: AppColors.secondary,
              fontSize: 13,
              fontWeight: AppFonts.semiBold,
            ),
          ),
        ),
        itemBuilder: (context, element) => Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          // padding: const EdgeInsets.only(bottom: 25),
          child: Text(
            element.message ?? "",
            style: TextStyle(
              color: isToday(element.creationTime!)
                  ? AppColors.primary
                  : AppColors.secondary,
              fontSize: 14,
              fontWeight: AppFonts.semiBold,
            ),
          ),
        ),
      );
*/
  Widget _placeholder(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: Center(
          child: Text(
            widget.t?.lblPlaceholderNotification ?? "",
            style: AppStyles.commonSecondaryTextStyle,
          ),
        ),
      );
}
