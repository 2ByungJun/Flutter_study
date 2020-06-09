import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String imageUrlByKey(int key) {
    return "https://picsum.photos/300/300?image=${key + 100}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("메인"),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 150.0,
                color: Colors.green[200],
              ),
            ],
          ),
        ),
      ),
      body: GridView.builder(
        // 주어진 갯수 만큼, 우리가 정한 템플릿이 반복됨
        // 갯수가 0 ~ 개수-1
        // -> List
        padding: EdgeInsets.all(10.0),
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // 위젯 Card 용
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
        itemBuilder: (BuildContext bc, int index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyApp2(),
            )),
            child: Card(
              child: Container(
                color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.yellow,
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.more_horiz),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                            return MyApp3(imageUrlByKey(index));
                          })
//                            Navigator.of(context).push(
//                              MaterialPageRoute(
//                                builder: (context) => MyApp3(),
//                              ),
                              );
                        },
                        child: Hero(
                          tag: imageUrlByKey(index),
                          child: Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                //color: Colors.pink,
                                borderRadius: BorderRadius.circular(70.0),
                                image: DecorationImage(
                                  image: NetworkImage(imageUrlByKey(index)),
//                                    image: NetworkImage(
//                                      "https://cdn.pixabay.com/photo/2020/06/01/07/16/pieris-rapae-5245438__340.jpg",
//                                    ),
//                                    fit: BoxFit.cover // 가로와 높이에 따라 정비율로 늘려준다. , 높이만 fitHeight
                                )),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.purple,
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ), // 자기자신을 늘리는 방식
                      margin: EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Text("이름 ${index + 1}"),
                    ),
                    Container(
                      color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.person),
                            color: Colors.grey,
                            onPressed: () {},
                          ),
                          Text(
                            "|",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 20.0),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite),
                            color: Colors.grey,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              onTap: () {},
              onLongPress: null,
              leading: Icon(Icons.access_time),
              title: Text("TITLE"),
              subtitle: Text("Sub..."),
              trailing: IgnorePointer(
                ignoring: true,
                child: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () {},
                ),
              ));
        },
      ),
    );
  }
}

class MyApp3 extends StatelessWidget {
  final String imageUrl;

  MyApp3(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Hero"),
        backgroundColor: Colors.green[200],
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.blue[200],
              child: Center(
                child: Hero(
                  tag: imageUrl,
                  child: Container(
                    width: 400.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70.0),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(imageUrl),
          ],
        ),
      ),
    );
  }
}
