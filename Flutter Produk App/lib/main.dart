import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
import 'package:flutterv1/material/1_crud.dart';
// import 'package:flutterv1/material/2_cv.dart';
// import 'package:flutterv1/material/3_commerce_app.dart';
import 'package:flutterv1/material/0_firstapp.dart';
// import 'package:flutterv1/material/1multiprovider/4_color_shared_state.dart';
// import 'package:flutterv1/material/1multiprovider/41_keranjang_shared_state.dart';
// import 'package:flutterv1/material/1multiprovider/42_saldo_shared_state.dart';

//* Tes
import 'package:flutterv1/material/Provider/itemaddnotifier.dart';
import 'package:flutterv1/material/Provider/shopnamenotifier.dart';
import 'package:flutterv1/material/Provider/homescreen.dart';
import 'package:flutterv1/networking_http.dart';

//* Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              details.exception.toString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  };
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Project',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const NetworkingHttpApp(),
    );
  }
}

// * Not Used rn..
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Material List',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Image.asset('assets/img/loginpage.png'),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const MyFirstApp();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  minimumSize: const Size(340, 40),
                ),
                child: const Text('1. Random Words'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return MyApp();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(340, 40),
                ),
                child: const Text('2. CRUD'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return NetworkingHttpApp();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  minimumSize: const Size(340, 40),
                ),
                child: const Text('3. Network HTTP'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


////* Create an app using 3 ChangeNotifierProvider
// class HomeApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<ItemAddNotifier>(
//           create: (BuildContext context) {
//             return ItemAddNotifier();
//           },
//         ),
//         ChangeNotifierProvider<ShopNameNotifier>(
//           create: (BuildContext context) {
//             return ShopNameNotifier();
//           },
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: HomeScreen(),
//       ),
//     );
//   }
// }

////* Create 3 ChangeNotifierProviderCount
// class Counter with ChangeNotifier {
//   int _count = 0;
//   int get count => _count;

//   void increment() {
//     _count++;
//     notifyListeners();
//   }
// }

// class User with ChangeNotifier {
//   String _username = "John Doe";
//   String get username => _username;

//   void updateUsername(String newUsername) {
//     _username = newUsername;
//     notifyListeners();
//   }
// }

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => Counter()),
//         ChangeNotifierProvider(create: (_) => User()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Change Notifier Provider Example"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Consumer<Counter>(
//                 builder: (context, counter, _) {
//                   return Text(
//                     'Count: ${counter.count}',
//                     style: Theme.of(context).textTheme.headline4,
//                   );
//                 },
//               ),
//               Consumer<User>(
//                 builder: (context, user, _) {
//                   return Text(
//                     'Username: ${user.username}',
//                     style: Theme.of(context).textTheme.headline4,
//                   );
//                 },
//               ),
//               ElevatedButton(
//                 child: Text("Increment"),
//                 onPressed: () {
//                   Provider.of<Counter>(context, listen: false).increment();
//                 },
//               ),
//               ElevatedButton(
//                 child: Text("Update username"),
//                 onPressed: () {
//                   Provider.of<User>(context, listen: false)
//                       .updateUsername("Jane Smith");
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

////* MultiProviderExample
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MultiProviderExample(),
//     );
//   }
// }

// class MultiProviderExample extends StatefulWidget {
//   const MultiProviderExample({super.key});

//   @override
//   State<MultiProviderExample> createState() => _MultiProviderExampleState();
// }

