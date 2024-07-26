// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final TextEditingController _controller;
//   @override
//   void initState() {
//     _controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CounterBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Testing bloc'),
//         ),
//         body: BlocConsumer<CounterBloc, CounterState>(
//           builder: (context, state) {
//             final invalidValue =
//                 (state is CounterStateInvalid) ? state.invalidValue : '';
//             return Column(
//               children: [
//                 Text('current value => ${state.value}'),
//                 Visibility(
//                     visible: state is CounterStateInvalid,
//                     child: Text('Invalid input: $invalidValue')),
//                 TextField(
//                   controller: _controller,
//                   decoration:
//                       const InputDecoration(hintText: 'enter a number here'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(DecreamentEvent(_controller.text));
//                       },
//                       child: const Text('-'),
//                     ),
//                     TextButton(
//                         onPressed: () {
//                           context
//                               .read<CounterBloc>()
//                               .add(IncreamentEvent(_controller.text));
//                         },
//                         child: const Text('+'))
//                   ],
//                 )
//               ],
//             );
//           },
//           listener: (context, state) {
//             _controller.clear();
//           },
//         ),
//       ),
//     );
//   }
// }

// @immutable
// abstract class CounterState {
//   final int value;

//   const CounterState(this.value);
// }

// class CounterStateValid extends CounterState {
//   const CounterStateValid(int value) : super(value);
// }

// class CounterStateInvalid extends CounterState {
//   final String invalidValue;
//   const CounterStateInvalid({
//     required this.invalidValue,
//     required int previousValue,
//   }) : super(previousValue);
// }

// @immutable
// abstract class CounterEvent {
//   final String value;

//   const CounterEvent(this.value);
// }

// class IncreamentEvent extends CounterEvent {
//   const IncreamentEvent(String value) : super(value);
// }

// class DecreamentEvent extends CounterEvent {
//   const DecreamentEvent(String value) : super(value);
// }

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(const CounterStateValid(0)) {
//     on<IncreamentEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(
//           CounterStateInvalid(
//             invalidValue: event.value,
//             previousValue: state.value,
//           ),
//         );
//       } else {
//         emit(CounterStateValid(state.value + integer));
//       }
//     });
//     on<DecreamentEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(
//           CounterStateInvalid(
//             invalidValue: event.value,
//             previousValue: state.value,
//           ),
//         );
//       } else {
//         emit(CounterStateValid(state.value - integer));
//       }
//     });
//   }
// }