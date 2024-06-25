import 'package:flutter_hooks/flutter_hooks.dart';

(bool, void Function()) useToggle([bool initialState = false]) {
  final state = useState(initialState);
  final toggle = useCallback(() => state.value = !state.value);
  return (state.value, toggle);
}

(bool, int, void Function()) useCountToggle({
  bool initialState = false,
  int initialCount = 0,
}) {
  final state = useState(initialState);
  final count = useState(initialCount);
  final toggle = useCallback(() {
    state.value = !state.value;
    state.value ? count.value++ : count.value--;
  });
  return (state.value, count.value, toggle);
}