// class _MultiProviderExampleState extends State<MultiProviderExample> {
//   TextStyle myTextStyle =
//       TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => ColorState(),
//         ),
//         ChangeNotifierProvider(create: (context) => SaldoState()),
//         ChangeNotifierProvider(
//           create: (context) => KeranjangState(),
//         )
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.grey[900],
//             title: Consumer<ColorState>(
//               builder: (context, colorstate, child) => Text(
//                 "State Management",
//                 style: TextStyle(color: colorstate.getColor),
//               ),
//             )),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Belanja"),
//               SizedBox(
//                 height: 10,
//               ),
//               Consumer<ColorState>(
//                   builder: (context, colorstate, child) => Consumer<SaldoState>(
//                         builder: (context, saldostate, child) => Container(
//                           height: 150,
//                           width: 150,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: colorstate.getColor),
//                           child: Center(
//                             child: Text(
//                               "${saldostate.getSaldo}",
//                               style: myTextStyle,
//                             ),
//                           ),
//                         ),
//                       )),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("DeepPurple"),
//                   Consumer<ColorState>(
//                     builder: (context, colorstate, child) => Switch(
//                         value: colorstate.getIsOrange,
//                         onChanged: ((value) {
//                           colorstate.setColor = value;
//                         })),
//                   ),
//                   Text("DeepOrange")
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Consumer<ColorState>(
//                   builder: (context, colorstate, child) =>
//                       Consumer<KeranjangState>(
//                         builder: (context, keranjangstate, child) => Card(
//                           color: colorstate.getColor,
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.8,
//                             height: 50,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                   "Telur (500) x ${keranjangstate.getQty}",
//                                   style: myTextStyle,
//                                 ),
//                                 Text(
//                                   "${keranjangstate.getQty * 500}",
//                                   style: myTextStyle,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       )),
//             ],
//           ),
//         ),
//         floatingActionButton: Consumer3<ColorState, SaldoState, KeranjangState>(
//           builder: (context, colorstate, saldostate, keranjangstate, child) =>
//               FloatingActionButton(
//             backgroundColor: colorstate.getColor,
//             onPressed: () {
//               if (saldostate.getSaldo > 0) {
//                 saldostate.kurangiSaldo(500);
//                 keranjangstate.tambahkeranjang();
//               }
//             },
//             child: Icon(Icons.shopping_cart_outlined),
//           ),
//         ),
//       ),
//     );
//   }
// }


////* Learn GoRouter src max on flutter https://www.youtube.com/watch?v=5nQQv_nbFqY
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LoginCubit(),
//       child: Builder(builder: (context) {
//         return MaterialApp.router(
//           theme: ThemeData(brightness: Brightness.dark),
//           routerConfig: AppRouter(context.read<LoginCubit>()).router,
//           debugShowCheckedModeBanner: false,
//           title: 'Go Router 5.0.1',
//           // home: const CategoryScreen(),
//         );
//       }),
//     );
//   }
// }

////* CRUD in local  index
// class MyApp extends StatefulWidget {
//   MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<String> warteg = ['Ikan Teri', 'Ikan Nila', 'Ikan Tongkol'];

//   List<double> prices = [10.000, 11.000, 12.000];
//   final textController = TextEditingController();
//   int? wartegIndex;
//   IconData buttonIcon = Icons.add;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: "Toko",
//         theme: ThemeData(brightness: Brightness.dark),
//         // theme: ThemeData(primarySwatch: Colors.blue),
//         // darkTheme: ThemeData(primarySwatch: Colors.green),
//         home: Scaffold(
//             appBar: AppBar(
//                 title: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: textController,
//                       ),
//                     ),
//                     ElevatedButton(
//                       child: Icon(buttonIcon),
//                       onPressed: () {
//                         setState(() {
//                           if (wartegIndex != null) {
//                             warteg[wartegIndex!] = textController.text;
//                             wartegIndex = null;
//                             buttonIcon = Icons.add;
//                             textController.clear();
//                           } else {
//                             warteg.add(textController.text);
//                             textController.clear();
//                           }
//                           textController.clear();
//                         });
//                         print(warteg);
//                       },
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.shopping_cart_outlined)),
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.mark_unread_chat_alt_outlined))
//                 ]),
//             body: ListView.builder(
//               itemCount: warteg.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                     child: ListTile(
//                   title: Text(warteg[index]),
//                   trailing: const Text('\$-'),
//                   onTap: () {
//                     wartegIndex = index;
//                     setState(() {
//                       textController.text = warteg[index];
//                       buttonIcon = Icons.save;
//                     });
//                   },
//                   onLongPress: () {
//                     setState(() {
//                       warteg.removeAt(index);
//                     });
//                   },
//                 ));
//               },
//             ),
//             drawer: Drawer(
//               elevation: 20.0,
//               child: Column(children: <Widget>[
//                 UserAccountsDrawerHeader(
//                   decoration: BoxDecoration(
//                     color: Colors.lightBlueAccent,
//                   ),
//                   accountName: Text("Nanang Priambudi"),
//                   accountEmail: Text("nanangpad@proton.me"),
//                   currentAccountPicture: CircleAvatar(
//                     backgroundColor: Colors.lightGreenAccent,
//                     child: Text("nngpad"),
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     print("menu 1 pressed");
//                   },
//                   leading: Icon(Icons.inbox_rounded),
//                   title: Text("Kotak Masuk"),
//                   trailing: IconButton(
//                       onPressed: () {}, icon: Icon(Icons.nine_k_plus_sharp)),
//                 ),
//                 Divider(
//                   height: 0.1,
//                 ),
//                 ListTile(
//                   onTap: () {
//                     print("menu 2 pressed");
//                   },
//                   leading: Icon(Icons.star_border_rounded),
//                   title: Text("Berbintang"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     print("menu 3 pressed");
//                   },
//                   leading: Icon(Icons.more_time_rounded),
//                   title: Text("Ditunda"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     print("menu 4 pressed");
//                   },
//                   leading: Icon(Icons.content_paste_go_rounded),
//                   title: Text("Draf"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     print("menu 5 pressed");
//                   },
//                   leading: Icon(Icons.label_outline_rounded),
//                   title: Text("Kategori"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     print("menu 6 pressed");
//                   },
//                   leading: Icon(Icons.settings_outlined),
//                   title: Text("Kelola Label"),
//                 ),
//                 Spacer(),
//                 ListTile(
//                   onTap: () {
//                     print("menu 7 pressed");
//                   },
//                   leading: Icon(Icons.logout_rounded),
//                   title: Text("Logout"),
//                 )
//               ]),
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               backgroundColor: Colors.transparent,
//               selectedItemColor: Colors.lightBlueAccent,
//               unselectedItemColor: Colors.white60,
//               items: <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: "Home",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.paypal_rounded),
//                   label: "Bayar",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.notifications_none_rounded),
//                   label: "Notifikasi",
//                 ),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.account_circle_outlined), label: "Akun")
//               ],
//             )));
//   }
// }
