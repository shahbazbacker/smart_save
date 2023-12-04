import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_save/configs/colors.dart';
import 'package:smart_save/core/utils/extenstions.dart'
    show StringSnackbarExtension, showToast;
import 'package:smart_save/features/home/presentation/views/widgets/text_field_bordered.dart';
import 'package:smart_save/features/home/presentation/views/widgets/text_field_underlined.dart';

import '../../../../../common_widgets/elevated_button_custom.dart';
import '../../../../../configs/textstyle_class.dart';
import '../../../domain/entities/customer.dart';
import '../../bloc/customer_bloc/customer_bloc.dart';
import '../../bloc/customer_bloc/customer_event.dart';

class CreateCustomerWidget extends StatefulWidget {
  const CreateCustomerWidget({
    super.key,
    this.customer,
  });

  final Customer? customer;

  @override
  State<CreateCustomerWidget> createState() => _CreateCustomerWidgetState();
}

class _CreateCustomerWidgetState extends State<CreateCustomerWidget> {
  @override
  void initState() {
    if (widget.customer != null) {
      nameController.text = widget.customer!.name;
      mobileController.text = widget.customer!.mobileNumber;
      emailController.text = widget.customer!.email;
      street1Controller.text = widget.customer!.street;
      street2Controller.text = widget.customer!.streetTwo;
      cityController.text = widget.customer!.city;
      pinCodeController.text = widget.customer!.pinCode.toString();
      countryController.text = widget.customer!.country;
      stateController.text = widget.customer!.state;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    street1Controller.dispose();
    street2Controller.dispose();
    cityController.dispose();
    pinCodeController.dispose();
    countryController.dispose();
    stateController.dispose();
    super.dispose();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController street1Controller = TextEditingController();
  final TextEditingController street2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.customer != null ? 'Update Customer' : 'Add Customer',
                  style: TextStyleClass.blackBold16,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 24.0,
                      color: AppColors.black600,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Customer Name',
            style: TextStyleClass.blackMedium14,
          ),
          const SizedBox(
            height: 5,
          ),
          TextFieldBordered(
              controller: nameController,
              hintText: 'Customer Name',
              textInputType: TextInputType.name),
          const SizedBox(
            height: 10,
          ),
          TextFieldWithUnderlineBorder(
              controller: mobileController,
              hintText: 'Mobile Number',
              textInputType: TextInputType.phone),
          const SizedBox(
            height: 10,
          ),
          TextFieldWithUnderlineBorder(
              controller: emailController,
              hintText: 'Email',
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Address",
            style: TextStyleClass.blackBold16,
          ),
          Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextFieldWithUnderlineBorder(
                        controller: street1Controller,
                        hintText: 'Street',
                        textInputType: TextInputType.text),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: TextFieldWithUnderlineBorder(
                        controller: street2Controller,
                        hintText: 'Street 2',
                        textInputType: TextInputType.text),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFieldWithUnderlineBorder(
                        controller: cityController,
                        hintText: 'City',
                        textInputType: TextInputType.text),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: TextFieldWithUnderlineBorder(
                        controller: pinCodeController,
                        hintText: 'Pin code',
                        textInputType: TextInputType.number),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFieldWithUnderlineBorder(
                        controller: countryController,
                        hintText: 'Country',
                        textInputType: TextInputType.text),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: TextFieldWithUnderlineBorder(
                      controller: stateController,
                      hintText: 'State',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Flexible(
                  child: BlocBuilder<CustomerBloc, CustomerState>(
                    builder: (context, state) {
                      return ElevatedButtonCustom(
                          label: widget.customer != null ? 'Update' : 'Create',
                          isLoading: state is CreatingCustomer ||
                              state is UpdatingCustomer,
                          padding: 10.0,
                          borderRadius: 25,
                          onTap: () {
                            if (nameController.text.trim().isEmpty) {
                              'Enter Name'.showSnack();
                            } else if (mobileController.text.trim().isEmpty) {
                              'Enter Mobile Number'.showSnack();
                            } else if (validateEmail(
                                    emailController.text.trim()) ==
                                false) {
                              'Enter Valid Email'.showSnack();
                            } else if (pinCodeController.text.trim().isEmpty) {
                              'Enter Pin code'.showSnack();
                            } else if (cityController.text.trim().isEmpty) {
                              'Enter City Name'.showSnack();
                            } else if (street1Controller.text.trim().isEmpty) {
                              'Enter Street 1'.showSnack();
                            } else if (street2Controller.text.trim().isEmpty) {
                              'Enter Street 2'.showSnack();
                            } else if (countryController.text.trim().isEmpty) {
                              'Enter Country Name'.showSnack();
                            } else if (stateController.text.trim().isEmpty) {
                              'Enter State Name'.showSnack();
                            } else {
                              if (widget.customer != null) {
                                context.read<CustomerBloc>().add(
                                    CustomerUpdateEvent(
                                        customerId: widget.customer!.id,
                                        name: nameController.text.trim(),
                                        email: emailController.text.trim(),
                                        mobile: mobileController.text.trim(),
                                        street: street1Controller.text.trim(),
                                        streetTwo:
                                            street2Controller.text.trim(),
                                        city: cityController.text.trim(),
                                        pinCode: pinCodeController.text.trim(),
                                        country: countryController.text.trim(),
                                        state: stateController.text.trim()));
                              } else {
                                context.read<CustomerBloc>().add(
                                    CustomerCreateEvent(
                                        name: nameController.text.trim(),
                                        email: emailController.text.trim(),
                                        mobile: mobileController.text.trim(),
                                        street: street1Controller.text.trim(),
                                        streetTwo:
                                            street2Controller.text.trim(),
                                        city: cityController.text.trim(),
                                        pinCode: pinCodeController.text.trim(),
                                        country: countryController.text.trim(),
                                        state: stateController.text.trim()));
                              }
                              Navigator.of(context).pop();
                            }
                          });
                    },
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  bool validateEmail(String emailAddress) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (emailAddress.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(emailAddress)) {
      return false;
    } else {
      return true;
    }
  }
}
