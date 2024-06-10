import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:home_rent/api/message_user.dart';

class UserCard extends StatefulWidget {
  final MessageUser messageUser;
  const UserCard({super.key , required this.messageUser});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05,vertical: 5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    color: Colors.blue.shade100,
    elevation: 1,
      child: InkWell(
        onTap: (){},
        child: ListTile(
        leading: const CircleAvatar(child: Icon(CupertinoIcons.person),),
          title: Text(widget.messageUser.name, maxLines: 1),
          subtitle: Text(widget.messageUser.about, maxLines: 1),
          trailing: const Text('Time',style: TextStyle(color: Colors.black)),
        ),
      )
    );
  }
}