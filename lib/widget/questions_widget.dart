import 'package:flutter/material.dart';
import 'package:quiz_ui/model/category.dart';
import 'package:quiz_ui/model/option.dart';
import 'package:quiz_ui/model/question.dart';
import 'package:quiz_ui/widget/options_widget.dart';

class QuestionsWidget extends StatelessWidget {
  final Category category;
  final ValueChanged<Option> onClickedOption;
  final ValueChanged<int> onChangedPage;
  final PageController controller;

  const QuestionsWidget({
    Key key,
    this.category,
    this.onClickedOption,
    this.onChangedPage,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onChangedPage,
      itemCount: category.questions.length,
      itemBuilder: (BuildContext context, int index) {
        final question = category.questions[index];
        return _buildQuestion(question: question);
      },
    );
  }

  Widget _buildQuestion({
    @required Question question,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              question.text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose your answer from below',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: OptionsWidget(
                question: question,
                onClickedOption: onClickedOption,
              ),
            ),
          ],
        ),
      );
}
