import 'package:flutter/material.dart';
import 'package:quiz_ui/model/question.dart';

class QuestionNumbersWidget extends StatelessWidget {
  final List<Question> questions;
  final Question question;
  final ValueChanged<int> onClickedNumber;

  const QuestionNumbersWidget({
    Key key,
    @required this.questions,
    @required this.question,
    @required this.onClickedNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: ListView.separated(
          itemBuilder: (context, index) {
            final isSelected = question == questions[index];
            return _buildNumber(index: index, isSelected: isSelected);
          },
          separatorBuilder: (context, index) => Container(
            width: 16,
          ),
          itemCount: questions.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ));
  }

  Widget _buildNumber({
    @required int index,
    @required bool isSelected,
  }) {
    final color = isSelected ? Colors.orange.shade300 : Colors.white;
    return GestureDetector(
      onTap: () => onClickedNumber(index),
      child: CircleAvatar(
        backgroundColor: color,
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
