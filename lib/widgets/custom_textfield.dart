import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samip_grubrr/utils/base_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.fieldValidator,
    required this.label,
    this.capitalization,
    this.inputAction,
    this.isNumeric = false,
    required this.focus,
    this.formatters,
    this.inputType,
    this.isMandatory = true,
    this.autoValidateMode,
    this.onSubmit,
  }) : super(key: key);

  final TextEditingController controller;
  final FormFieldValidator<String>? fieldValidator;
  final ValueChanged<String>? onSubmit;
  final String label;
  final TextCapitalization? capitalization;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final bool isNumeric;
  final FocusNode focus;
  final List<TextInputFormatter>? formatters;
  final bool isMandatory;
  final AutovalidateMode? autoValidateMode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late OutlineInputBorder border;
  late OutlineInputBorder eBorder;
  AutovalidateMode validateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: const BorderSide(color: BaseColors.white),
      borderRadius: BorderRadius.circular(5.r),
    );
    // eBorder = OutlineInputBorder(
    //   borderSide: const BorderSide(color: BaseColors.red),
    //   borderRadius: BorderRadius.circular(5.r),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.h,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: BaseColors.white),
        borderRadius: BorderRadius.circular(10.r),
      ),
      shadowColor: BaseColors.black.withOpacity(0.3),
      child: TextFormField(
        autovalidateMode: widget.autoValidateMode ?? validateMode,
        focusNode: widget.focus,
        validator: widget.fieldValidator,
        onFieldSubmitted: widget.onSubmit,
        controller: widget.controller,
        decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: RichText(
            text: TextSpan(
              text: widget.label,
              style: TextStyle(
                color: BaseColors.hintColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              children: widget.isMandatory
                  ? const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: BaseColors.pink,
                        ),
                      )
                    ]
                  : [],
            ),
          ),
          counterText: '',
        ),
        textCapitalization:
            widget.capitalization ?? TextCapitalization.sentences,
        textInputAction: widget.inputAction ?? TextInputAction.done,
        keyboardType: widget.inputType ?? TextInputType.text,
        maxLength: widget.isNumeric ? 4 : null,
        inputFormatters: widget.formatters,
      ),
    );
  }
}
