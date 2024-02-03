import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<String> _tabTitles = ["Today", "Games", "Apps", "Arcade", "Search"];
  final List<String> _gameNames = ["Chess", "Sudoku", "Crossword", "Checkers"];
  final List<String> _searchHistory = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_tabTitles[_currentIndex]),
          backgroundColor: const Color.fromARGB(255, 146, 148, 149),
        ),
        body: _buildBody(),
        bottomNavigationBar: Theme(
          data: ThemeData(
            canvasColor: const Color.fromARGB(255, 77, 76, 74), // Cambia el color de fondo de la barra de navegación
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                label: 'Today',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.games),
                label: 'Games',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Apps',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.gamepad),
                label: 'Arcade',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      // Si la pestaña seleccionada es "Today", muestra el contenido con dos imágenes
      return TodayScreen();
    } else if (_currentIndex == 4) {
      // Si la pestaña seleccionada es "Search", muestra el widget de búsqueda
      return SearchScreen(gameNames: _gameNames, searchHistory: _searchHistory);
    } else {
      // En otras pestañas, puedes mostrar contenido específico
      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 55, 79, 91),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://i.ibb.co/bLrg6LB/imagen-2024-02-02-074825726.png',
                height: 400,
                width: 500,
              ),
            ],
          ),
        ),
      );
    }
  }
}

class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 55, 79, 91),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://i.ibb.co/bLrg6LB/imagen-2024-02-02-074825726.png',
                height: 400,
                width: 500,
              ),
              SizedBox(height: 20),
              Image.network(
                'https://i.ibb.co/5hg8wcm/imagen-2024-02-02-123307406.png', // Puedes cambiar este enlace por otro de tu preferencia
                fit: BoxFit.contain, // Ajusta la imagen para que se adapte al contenedor
                height: 400, // Altura ajustada para permitir desplazamiento vertical
                width: 400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SearchScreen extends StatefulWidget {
  final List<String> gameNames;
  final List<String> searchHistory;

  SearchScreen({required this.gameNames, required this.searchHistory});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _filteredNames = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredNames.addAll(widget.gameNames);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              _filterNames(value);
            },
            onSubmitted: (value) {
              _addToHistory(value);
            },
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredNames[index]),
                leading: Icon(Icons.gamepad),
                onTap: () {
                  _addToHistory(_filteredNames[index]);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'Search History:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.searchHistory.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.searchHistory[index]),
                leading: Icon(Icons.history),
              );
            },
          ),
        ),
      ],
    );
  }

  void _filterNames(String query) {
    setState(() {
      _filteredNames = widget.gameNames
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addToHistory(String value) {
    setState(() {
      if (!_filteredNames.contains(value)) {
        _filteredNames.add(value);
      }
      widget.searchHistory.insert(0, value);
    });
  }
}