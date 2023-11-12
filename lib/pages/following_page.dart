import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/pages/home_page.dart';
import 'package:github_api_demo/pages/repository_page.dart';

import '../models/user.dart';

class FollowingPage extends StatefulWidget {
  final User user;
  const FollowingPage({required this.user});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  final api = GitHubApi();
  late Future<List<User>> _futureFollowings;

  @override
  void initState() {
    _futureFollowings = api.getFollowing(widget.user.login);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Following"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.login),
              accountEmail: Text(widget.user.htmlUrl),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.avatarUrl),
              ),
            ),
                        ListTile(
              leading: Icon(Icons.house),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(user: widget.user)));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('followers'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FollowingPage(user: widget.user)));
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Repositorios'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RepositoryPage(user: widget.user)));
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favoritos'),
              onTap: () {
                // Adicione ação ao tocar em favoritos aqui
              },
            ),
            // Adicione mais itens de menu conforme necessário
          ],
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: FutureBuilder<List<User>>(
            future: _futureFollowings,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var followings = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: followings.length,
                  itemBuilder: ((context, index) {
                    var user = followings[index];
                    return ListTile(
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatarUrl)),
                      title: Text(user.login),
                      trailing: const Text(
                        "Following",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    );
                  }),
                );
              }
            },
          ))
        ]),
      ),
    );
  }
}
