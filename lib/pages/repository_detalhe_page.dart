import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/models/branch.dart';
import 'package:github_api_demo/models/repository.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/pages/fav_repository_page.dart';
import 'package:github_api_demo/pages/following_page.dart';
import 'package:github_api_demo/pages/home_page.dart';
import 'package:github_api_demo/pages/repository_page.dart';

class RepositoryDetalhesPage extends StatefulWidget {
  final Repository repo;
  final User user;
  const RepositoryDetalhesPage({required this.repo, required this.user});

  @override
  State<RepositoryDetalhesPage> createState() => _RepositoryDetalhesPageState();
}

class _RepositoryDetalhesPageState extends State<RepositoryDetalhesPage> {
  final api = GitHubApi();
  late Future<List<Branch>> _branch;

  @override
  void initState() {
    _branch = api.getBranches(widget.user.login, widget.repo.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.login),
              accountEmail: Text(widget.user.avatarUrl),
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
                        builder: (context) => HomePage(user: widget.user)));
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
      appBar: AppBar(
        title: Text(widget.repo.name),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Linguagem'),
            subtitle: Text(widget.repo.language),
          ),
          ListTile(
            title: const Text('Descrição'),
            subtitle: Text(widget.repo.description),
          ),
          ListTile(
            title: const Text('Dono'),
            subtitle: Text(widget.user.login),
          ),
          ListTile(
            title: const Text('Visualização'),
            subtitle:
                Text(widget.repo.isPrivate == true ? 'Privado' : 'Publico'),
          ),
          ListTile(
            title: const Text('Caminho'),
            subtitle: Text(widget.repo.fullName),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 20,
          ),
                      SizedBox(height: 50),
            Text(
              'Branchs',
              style: TextStyle(fontSize: 15),
            ),
          Expanded(
              child: FutureBuilder<List<Branch>>(
            future: _branch,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var branch = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: branch.length,
                  itemBuilder: ((context, index) {
                    var repo = branch[index];
                    return ListTile(
                      title: Text(repo.name),
                      trailing: Text(
                        repo.sha,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    );
                  }),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
