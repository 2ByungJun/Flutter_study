import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pkidscoures/SideBar/sidebar_layout.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../main.dart';

class LoginRegisterView extends StatefulWidget {
  @override
  _LoginRegisterViewState createState() => _LoginRegisterViewState();
}

class _LoginRegisterViewState extends State<LoginRegisterView> {
  List<String> _label = ["달님반", "햇님반", "별님반"];
  String _selectedLabel;

  final TextEditingController id = TextEditingController();
  final TextEditingController pw = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Work _work = Provider.of<Work>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("키즈코스 회원가입",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              /***** 상단부 *****/
              Container(
                margin: EdgeInsets.all(20.0),
                child: Text(
                  "보육교사님 환영합니다!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /***** InputBox *****/
              Card(
                margin: EdgeInsets.all(10.0),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.all(5.0),
                        child: TextField(
                          controller: id,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "ID",
                              icon: Icon(Icons.account_circle,
                                  color: Colors.orange[400],
                                  size: 30.0
                              )
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.all(5.0),
                        child: TextField(
                          controller: pw,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "비밀번호",
                              icon: Icon(Icons.vpn_key,
                                  color: Colors.orange[400],
                                  size: 30.0
                              )
                          ),
                        ),
                      ),

                      Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.all(5.0),
                        child: TextField(
                          controller: name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "이름",
                              icon: Icon(Icons.person,
                                  color: Colors.orange[400],
                                  size: 30.0
                              )
                          ),
                        ),
                      ),

                      Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.all(5.0),
                        child: TextField(
                          controller: phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "전화번호",
                              icon: Icon(Icons.call,
                                  color: Colors.orange[400],
                                  size: 30.0
                              )
                          ),
                        ),
                      ),

                      Container(
                        width: 300,
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.list,
                              color: Colors.orange[400],
                              size: 40.0,
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 10.0 ),
                              child: DropdownButton(
                                hint: Text('반 선택하기'),
                                value: _selectedLabel,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedLabel = newValue;
                                  });
                                },
                                items: _label.map((label){
                                  return DropdownMenuItem(
                                   child: new Text(label),
                                   value: label,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /***** 하단부 *****/
              Container(
                child: Text(
                  "모든 사항들을 기입해주세요!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /***** 회원가입 버튼 *****/
              Container(
                margin: EdgeInsets.all(5.0),
                child: RaisedButton(
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.deepOrange,
                  onPressed: () async {
                    await http.post( _work.url + '/teacherCreate',
                        body: {"Id":id.text,
                              "Password":pw.text,
                              "Name":name.text,
                              "Phone":phone.text,
                              "Label":_selectedLabel});
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SideBarLayout()), (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
