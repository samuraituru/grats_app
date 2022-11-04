import 'package:flutter/material.dart';
import 'package:grats_app/domain/group.dart';
import 'package:grats_app/main.dart';
import 'package:grats_app/presentation/group/group_model.dart';
import 'package:provider/provider.dart';

class GroupBloclListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupModel>(
      create: (_) => GroupModel()..fetchBlockList(),
      child: Consumer<GroupModel>(builder: (context, model, child) {
        final List<Group> blockGroups = model.blockGroups;
        final currentUID = model.currentUID;
        if (blockGroups == null) {
          return const SizedBox(
              width: 100,
              height: 100,
              child: Center(child: CircularProgressIndicator()));
        }
        final List<Widget> widgets = blockGroups.map((group) {
          return Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    //title: new Text('AlertDialog'),
                    content: const Text('ブロックを解除しますか？'),
                    actions: <Widget>[
                      SimpleDialogOption(
                        child: const Text('Yes'),
                        onPressed: () {
                          model.blockButtonDisable(group, currentUID!);
                          model.fetchBlockList();
                          Navigator.pop(context);
                        },
                      ),
                      SimpleDialogOption(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              leading: group.imgURL != ''
                  ? CircleAvatar(
                      radius: 30,
                      child: ClipOval(
                        child: Image.network(
                          group.imgURL ?? '',
                        ),
                      ),
                    )
                  : const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                    ),
              title: Text('${group.groupName}'),
              subtitle: Text('${group.groupDescription}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          );
        }).toList();
        return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text('BlockList'),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: ThemeColors.whiteColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    /*Navigator.of(
                    context)
                    .pushNamed("/home");*/
                  },
                ),
              ]),
          body: Center(
            child: RefreshIndicator(
              onRefresh: () async {
                print('Loading New Data');
                await model.fetchBlockList();
              },
              child: ListView(
                children: widgets,
              ),
            ),
          ),
        );
      }),
    );
  }
}
