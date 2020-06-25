import 'package:Aerar/generated/l10n.dart';
import 'package:Aerar/view_models/stock_list_view_model.dart';
import 'package:Aerar/widgets/stock_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StockListViewModel _vm;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _vm = Provider.of<StockListViewModel>(context, listen: false);
    _vm.fetchStocks();
  }

  void _filterStocks(String searchTerm) {
    _vm.search(searchTerm);
  }

  Widget _buildContent(BuildContext context) {
    final vm = Provider.of<StockListViewModel>(context);
    final locale = Localizations.localeOf(context);
    final formatter = new DateFormat.yMMMMd(locale.toLanguageTag());
    final today = formatter.format(DateTime.now());

    switch (_selectedIndex) {
      case 0:
        return Expanded(
            child: Container(
                padding: EdgeInsets.all(10),
                child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(today,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SizedBox(
                              height: 50,
                              child: TextField(
                                onChanged: _filterStocks,
                                decoration: InputDecoration(
                                    hintText: S.of(context).search,
                                    prefix: Icon(Icons.search),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0, style: BorderStyle.none),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)))),
                              )),
                        ),
                        Expanded(
                            //height: MediaQuery.of(context).size.height - 200,
                            child: StockList(stocks: vm.stocks))
                      ]),
                )));
        break;
      case 2:
        return RaisedButton(
            child: Text('Show About Dialog'),
            onPressed: () {
              showAboutDialog(context: context);
            });
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);

    return Scaffold(
        body: Row(children: <Widget>[
      NavigationRail(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        labelType: NavigationRailLabelType.selected,
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.graphic_eq),
            selectedIcon: Icon(Icons.graphic_eq),
            label: Text(S.of(context).stocks),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.star_border),
            selectedIcon: Icon(Icons.star),
            label: Text(S.of(context).favorites),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.settings),
            selectedIcon: Icon(Icons.settings),
            label: Text(S.of(context).settings),
          )
        ],
      ),
      content
    ]));
  }
}
