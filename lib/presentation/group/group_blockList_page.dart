import 'package:flutter/material.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:grats_app/presentation/group/group_page.dart';
import 'package:grats_app/presentation/slide_left_route.dart';
import 'package:provider/provider.dart';

class GroupBloclListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: createTheme(),
      home: ChangeNotifierProvider<GroupModel>(
        create: (_) => GroupModel(),
        child: Consumer<GroupModel>(builder: (context, model, child) {
          final List<Group> groups = model.groups;
          if (groups == null) {
            return const SizedBox(
                width: 100,
                height: 100,
                child: Center(child: CircularProgressIndicator()));
          }
          final List<Widget> widgets = groups.map((group) {
            return ListTile(
              onTap: () {},
              leading: group.imgURL != null
                  ? CircleAvatar(
                      radius: 30,
                      child: ClipOval(
                        child: Image.network(
                          group.imgURL?? '',
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                    ),
              title: Text('${group.groupName}'),
              subtitle: Text('${group.groupDescription}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
            );
          }).toList();
          return Scaffold(
            appBar: AppBar(centerTitle: true, title: Text('BlockList'),
                actions: [
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.push(context,
                      SlideLeftRoute(exitPage: this, enterPage: GroupPage()));
                },
              ),
            ]),
            body: Center(
              child: ListView(
                children: widgets,
              ),
            ),
          );
        }),
      ),
    );
  }
}
