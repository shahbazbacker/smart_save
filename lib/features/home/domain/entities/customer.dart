import 'package:equatable/equatable.dart';

class CustomerResult extends Equatable {
  final int errorCode;
  final List<Customer> customers;
  final String message;

  const CustomerResult({
    required this.errorCode,
    required this.customers,
    required this.message,
  });

  @override
  List<Object> get props => [errorCode, customers, message];
}

class Customer extends Equatable {
  final int id;
  final String name;
  final String profilePic;
  final String mobileNumber;
  final String email;
  final String street;
  final String streetTwo;
  final String city;
  final int pinCode;
  final String country;
  final String state;
  final DateTime createdDate;
  final String createdTime;
  final DateTime modifiedDate;
  final String modifiedTime;
  final bool flag;
  bool isSelected;

  Customer({
    required this.id,
    required this.name,
    required this.profilePic,
    required this.mobileNumber,
    required this.email,
    required this.street,
    required this.streetTwo,
    required this.city,
    required this.pinCode,
    required this.country,
    required this.state,
    required this.createdDate,
    required this.createdTime,
    required this.modifiedDate,
    required this.modifiedTime,
    required this.flag,
    this.isSelected = false,
  });

  @override
  List<Object> get props => [id, name, mobileNumber];

  Customer copyWith({
    int? id,
    String? name,
    String? profilePic,
    String? mobileNumber,
    String? email,
    String? street,
    String? streetTwo,
    String? city,
    int? pinCode,
    String? country,
    String? state,
    DateTime? createdDate,
    String? createdTime,
    DateTime? modifiedDate,
    String? modifiedTime,
    bool? flag,
    bool? isSelected,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      street: street ?? this.street,
      streetTwo: streetTwo ?? this.streetTwo,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      country: country ?? this.country,
      state: state ?? this.state,
      createdDate: createdDate ?? this.createdDate,
      createdTime: createdTime ?? this.createdTime,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedTime: modifiedTime ?? this.modifiedTime,
      flag: flag ?? this.flag,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Customer.empty()
      : this(
          id: -1,
          name: '',
          profilePic: '',
          mobileNumber: '',
          email: '',
          street: '',
          streetTwo: '',
          city: '',
          pinCode: -1,
          country: '',
          state: '',
          createdDate: DateTime.now(),
          createdTime: '',
          modifiedDate: DateTime.now(),
          modifiedTime: '',
          flag: false,
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_pic": profilePic,
        "mobile_number": mobileNumber,
        "email": email,
        "street": street,
        "street_two": streetTwo,
        "city": city,
        "pincode": pinCode,
        "country": country,
        "state": state,
        "created_date":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date":
            "${modifiedDate.year.toString().padLeft(4, '0')}-${modifiedDate.month.toString().padLeft(2, '0')}-${modifiedDate.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
      };
}
