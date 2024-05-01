import 'package:flutter/material.dart';
// import 'package:flutter_andomie/core.dart';
import 'package:manager/vm/authvm.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for the text fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactInfoController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    syncFirstF();
    super.initState();
  }

  syncFirstF() async {
    AdminAuthProviderC getData =
        await Provider.of<AdminAuthProviderC>(context, listen: false);
    getData.getAdminAuthF();
    getData.adminAuthDataList;
    _nameController.text = getData.adminAuthDataList[0]['email'];
    _passController.text = getData.adminAuthDataList[0]['password'];
    _contactInfoController.text = getData.adminAuthDataList[0]['contact'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminAuthProviderC>(builder: (context, vmVal, child) {
      return Scaffold(
          appBar: AppBar(title: const Text("Admin Profile")),
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //     width: MediaQuery.of(context).size.width * 0.3,
                          //     child: Stack(children: [
                          //       RippleAnimation(
                          //           color: MaterialColors.primaryColor.shade200,
                          //           delay: const Duration(milliseconds: 300),
                          //           repeat: true,
                          //           minRadius: 35,
                          //           ripplesCount: 6,
                          //           duration: const Duration(milliseconds: 1500),
                          //           child: ClipRRect(
                          //               borderRadius: BorderRadius.circular(50),
                          //               child: Hero(
                          //                 tag: "profile",
                          //                 child: CircleAvatar(
                          //                     radius: 50,
                          //                     child: InkWell(
                          //                         borderRadius:
                          //                             BorderRadius.circular(50),
                          //                         onTap: () async {
                          //                           var img = await ImagePicker()
                          //                               .pickImage(
                          //                                   source: ImageSource
                          //                                       .gallery);
                          //                           if (img != null) {
                          //                             await vMval.updateImage(
                          //                                 context, img.path);
                          //                           }
                          //                         },
                          //                         child: vMval.imgPickerPath!
                          //                                 .isNotEmpty
                          //                             ? Image.file(File(
                          //                                 vMval.imgPickerPath!))
                          //                             : CachedNetworkImage(
                          //                                 imageUrl:
                          //                                     vMval.userProfile[
                          //                                             'profile']
                          //                                         ['imgPath'],
                          //                                 placeholder: (context,
                          //                                         url) =>
                          //                                     CircularProgressIndicator(
                          //                                       strokeWidth: 2,
                          //                                       backgroundColor:
                          //                                           MaterialColors
                          //                                               .primaryColor
                          //                                               .shade100,
                          //                                     ),
                          //                                 errorWidget: (context,
                          //                                         url, error) =>
                          //                                     Image.asset(Assets
                          //                                         .coach)))),
                          //               ))),
                          //       Positioned(
                          //           right: 0,
                          //           bottom: 6,
                          //           child: CircleAvatar(
                          //               radius: 15,
                          //               child: vMval.isLoading
                          //                   ? Transform.scale(
                          //                       scale: 0.7,
                          //                       child: CircularProgressIndicator
                          //                           .adaptive(
                          //                         strokeWidth: 2,
                          //                         backgroundColor: MaterialColors
                          //                             .primaryColor.shade100,
                          //                       ),
                          //                     )
                          //                   : const Icon(Icons.edit, size: 20)))
                          //     ])),

                          TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                  labelText: ' Email / Name')),
                          TextFormField(
                              controller: _passController,
                              decoration:
                                  const InputDecoration(labelText: 'Password')),
                          TextFormField(
                              controller: _contactInfoController,
                              decoration: const InputDecoration(
                                  labelText: 'Contact Information')),
                        ]),
                  ))),
          bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            MaterialColors.deepOrange.shade300)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final mapData = {
                          "email": _nameController.text,
                          "contact": _contactInfoController.text,
                          "password": _passController.text,
                        };
                        vmVal.updateAdminAuthF(context, mapData: mapData);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('All Fields Required'),
                            action: SnackBarAction(
                                label: 'Ok!', onPressed: () {})));
                      }
                    },
                    child:
                        // vMval.isLoading
                        //     ?
                        // CircularProgressIndicator.adaptive(
                        //         backgroundColor:
                        //             MaterialColors.deepOrange.shade100)
                        //     :
                        const Text('Update Profile',
                            style: TextStyle(color: Colors.white)),
                  ))));
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactInfoController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
