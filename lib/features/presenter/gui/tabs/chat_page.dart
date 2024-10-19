// ignore_for_file: unused_element, no_leading_underscores_for_local_identifiers

import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/constant/color.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 18.0, right: 18, top: 8),
                    child: SizedBox(
                      height: 28,
                      child: Text(
                        "News and Informations",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: _width,
                    height: _height * 0.4,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              width: _width * 0.6,
                              height: _height * 0.3,
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  Container(
                    // color: AppColors.mainColor,
                    padding: const EdgeInsets.all(12),
                    height: 50,
                    width: _width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Trending"),
                        Text("News"),
                        Text("Informations"),
                        Text("Trivias"),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 500,
                    width: _width,
                    child: ListView.builder(itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          width: _width,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.analogMainColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  height: 90,
                                  width: _width * 0.2,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Contents and Informations"),
                                    Text(
                                      "September 18, 2024",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black87),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                  // Padding(
                  //   padding: const EdgeInsets.all(18.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             height: _height * 0.22,
                  //             width: _width * 0.43,
                  //             decoration: BoxDecoration(
                  //                 color: AppColors.analogComMainColor,
                  //                 borderRadius: BorderRadius.circular(12)),
                  //           ),
                  //           const SizedBox(
                  //             height: 12,
                  //           ),
                  //           Container(
                  //             // color: Colors.orange,
                  //             height: _height * 0.22,
                  //             width: _width * 0.43,
                  //             decoration: BoxDecoration(
                  //                 color: AppColors.analogComMainColor,
                  //                 borderRadius: BorderRadius.circular(12)),
                  //           ),
                  //         ],
                  //       ),
                  //       Container(
                  //         // color: Colors.green,
                  //         height: _height * 0.27,
                  //         width: _width * 0.43,
                  //         decoration: BoxDecoration(
                  //             color: AppColors.analogComMainColor,
                  //             borderRadius: BorderRadius.circular(12)),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),

              // const SizedBox(
              //   height: 28,
              // ),
              // Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 24),
              //     alignment: Alignment.centerLeft,
              //     child: const Text(
              //       "Dr. Chicken Help",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 24,
              //           color: AppColors.mainColor),
              //     )),
              // Expanded(
              //   child: ListView.builder(
              //     reverse: true, // To show the latest message at the bottom
              //     itemCount: _messages.length,
              //     itemBuilder: (context, index) {
              //       final message = _messages[index];
              //       return ListTile(
              //         title: Text(message),
              //       );
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: TextField(
              //           controller: _controller,
              //           decoration: InputDecoration(
              //             hintText: 'Enter your message...',
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(20.0),
              //             ),
              //           ),
              //         ),
              //       ),
              //       IconButton(
              //         icon: Icon(Icons.send),
              //         onPressed: _handleSend,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
