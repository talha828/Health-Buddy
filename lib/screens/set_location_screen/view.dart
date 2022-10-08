import 'package:flutter/material.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({Key? key}) : super(key: key);

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading:IconButton(icon:const Icon(Icons.arrow_back_ios),onPressed: ()=>Navigator.pop(context),),
        centerTitle: true,
        title:const Text("Mark Location",style: TextStyle(color: Colors.red),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: width *0.02,horizontal: width *0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: width * 0.03,),
            Text("Current Location",style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: width * 0.03,),
              //padding: EdgeInsets.symmetric(horizontal: width * 0.02,),
               TextField(
                  decoration: InputDecoration(
                    hintText: "Current Location",
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: width * 0.04),
                    border:const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                    suffixIcon: Icon(Icons.location_on_outlined)
                  ),
              ),
            SizedBox(height: width * 0.03,),
            Text("Final Location",style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: width * 0.03,),
            //padding: EdgeInsets.symmetric(horizontal: width * 0.02,),
            TextField(
              decoration: InputDecoration(
                  hintText: "Final Location",
                  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: width * 0.04),
                  border:const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  suffixIcon: Icon(Icons.location_on_outlined)
              ),
            ),
            SizedBox(height: width * 0.09,),
            ElevatedButton(
                // autofocus: true,
                onPressed: (){}, child: Text("Post Now"))
          ],
        ),
      ),
    ));
  }
}
