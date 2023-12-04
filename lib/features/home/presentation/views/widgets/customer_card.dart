import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_save/configs/colors.dart';
import 'package:smart_save/configs/icons.dart';
import 'package:smart_save/configs/images.dart';

import 'package:smart_save/features/home/domain/entities/customer.dart';
import 'package:smart_save/features/home/presentation/bloc/customer_bloc/customer_bloc.dart';
import '../../../../../configs/textstyle_class.dart';
import '../../../../../core/utils/api_support.dart';

class CustomerCard extends StatefulWidget {
  const CustomerCard({
    super.key,
    required this.customer,
    required this.customerIndex,
    // this.isSelected = false,
  });

  final Customer customer;
  final int customerIndex;
  // final bool isSelected;

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.all(15.0),
            decoration: ShapeDecoration(
              color: state.selectedCustomer != Customer.empty() &&
                      state.selectedCustomer.id == widget.customer.id
                  ? Colors.grey
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 12,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.customer.profilePic == ''
                      ? Expanded(
                          flex: 2,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                ImageClass.avatar,
                                width: 110,
                                height: 110,
                              )),
                        )
                      : Expanded(
                          flex: 2,
                          child: Container(
                            height: 110,
                            width: 110,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: Apis.baseUrlForMedia +
                                    widget.customer.profilePic,
                                placeholder: (context, url) =>
                                    const CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  VerticalDivider(
                    // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    color: AppColors.grey.withOpacity(0.4),
                    width: 2.0,
                    // height: 23,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.customer.name,
                                style: TextStyleClass.blackBold16,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  IconClass.callIcon,
                                  height: 22,
                                  width: 22,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  IconClass.whatsappIcon,
                                  height: 24,
                                  width: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Ph: ${widget.customer.mobileNumber}',
                          style: TextStyleClass.darkGreyBold14,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '${widget.customer.street}, ${widget.customer.city}, ${widget.customer.state}',
                          style: TextStyleClass.darkGreyBold14,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'Due Amount : ',
                              style: TextStyleClass.blackBold14,
                            ),
                            TextSpan(
                              text: '\$450',
                              style: TextStyleClass.redBold14,
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
