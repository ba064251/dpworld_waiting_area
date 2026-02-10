import '../index.dart';

class CounterScreenApp extends StatefulWidget {
  const CounterScreenApp({super.key});

  @override
  State<CounterScreenApp> createState() => _CounterScreenAppState();
}

class _CounterScreenAppState extends State<CounterScreenApp> {

  final counters = Hive.box('CounterBox');
  final counterCategory = Hive.box('CounterCategoryBox');

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CallingProvider>(context, listen: false).startPolling();
      Provider.of<CallingProvider>(context, listen: false).getCategoryCounter();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = counterCategory.get('countersCateData');
    return Scaffold(
      body: categoryData.length != null ? Container(
          width: SizeConfig.screenWidth * 1,
          height: SizeConfig.screenHeight * 1,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          color: bgColor,
          child: ListView.builder(
            itemCount: categoryData.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return categoryData != null ? CategorySection(title: categoryData[index]['categorytitle'],startIndex: categoryData[index]['Start_Index'], endIndex: categoryData[index]['End_Index'],) :
              Center(child: Text('Nothing to show...'),);
            },)
      ) : Center(child: Text('Screen is not Initialized'),),
    );
  }
}
