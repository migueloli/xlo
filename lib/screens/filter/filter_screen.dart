import 'package:flutter/material.dart';
import 'package:xlo/models/filter.dart';
import 'package:xlo/screens/filter/widgets/animated_button.dart';
import 'package:xlo/screens/filter/widgets/order_by_field.dart';
import 'package:xlo/screens/filter/widgets/price_range_field.dart';
import 'package:xlo/screens/filter/widgets/section_title.dart';
import 'package:xlo/screens/filter/widgets/vendor_type_field.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  Filter _filter = Filter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text("Filtrar busca"),
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                const SectionTitle(title: "Ordernar por"),
                OrderByField(
                  initialValue: _filter.orderBy,
                  onSaved: (v) {
                    _filter.orderBy = v;
                  },
                ),
                const SectionTitle(title: "Preço (R\$)"),
                PriceRangeField(
                  filter: _filter,
                ),
                const SectionTitle(title: "Tipo de anunciante"),
                VendorTypeField(
                  initialValue: _filter.vendorType,
                  onSaved: (v) {
                    _filter.vendorType = v;
                  },
                ),
              ],
            ),
          ),
          AnimatedButton(
            scrollController: _scrollController,
            onTap: () {
              if(_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }

              if(!_filter.isPriceRangeValid()){
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text(
                      "Faixa de preço inválida!"
                    ),
                    backgroundColor: Colors.pink,
                  )
                );
                return;
              }

              
            },
          ),
        ],
      ),
    );
  }
}
