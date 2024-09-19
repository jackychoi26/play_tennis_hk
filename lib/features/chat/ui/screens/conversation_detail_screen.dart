import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/matchmaking_screen.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_list.dart';

class ConversationDetailScreen extends StatelessWidget {
  const ConversationDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> participants = ['User A', 'User B', 'User C'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('對話詳情'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '對話成員',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: participants.length,
              itemBuilder: (context, index) {
                final participant = participants[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(participant),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SafeArea(
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.remove_circle),
                                  title: const Text('踢出成員'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () {
                  debugPrint('Add button tapped');
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 239, 205, 246),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('退出對話', style: TextStyle(color: Colors.black))),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('退出對話'),
          content: const Text('你確定要退出這個對話嗎？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MatchmakingScreen(),
                  ),
                );
              },
              child: const Text('確定'),
            ),
          ],
        );
      },
    );
  }
}
