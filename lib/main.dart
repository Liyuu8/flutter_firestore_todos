import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_firestore_todos/blocs/blocs.dart';
import 'package:flutter_firestore_todos/screens/screens.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final FirebaseUserRepository userRepository = FirebaseUserRepository();
  runApp(TodosApp(userRepository: userRepository));
}

class TodosApp extends StatelessWidget {
  // This widget is the root of your application.
  final FirebaseUserRepository _userRepository;

  TodosApp({
    Key key,
    @required FirebaseUserRepository userRepository,
  }) : assert(userRepository != null),
    _userRepository = userRepository,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          builder: (context) {
            return AuthenticationBloc(
              userRepository: _userRepository,
            )..add(AppStarted());
          },
        ),
        BlocProvider<TodosBloc>(
          builder: (context) {
            return TodosBloc(
              todosRepository: FirebaseTodosRepository(),
            )..add(LoadTodos());
          },
        ),
      ],
      child: MaterialApp(
        title: 'Firestore Todos',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if(state is Unauthenticated) {
                  return LoginScreen(userRepository: _userRepository);
                }
                if(state is Authenticated) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<TabBloc>(
                        builder: (context) => TabBloc(),
                      ),
                      BlocProvider<FilteredTodosBloc>(
                        builder: (context) => FilteredTodosBloc(
                          todosBloc: BlocProvider.of<TodosBloc>(context),
                        ),
                      ),
                      BlocProvider<StatusBloc>(
                        builder: (context) => StatusBloc(
                          todosBloc: BlocProvider.of<TodosBloc>(context),
                        ),
                      ),
                    ],
                    child: HomeScreen(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
          '/addTodo': (context) {
            return AddEditScreen(
              onSave: (task, note) {
                BlocProvider.of<TodosBloc>(context).add(
                  AddTodo(Todo(task, note: note))
                );
              },
              isEditing: false,
            );
          },
        },
      ),
    );
  }
}
