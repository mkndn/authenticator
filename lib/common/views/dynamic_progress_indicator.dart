import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticator/common/bloc/progress/progress_bloc.dart';

class DynamicProgressIndicator extends StatefulWidget {
  const DynamicProgressIndicator({super.key});

  @override
  State<DynamicProgressIndicator> createState() =>
      _DynamicProgressIndicatorState();
}

class _DynamicProgressIndicatorState extends State<DynamicProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    final progressBloc = BlocProvider.of<ProgressBloc>(context);
    return BlocBuilder<ProgressBloc, ProgressState>(
      bloc: progressBloc,
      builder: (context, state) => Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 50.0,
              width: 250.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              child: CircularProgressIndicator(
                value: state.percent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
