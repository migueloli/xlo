import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/helpers/format_field.dart';
import 'package:xlo/models/filter.dart';

class PriceRangeField extends StatelessWidget {

  final Filter filter;

  PriceRangeField({this.filter});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Min",
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: false,),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: false, )
            ],
            initialValue: filter.minPrice?.toString(),
            onSaved: (v) {
              if(v.isEmpty){
                filter.minPrice = null;
              } else {
                filter.minPrice = int.tryParse(getSanitizedText(v));
              }
            },
            validator: (v) {
              if(v.isNotEmpty && int.tryParse(getSanitizedText(v)) == null){
                return "Utilize valores válidos";
              }
              
              return null;
            },
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Max",
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: false,),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: false, )
            ],
            initialValue: filter.maxPrice?.toString(),
            onSaved: (v) {
              if(v.isEmpty){
                filter.maxPrice = null;
              } else {
                filter.maxPrice = int.tryParse(getSanitizedText(v));
              }
            },
            validator: (v) {
              if(v.isNotEmpty && int.tryParse(getSanitizedText(v)) == null){
                return "Utilize valores válidos";
              }

              return null;
            },
          ),
        ),
      ],
    );
  }
}
