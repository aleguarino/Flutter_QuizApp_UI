import 'package:flutter/material.dart';
import 'package:quiz_ui/model/option.dart';
import 'package:quiz_ui/model/question.dart';
import 'package:quiz_ui/util/utils.dart';

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key key,
    @required this.question,
    @required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: BouncingScrollPhysics(),
        children: Utils.heightBetween(
          question.options
              .map((option) => _buildOption(context, option))
              .toList(),
          height: 8,
        ));
  }

  Widget _buildOption(BuildContext context, Option option) {
    final color = _getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _buildAnswer(option),
            _buildSolution(question.selectedOption, option),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswer(Option option) => Container(
        height: 50,
        child: Row(
          children: [
            Text(
              option.code,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              option.text,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      );

  Widget _buildSolution(Option solution, Option answer) {
    if (solution == answer) {
      return Text(
        question.solution,
        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      );
    }
    return Container();
  }

  Color _getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (!isSelected) {
      return Colors.grey.shade200;
    } else {
      return option.isCorrect ? Colors.green : Colors.red;
    }
  }
}
