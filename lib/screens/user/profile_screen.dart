import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? profilePictureUrl;
  File? profilePicture;

  Future<void> _uploadProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profilePicture = File(pickedFile.path);
      });

      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${widget.userId}/profilePicture.jpg');

      await storageRef.putFile(profilePicture!);

      final downloadUrl = await storageRef.getDownloadURL();

      setState(() {
        profilePictureUrl = downloadUrl;
      });

      final userRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userId);
      await userRef.update({'profilePicture': profilePictureUrl});
    }
  }

  /*Future<void> _updateProfile() async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);

    final updatedData = {
      'name': name,
    };

    await userRef.update(updatedData);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.blue,
            width: 5,
          ),
        ),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching profile data'),
              );
            }

            final userData = snapshot.data!.data();
            name = userData?['name'];
            profilePictureUrl = userData?['profilePicture'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _uploadProfilePicture,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: profilePictureUrl != null
                                  ? NetworkImage(profilePictureUrl!)
                                  : null,
                              child: profilePictureUrl == null
                                  ? Icon(
                                      Icons.person,
                                      size: 150,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Name: ',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${name ?? 'N/A'}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              final updatedName = await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  String newName = name ?? '';

                                  return AlertDialog(
                                    title: const Text('Edit Name'),
                                    content: TextFormField(
                                      initialValue: name,
                                      onChanged: (value) {
                                        newName = value;
                                      },
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(newName);
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (updatedName != null &&
                                  updatedName.isNotEmpty) {
                                setState(() {
                                  name = updatedName;
                                });

                                final userRef = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.userId);
                                await userRef.update({'name': updatedName});
                              }
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                          leading: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            size: 30,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Email:',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${userData?['email'] ?? 'N/A'}',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
