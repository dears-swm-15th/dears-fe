import 'package:flutter_hooks/flutter_hooks.dart';

(bool, void Function()) useToggle([bool initialState = false]) {
  final state = useState(initialState);
  final toggle = useCallback(() => state.value = !state.value);
  return (state.value, toggle);
}
