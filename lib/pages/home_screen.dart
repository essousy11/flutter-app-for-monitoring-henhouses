import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            children: [
              Row(
            children: [
              MaterialButton(
                onPressed: () {},
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.home), Text("Home")],
                ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.home), Text("Home")],
                  ),
                  )
            ],
          ),

          Spacer(),
          Row(
            children: [
              MaterialButton(
                onPressed: () {},
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.home), Text("Home")],
                ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.home), Text("Home")],
                  ))
            ],
          ),
            ],
          )
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("Home Pages Screen"))
            ],
          )
    );
  }
}