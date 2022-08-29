/**
 TextField(
                cursorColor: Color(0xFF0D111A),
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    filled: true,
                    fillColor: Color(0xFF263240),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "  eg: Sunburn",
                    suffixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                    suffixIconColor: Colors.white),
              ),
 */

/**
 Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: dataStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      // TODO: add snackbar
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final List storedocs = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      storedocs.add(a);
                      a['id'] = document.id;
                    }).toList();

                    return Column(children: [
                      ListView.builder(
                        itemCount: storedocs.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [Text(storedocs[index]["EN"])],
                          );
                        },
                      )
                    ]);
                  },
                ),
              ),
 */

/**
 SafeArea(
          child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
            ]),
      )),
 */
/* 
final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('Events').snapshots(); 
        */