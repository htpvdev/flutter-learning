import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('カラオケ点数ランキング'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: '曲名を入力してください',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScoreListPage()),
                  );
                },
                child: Text('点数一覧ページに遷移'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showScoreInputDialog(context);
                },
                child: Text('点数を入力'),
              ),
            ],
          ),
        ),
      ),
    );
  }

//   void _showScoreInputDialog(BuildContext context) {
//   int _score;

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('点数を入力'),
//         content: TextField(
//           decoration: InputDecoration(
//             hintText: '点数を入力してください',
//           ),
//           keyboardType: TextInputType.number,
//           onChanged: (value) {
//             _score = int.tryParse(value);
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('キャンセル'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final songName = _textEditingController.text;
//               final createdAt = DateTime.now();
//               final score = Score(
//                 songName: songName,
//                 score
//             score: _score,
//             createdAt: createdAt,
//           );
//           await ScoreDatabaseHelper.insertScore(score);
//           _textEditingController.clear();
//           Navigator.of(context).pop();
//         },
//         child: Text('OK'),
//       ),
//     ],
//   );
// },

  void _showScoreInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('点数を入力'),
          content: TextField(
            decoration: InputDecoration(
              hintText: '点数を入力してください',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () {
                // 点数を保存する処理
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// class ScoreListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('点数一覧ページ'),
//       ),
//       body: Center(
//         child: Text('ここに点数一覧が表示されます。'),
//       ),
//     );
//   }
// }

class Score {
  final int id;
  final String songName;
  final int score;
  final DateTime createdAt;

  Score({this.id, this.songName, this.score, this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'song_name': songName,
      'score': score,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  static Score fromMap(Map<String, dynamic> map) {
    return Score(
      id: map['id'],
      songName: map['song_name'],
      score: map['score'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }
}

class ScoreDatabaseHelper {
  static final String _tableName = 'scores';

  static Future<Database> _openDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'score_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, song_name TEXT, score INTEGER, created_at INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertScore(Score score) async {
    final db = await _openDatabase();
    await db.insert(
      _tableName,
      score.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Score>> getAllScores() async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Score.fromMap(maps[i]);
    });
  }
}

class ScoreListPage extends StatefulWidget {
  const ScoreListPage({Key key}) : super(key: key);

  @override
  _ScoreListPageState createState() => _ScoreListPageState();
}

class _ScoreListPageState extends State<ScoreListPage> {
  Future<List<Score>> _scoreListFuture;

  @override
  void initState() {
    super.initState();
    _scoreListFuture = ScoreDatabaseHelper.getAllScores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('点数一覧'),
      ),
      body: FutureBuilder<List<Score>>(
        future: _scoreListFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Score>> snapshot) {
          if (snapshot.hasData) {
            final scoreList = snapshot.data;
            return ListView.builder(
              itemCount: scoreList.length,
              itemBuilder: (BuildContext context, int index) {
                final score = scoreList[index];
                return ListTile(
                  title: Text(score.songName),
                  subtitle: Text(score.score.toString()),
                  trailing:
                      Text(DateFormat.yMd().add_Hm().format(score.createdAt)),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('エラーが発生しました'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
