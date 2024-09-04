import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../repository/UserRepository.dart';

class UserList extends StatelessWidget {
  final userRepository = UserRepository();

  Future<List<User>> fetchUsers() async {
    try {
      List<User> users = await userRepository.fetchAllUsers();
      print('Fetched users: $users'); // Kiểm tra dữ liệu trả về
      return users;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: fetchUsers(),
      builder: (context, snapshot) {
        print('Snapshot data: ${snapshot.data}'); // Kiểm tra dữ liệu trong snapshot
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No users found');
        } else {
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.person),
                title: Text(users[index].name),
                subtitle: Text(users[index].email),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => showInfo(context, users[index]), // Sửa lỗi onTap
              );
            },
          );
        }
      },
    );
  }

  showInfo(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(user.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Email: ${user.email}'),
                Text('Address: ${user.address.street}, ${user.address.city}'),
                Text('Phone: ${user.phone}'),
                Text('Website: ${user.website}'),
                Text('Company: ${user.company.name}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}