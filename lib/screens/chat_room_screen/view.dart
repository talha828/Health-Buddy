import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController message=TextEditingController();
  List<String> msg = [
    "Hello Dear",
    "How are you",
    "I think you are busy, may i talk later",
    "No! No! No!! please wait just give me two mints i will contact you as soon as possible "
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.arrow_back_ios,
              color: Colors.red,
            ),
            centerTitle: true,
            title: Text(
              "Talha Iqbal",
              style: TextStyle(color: Colors.red),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(top: width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ChatMessageTile(
                          width: width,
                          message: msg[index],
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: width * 0.03,
                        );
                      },
                      itemCount: msg.length),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {

                          },
                          icon: Icon(Icons.camera_alt_outlined)),
                      IconButton(
                          onPressed: () async {

                          },
                          icon: Icon(Icons.image)),
                      IconButton(
                          onPressed: () async {

                          },
                          icon: Icon(Icons.file_open_rounded)),
                      Container(
                        width: width * 0.5,
                        margin: EdgeInsets.symmetric(
                            vertical: width * 0.04, horizontal: width * 0.04),
                        child: TextField(
                          maxLines: null,
                          controller: message,
                          decoration: InputDecoration(
                            filled: true,
                            suffixIcon: IconButton(
                              onPressed: () async {

                              },
                              icon: Icon(Icons.send,
                                  size: width * 0.06, color: Colors.red),
                            ),
                            fillColor: Colors.grey.shade300,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                                vertical: width * 0.04),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width * 0.04),
                            ),
                            hintText: "Type ..",
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class ChatMessageTile extends StatelessWidget {
  ChatMessageTile(
      {required this.width, required this.message, required this.index});
  final double width;
  final String message;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: CircleAvatar(
        backgroundColor: index > 2 ? Colors.red : Colors.white,
        child: Text(
          "Halha".toString().substring(0, 1).toUpperCase(),
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.05),
        ),
      ),
      leading: CircleAvatar(
        backgroundColor: index < 2 ? Colors.red : Colors.white,
        child: Text(
          "Talha".toString().substring(0, 1).toUpperCase(),
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.05),
        ),
      ),
      title: Container(
        padding: EdgeInsets.symmetric(
            vertical: width * 0.04, horizontal: width * 0.04),
        decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.9),
            borderRadius: BorderRadius.circular(width * 0.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              message,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: width * 0.02,
            ),
            Text(
              "11:00 PM",
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.white, fontSize: width * 0.04),
            ),
          ],
        ),
      ),
    );
  }
}
