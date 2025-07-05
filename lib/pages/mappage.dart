import 'package:duitse_gym_app/data/json.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int? selectedStudioIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.green.shade100,
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      "Studios",
                      style: TextStyle(fontSize: 28),
                    ),
                    Text("We have extended our opening hours"),
                    Text(
                      "June 2",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: closeBottomSheet,
                      child: Image.asset(
                        "assets/Map.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  Positioned(
                    top: 70,
                    left: 50,
                    child: InkWell(
                      onTap: () => showStudio(0),
                      child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.green.shade100,
                        child: Image.asset("assets/Icon.png"),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 120,
                    left: 110,
                    child: InkWell(
                      onTap: () => showStudio(1),
                      child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.green.shade100,
                        child: Image.asset("assets/Icon.png"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: selectedStudioIndex != null ? BottomSheet(
        onClosing: closeBottomSheet,
        builder: (context) {
          return Container(
            height: 500,
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: DataLoader.getStudios(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (!snapshot.hasData || snapshot.data == null || selectedStudioIndex! >= snapshot.data!.length) {
                  return const Center(child: Text('Studio information not available'));
                }
                
                final studio = snapshot.data![selectedStudioIndex!];
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          studio.name,
                          style: const TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              selectedStudioIndex = null;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: studio.openingHours.length,
                        itemBuilder: (context, index) {
                          final day = studio.openingHours.keys.elementAt(index);
                          final hours = studio.openingHours[day];
                          
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    day,
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(hours == null ? 'Closed' : '${hours.from} - ${hours.until}'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 150,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: () {
                                      final days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
                                      final today = days[DateTime.now().weekday - 1];
                                      final todayHours = studio.openingHours[today];
                                      
                                      if (todayHours == null) {
                                        return <Widget>[];
                                      }
                                      
                                      return List.generate(
                                        todayHours.occupancies.length,
                                        (index) {
                                          final occupancyValue = todayHours.occupancies[index];
                                          final occupancyHeight = occupancyValue.toDouble();
                                          final maxHeight = 120.0;
                                          final int firstHour = int.tryParse(todayHours.from.split(":")[0]) ?? 8;
                                          final int hour = index + firstHour;
                                          
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing: 5,
                                            children: [
                                              Container(
                                                width: 20,
                                                height: (occupancyHeight / 100) * maxHeight,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: Colors.green.shade400,
                                                ),
                                              ),
                                              Text(
                                                '$hour',
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          );
        },
      ) : null,
    );
  }

  void closeBottomSheet() {
    setState(() {
      selectedStudioIndex = null;
    });
  }

  void showStudio(int index) {
    setState(() {
      selectedStudioIndex = index;
    });
  }
}