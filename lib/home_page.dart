import 'package:flutter/material.dart';
import 'package:proyek_akhir/helper/data_source.dart';
import 'package:proyek_akhir/login_page.dart';
import 'package:proyek_akhir/model/model_data.dart';
import 'package:proyek_akhir/villain_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences logindata;
  String? username;

  @override
  void initState(){
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString("username");
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if(index == 1){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const VillainPage();
      }));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Super Hero"),
            centerTitle: true,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.black,
            leading: InkWell(
              onTap: () {
                logindata.setBool("login", true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
            color: Colors.black87,
            padding: EdgeInsets.all(8),
            child: FutureBuilder(
              future: DataSource.instance.loadHeroes(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: $snapshot");
                }
                if (snapshot.hasData) {
                  DataModel moviesModel = DataModel.fromJson(snapshot.data);
                  return _buildSuccessSection(moviesModel);
                }
                return _buildLoadingSection();
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.white70,
            backgroundColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.gpp_good),
                label: 'Heroes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.warning),
                label: 'Villains',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.teal,
            onTap: _onItemTapped,
          ),
        )
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(DataModel data) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9/17,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20
      ),
      itemCount: data.data?.length,
      itemBuilder: (BuildContext context, int index) {
        final Data? heroes = data.data?[index];
        // String splice = "${data.data?[index].release_date}";
        // String result = splice.substring(0, 4);
        return InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context){
            //   return DetailPage(book: book);
            // }));
          },
          child:
          Card(
            child:
            Column(
              children: [
                Image.network(
                  "${heroes?.imgCover}",
                  fit: BoxFit.fill,
                  height: 260,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 20, 5),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "${heroes?.name}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      // fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 20, 5),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "${heroes?.bio?['publisher']}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 20, 5),
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                            Icons.calendar_today,
                            size: 13,
                            color: Colors.grey[700]
                        ),
                      ),
                      Text(
                        (heroes?.bio?['alignment'] == "good") ? "Hero" : "Villain",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 13,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey[700]
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        );
      }
    );
  }
}