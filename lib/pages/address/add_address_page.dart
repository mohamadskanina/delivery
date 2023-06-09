import 'dart:async';

import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/controllers/location_controllers.dart';
import 'package:delivery/controllers/user_controller.dart';
import 'package:delivery/models/address_model.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_text_filed.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  late GoogleMapController mapController;
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(35.932399, 36.640477),
    zoom: 10.0,
  );

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('قم بتغعيل الموقع ثم حاول مجدداً')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('لم تسمح للتطبيق بتحديد موقعك')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لقد منعت الصلاحية عن التطبيق')));
      return false;
    }
    return true;
  }

  void getLocation() async {
    try {
      if (await _handleLocationPermission()) {
        Position position = await Geolocator.getCurrentPosition();
        Get.find<LocationController>().setPostion(position);
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                tilt: 0,
                zoom: 14.5)));
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMESSION_DENIED') {
        debugPrint("permession denied");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIN();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    // if (Get.find<LocationController>().addressList.isNotEmpty) {
    //   Get.find<LocationController>().getUserAddress();
    //   initialCameraPosition = CameraPosition(
    //       target: LatLng(
    //     double.parse(Get.find<LocationController>().getAddress["latitude"]),
    //     double.parse(Get.find<LocationController>().getAddress["longitude"]),
    //   ));
    //   _initialPosition = LatLng(
    //     double.parse(Get.find<LocationController>().getAddress["latitude"]),
    //     double.parse(Get.find<LocationController>().getAddress["longitude"]),
    //   );
    // }
    Timer(const Duration(microseconds: 100), () => getLocation());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address page"),
        backgroundColor: Color.fromARGB(255, 208, 163, 150),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (userController.userModel != null &&
            _contactPersonName.text.isEmpty) {
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          // _addressController.text = '${locationController.placemark.name ?? ''}'
          //     '${locationController.placemark.locality ?? ''}'
          //     '${locationController.placemark.postalCode ?? ''}'
          //     '${locationController.placemark.country ?? ''}';
          print("address in my view is " + _addressController.text);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: const Color.fromARGB(225, 103, 171, 151),
                      )),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: initialCameraPosition,
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        // onCameraIdle: () {
                        //   locationController.updatePosition(
                        //       _cameraPosition, true);
                        // },
                        // onCameraMove: ((Position) =>
                        //     _cameraPosition = Position),
                        onMapCreated: (GoogleMapController controller) {
                          setState(() {
                            mapController = controller;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20, top: Dimensions.height20),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              locationController.setAddressTypeIndex(index);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width20,
                                    vertical: Dimensions.height10),
                                margin:
                                    EdgeInsets.only(right: Dimensions.width10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20 / 4),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ]),
                                child: Icon(
                                  index == 0
                                      ? Icons.home_filled
                                      : index == 1
                                          ? Icons.work
                                          : Icons.location_on,
                                  color: locationController.addressTypeIndex ==
                                          index
                                      ? const Color(0xFF89dad0)
                                      : Theme.of(context).disabledColor,
                                )),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery address"),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextFiled(
                    textController: _addressController,
                    hintText: "your address",
                    icon: Icons.map),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact name"),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextFiled(
                    textController: _contactPersonName,
                    hintText: "Your name",
                    icon: Icons.person),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Your number"),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextFiled(
                    textController: _contactPersonNumber,
                    hintText: "your number",
                    icon: Icons.phone),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar:
          GetBuilder<LocationController>(builder: (locationController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: const Color(0xFFf7f6f4),
                  borderRadius: BorderRadius.only()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      AddressModel _addressModel = AddressModel(
                        addressType: locationController.addressTypeList[
                            locationController.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        address: _addressController.text,
                        latitude:
                            locationController.position.latitude.toString(),
                        longitude:
                            locationController.position.longitude.toString(),
                      );
                      locationController
                          .addAddress(_addressModel)
                          .then((response) {
                        if (response.isSuccess) {
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar("Address", "Added Successfully");
                        } else {
                          Get.snackbar("Address", "Couldn't save address");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: const Color.fromARGB(225, 103, 171, 151),
                      ),
                      child: BigText(
                        text: "حفظ العنوان",
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
