import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/models/repository.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/pages/home_page.dart';
import 'package:github_api_demo/pages/repository_detalhe_page.dart';

import 'following_page.dart';

class FavRepositoryPage extends StatefulWidget {
  final User user;
  const FavRepositoryPage({required this.user});

  @override
  State<FavRepositoryPage> createState() => _FavRepositoryPageState();
}

class _FavRepositoryPageState extends State<FavRepositoryPage> {
  final api = GitHubApi();
  late Future<List<Repository>> _repos;

  @override
  void initState() {
    _repos = api.getFavs(widget.user.login);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Mobile'),
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
                            FavRepositoryPage(user: widget.user)));
              },
            ),
                        ListTile(
              leading: Icon(Icons.star),
              title: Text('Favoritos'),
              onTap: () {
                                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FavRepositoryPage(user: widget.user)));
              },
            ),
            // Adicione mais itens de menu conforme necessário
          ],
        ),
      ),
      
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: FutureBuilder<List<Repository>>(
              future: _repos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  var repos = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: repos.length,
                    itemBuilder: ((context, index) {
                      var repo = repos[index];
                      return ListTile(
                        title: Text(repo.name),
                        trailing: Text(
                          repo.language,
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RepositoryDetalhesPage(repo: repo, user: widget.user)));
                        },
                      );
                    }),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
