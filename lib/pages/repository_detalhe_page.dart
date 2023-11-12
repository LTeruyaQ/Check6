import 'package:flutter/material.dart';
import 'package:github_api_demo/models/repository.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/pages/following_page.dart';
import 'package:github_api_demo/pages/home_page.dart';
import 'package:github_api_demo/pages/repository_page.dart';


class RepositoryDetalhesPage extends StatefulWidget {
  final Repository repo;
  const RepositoryDetalhesPage({required this.repo});

  @override
  State<RepositoryDetalhesPage> createState() => _RepositoryDetalhesPageState();
}

class _RepositoryDetalhesPageState extends State<RepositoryDetalhesPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.repo.owner.login),
              accountEmail: Text(widget.repo.owner.avatarUrl),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(widget.repo.owner.avatarUrl),
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
                            HomePage(user: widget.repo.owner)));
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
                            FollowingPage(user: widget.repo.owner)));
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
                            RepositoryPage(user: widget.repo.owner)));
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
      
      appBar: AppBar(
        title: Text(widget.repo.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              subtitle: Text(widget.repo.owner.login),
            ),
            ListTile(
              title: const Text('Visualização'),
              subtitle: Text(widget.repo.isPrivate == true ? 'Privado' : 'Publico'),
            ),
            ListTile(
              title: const Text('Caminho'),
              subtitle:
                  Text(widget.repo.fullName),
            ),
          ],
        ),
      ),
    );
  }
}
