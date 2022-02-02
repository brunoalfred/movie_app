

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/app.dart';
import 'package:movie_app/features/movies/presentation/presentation.dart';


void main() {
  group('App', () {
    testWidgets('renders MoviesScreen', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MoviesScreen), findsOneWidget);
    });
  });
}
