import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:ccis_dms/app_router.dart';
import 'package:ccis_dms/constants/dimens.dart';
import 'package:ccis_dms/generated/l10n.dart';
import 'package:ccis_dms/theme/theme_extensions/app_button_theme.dart';
import 'package:ccis_dms/theme/theme_extensions/app_data_table_theme.dart';
import 'package:ccis_dms/views/widgets/card_elements.dart';
import 'package:ccis_dms/views/widgets/portal_master_layout/portal_master_layout.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormBuilderState>();

  late DataSource _dataSource;

  @override
  void initState() {
    super.initState();

    _dataSource = DataSource(
      onDetailButtonPressed: (data) =>
          GoRouter.of(context).go('${RouteUri.taskDetail}?id=${data['id']}'),
      onDeleteButtonPressed: (data) {},
      onStatusButtonPressed: (data) =>
          GoRouter.of(context).go('${RouteUri.taskStatus}?id=${data['id']}'),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;

    return PortalMasterLayout(
      body: ListView(
        padding: const EdgeInsets.all(kDefaultPadding),
        children: [
          Text(
            'TASK',
            style: themeData.textTheme.headline4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CardHeader(
                    title: '',
                  ),
                  CardBody(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: kDefaultPadding * 2.0),
                          child: FormBuilder(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                direction: Axis.horizontal,
                                spacing: kDefaultPadding,
                                runSpacing: kDefaultPadding,
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 300.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: kDefaultPadding * 1.5),
                                      child: FormBuilderTextField(
                                        name: 'search',
                                        decoration: InputDecoration(
                                          labelText: lang.search,
                                          hintText: lang.search,
                                          border: const OutlineInputBorder(),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: kDefaultPadding),
                                        child: SizedBox(
                                          height: 40.0,
                                          child: ElevatedButton(
                                            style: themeData
                                                .extension<AppButtonTheme>()!
                                                .infoElevated,
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right:
                                                              kDefaultPadding *
                                                                  0.5),
                                                  child: Icon(
                                                    Icons.search,
                                                    size: (themeData.textTheme
                                                            .button!.fontSize! +
                                                        4.0),
                                                  ),
                                                ),
                                                Text(lang.search),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40.0,
                                        child: ElevatedButton(
                                          style: themeData
                                              .extension<AppButtonTheme>()!
                                              .successElevated,
                                          //edit crud-detail for task
                                          onPressed: () => GoRouter.of(context)
                                              .go(RouteUri.taskDetail),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right:
                                                        kDefaultPadding * 0.5),
                                                child: Icon(
                                                  Icons.add,
                                                  size: (themeData.textTheme
                                                          .button!.fontSize! +
                                                      4.0),
                                                ),
                                              ),
                                              //edit this also
                                              Text(lang.crudNew),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final double dataTableWidth =
                                  max(kScreenWidthMd, constraints.maxWidth);

                              return Scrollbar(
                                controller: _scrollController,
                                thumbVisibility: true,
                                trackVisibility: true,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: _scrollController,
                                  child: SizedBox(
                                    width: dataTableWidth,
                                    child: Theme(
                                      data: themeData.copyWith(
                                        cardTheme: appDataTableTheme.cardTheme,
                                        dataTableTheme: appDataTableTheme
                                            .dataTableThemeData,
                                      ),
                                      child: PaginatedDataTable(
                                        source: _dataSource,
                                        rowsPerPage: 20,
                                        showCheckboxColumn: false,
                                        showFirstLastButtons: true,
                                        columns: const [
                                          DataColumn(
                                              label: Text('No.'),
                                              numeric: true),
                                          DataColumn(label: Text('Task Title')),
                                          DataColumn(label: Text('Date Init')),
                                          DataColumn(label: Text('Due Date')),
                                          DataColumn(label: Text('Status')),
                                          DataColumn(label: Text('Actions')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataSource extends DataTableSource {
  final void Function(Map<String, dynamic> data) onDetailButtonPressed;
  final void Function(Map<String, dynamic> data) onDeleteButtonPressed;
  final void Function(Map<String, dynamic> data) onStatusButtonPressed;

  final _data = List.generate(200, (index) {
    //this also
    return {
      'id': index + 1,
      'no': index + 1,
      'task title': 'Task Title ${index + 1}',
      'date init': '2022-08-16',
      'due date': '2022-08-16',
    };
  });

  DataSource({
    required this.onDetailButtonPressed,
    required this.onDeleteButtonPressed,
    required this.onStatusButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    final data = _data[index];

    return DataRow.byIndex(index: index, cells: [
      //this one
      DataCell(Text(data['no'].toString())),
      DataCell(Text(data['task title'].toString())),
      DataCell(Text(data['date init'].toString())),
      DataCell(Text(data['due date'].toString())),

      // edit the text for this one
      // add form for the status
      DataCell(Builder(
        builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: OutlinedButton(
                  onPressed: () => onStatusButtonPressed.call(data),
                  style: Theme.of(context)
                      .extension<AppButtonTheme>()!
                      .infoOutlined,
                  child: Text(Lang.of(context).taskStatus),
                ),
              ),
            ],
          );
        },
      )),

      DataCell(Builder(
        builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: OutlinedButton(
                  onPressed: () => onDetailButtonPressed.call(data),
                  style: Theme.of(context)
                      .extension<AppButtonTheme>()!
                      .infoOutlined,
                  child: Text(Lang.of(context).crudDetail),
                ),
              ),
              OutlinedButton(
                onPressed: () => onDeleteButtonPressed.call(data),
                style: Theme.of(context)
                    .extension<AppButtonTheme>()!
                    .errorOutlined,
                child: Text(Lang.of(context).crudDelete),
              ),
            ],
          );
        },
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
