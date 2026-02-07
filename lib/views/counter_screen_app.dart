import '../index.dart';

class CounterScreenApp extends StatefulWidget {
  const CounterScreenApp({super.key});

  @override
  State<CounterScreenApp> createState() => _CounterScreenAppState();
}

class _CounterScreenAppState extends State<CounterScreenApp> {

  final counters = Hive.box('CounterBox');

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CallingProvider>(context, listen: false).startPolling();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: SizeConfig.screenWidth * 1,
          height: SizeConfig.screenHeight * 1,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          color: bgColor,
          child: ValueListenableBuilder(valueListenable: counters.listenable(), builder: (context, value, _) {
            final countersData = counters.get('countersData');
            if(countersData != null){return GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: countersData.length == 1 ? 1 :countersData.length == 2 ? 2 : 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: countersData.length == 1 ? 20/ 10 : countersData.length == 2 ? 18/ 20  : countersData.length > 6 ? 20/ 11 : 20/ 18
              ),
              itemCount: countersData.length,
              itemBuilder: (context, index) {
                return Container(
                  width: SizeConfig.screenWidth * 0.23,
                  height: SizeConfig.screenHeight * 0.12,
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: textColor.withValues(alpha: 0.2),
                            spreadRadius: 0.4,
                            blurRadius: 10
                        )
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("Counter ${countersData[index]["CounterID"]}",style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.5,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor
                      ),),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: countersData[index]["TicketNumber"] == "-1" ? primaryColor : countersData[index]["TicketNumber"] == "0" ? secondaryColor : secondaryColor
                        ), child: Text(countersData[index]["TicketNumber"] == "-1" ? "Offline" : countersData[index]["TicketNumber"] == "0000" ? "Ready" : "Serving",style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 0.6,
                          fontWeight: FontWeight.w600,
                          color: bgColor
                      ),),
                      ),
                      Text(countersData[index]["TicketNumber"] == "-1" ? "----" : countersData[index]["TicketNumber"] == "0" ? "0000" : countersData[index]["TicketNumber"],style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 2,
                          fontWeight: FontWeight.w600,
                          color: primaryColor
                      ),),

                    ],
                  ),
                );
              },);}
            else {
              return const Center(child: Text("Getting Counter Details"),);
            }
          },)
      ),
    );
  }
}
