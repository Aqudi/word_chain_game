import 'package:flutter/material.dart';
import 'package:wordchaingame/extensions/extensions.dart';

class HomePage extends StatefulWidget {
  final String hintLabel = "질 수 없지! 다음 단어!!";
  final String hintText = "다음 단어를 입력해주세요";

  final RegExp checkSpecialChar =
      new RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-\d]');

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> words = [];

  String inputWord;

  FocusNode _inputFocusNode;

  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _inputFocusNode = FocusNode();
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
                      reverse: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          words[index],
                          style: TextStyle(color: Colors.black),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 16,
                        );
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
          textInputAction: TextInputAction.done,
          focusNode: _inputFocusNode,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_inputFocusNode);
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
            }
          },
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
            if (inputWord.isNotEmpty) {
              setState(() {
                words.insert(0, inputWord);
              });
            }
          },
          validator: (value) {
            // 공백제거
            value = value.trim();

            print("validate target: $value");

            // 단어 입력 검증
            if (value.isEmpty) {
              return "단어를 입력해주세요.";
            } else if (words.isNotEmpty) {
              if (value.length <= 1) {
                // 단어 길이 검증
                return "2글자 이상의 단어를 입력해주세요.";
              } else {
                // 특수문자 검증
                if (widget.checkSpecialChar.hasMatch(value)) {
                  return "특수문자, 숫자는 입력 불가합니다";
                }
                // 끝말잇기 규칙 검증
                String firstChar = words.first.last();
                if (firstChar != value.first()) {
                  return "입력하신 단어는 '$firstChar' 로 시작하지 않습니다.";
                }
              }
            }

            inputWord = value;
            _inputController.clear();
            return null;
          },
        ),
      ),
    );
  }
}
