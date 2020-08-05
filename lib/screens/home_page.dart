import 'package:flutter/material.dart';
import 'package:wordchaingame/extensions/extensions.dart';

class HomePage extends StatefulWidget {
  final String hintLabel = "질 수 없지! 다음 단어!!";
  final String hintText = "다음 단어를 입력해주세요";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> words = [];

  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("끝-말-잇-기")),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: (words.isNotEmpty)
                  ? ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          words[index],
                          style: TextStyle(color: Colors.black),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                      itemCount: words.length,
                    )
                  : Center(
                      child: Text(
                        "게임을 시작하세요",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
          ),
          _buildWordInputForm(),
        ],
      ),
    );
  }

  Widget _buildWordInputForm() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.centerRight,
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _inputController,
          decoration: InputDecoration(
            labelText: widget.hintLabel,
            border: OutlineInputBorder(),
            hintText: widget.hintText,
            suffixIcon: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.send),
              ),
              onTap: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                }
              },
            ),
          ),
          onSaved: (value) {
            if (value.isNotEmpty) {
              setState(() {
                words.add(value);
              });
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
            }
            _inputController.text = "";
          },
          validator: (value) {
            print("validate target: $value");
            String returnString;
            if (value.isEmpty) {
              returnString = "단어를 입력해주세요";
            } else if (words.isNotEmpty) {
              String firstChar = words.last.get(words.last.length - 1);
              if (firstChar != value.get(0)) {
                returnString = "입력하신 단어는 '$firstChar' 로 시작하지 않습니다.";
              }
            }
            return returnString;
          },
        ),
      ),
    );
  }
}
