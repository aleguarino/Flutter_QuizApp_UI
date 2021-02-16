import 'package:flutter/material.dart';
import 'package:quiz_ui/model/category.dart';
import 'package:quiz_ui/model/option.dart';
import 'package:quiz_ui/model/question.dart';
import 'package:quiz_ui/widget/question_numbers_widget.dart';
import 'package:quiz_ui/widget/questions_widget.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  PageController controller;
  Question question;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    question = widget.category.questions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: QuestionsWidget(
        category: widget.category,
        controller: controller,
        onClickedOption: _selectOption,
        onChangedPage: (index) => _nextQuestion(index: index),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) => AppBar(
        title: Text(widget.category.categoryName),
        actions: [
          Icon(Icons.filter_alt_outlined),
          const SizedBox(width: 16),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.purple],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: QuestionNumbersWidget(
              questions: widget.category.questions,
              question: question,
              onClickedNumber: (index) => _nextQuestion(
                index: index,
                jump: true,
              ),
            ),
          ),
        ),
      );

  void _selectOption(Option option) {
    if (question.isLocked) {
      return;
    } else {
      setState(() {
        question.isLocked = true;
        question.selectedOption = option;
      });
    }
  }

  void _nextQuestion({int index, bool jump = false}) {
    final nextPage = controller.page + 1;
    final indexPage = index ?? nextPage.toInt();
    setState(() => question = widget.category.questions[indexPage]);
    if (jump) {
      controller.jumpToPage(indexPage);
    }
  }
}
