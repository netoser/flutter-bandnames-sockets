import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id:'1', name:'JhonDeere', votes:5),
    Band(id:'2', name:'Caterpillar', votes:1),
    Band(id:'3', name:'Milwaukee', votes:3),
    Band(id:'4', name:'WRangler', votes:2),
    Band(id:'5', name:'Joyson', votes:4)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plantas', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation:1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand
        ),
   );
  }

  //Vamos a convertir el listtile en un widget
  // ListTile _bandTile(Band band) {
  //   return ListTile(
  //           leading: CircleAvatar(
  //             child: Text( band.name.substring(0,2)),
  //             backgroundColor: Colors.blue[100],
  //           ),
  //           title: Text(band.name),
  //           trailing: Text('${band.votes}',style:TextStyle(fontSize: 20)),
  //           onTap: () {
  //             print(band.name);
  //           },
  //         ); 
  // }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        print('direction: $direction');
        print('id: ${band.id}');
        // TODO: Llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.amber,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Planta', style: TextStyle(color: Colors.white),)
        ),
      ),
      child: ListTile(
              leading: CircleAvatar(
                child: Text( band.name.substring(0,2)),
                backgroundColor: Colors.blue[100],
              ),
              title: Text(band.name),
              trailing: Text('${band.votes}',style:TextStyle(fontSize: 20)),
              onTap: () {
                print(band.name);
              },
            ),
    ); 
  }

  addNewBand() {
    final textController = new TextEditingController();

    //Que hacer para que se vean bien en iOS:

    if(Platform.isAndroid) {// si es Android
    //if(!Platform.isAndroid) // si no es android
          return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Nueva Planta:'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: ()=> addBandToList(textController.text)
                )
              ],
            );
          }
        );
      }

      showCupertinoDialog(
        context: context, 
        builder: ( _ ) {
          return CupertinoAlertDialog(
            title: Text('New band name:'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: ()=>addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dismiss'),
                onPressed: ()=>Navigator.pop(context),
              )
            ],
          );
        }
      );
    }


    

  void addBandToList(String name) {
    print(name);
    if( name.length > 1 ) {
      // pordemos agregar
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    
    Navigator.pop(context);

  }


}