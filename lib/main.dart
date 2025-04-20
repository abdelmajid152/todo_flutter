import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/controllers/product_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'To Do App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getLoadedProducts(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            title: Text(title)
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {

            switch(state) {
              case ProductLoading():

                return const Center(child: CircularProgressIndicator());
                // TODO: Handle this case.
              case ProductLoaded():
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.productList.length,
                  itemBuilder: (context, index) {
                    final product = state.productList[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ],
                      ),
                    );
                  },
                );
                // TODO: Handle this case.
              case ProductErrorMessage():
                return Center(
                  child: Text(state.errorMessage.toString()),
                );
                // TODO: Handle this case.
            }



          },
        ),
      ),
    );
  }
}
