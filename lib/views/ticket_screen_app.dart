import '../index.dart';

class CategorySection extends StatefulWidget {
  final String title;
  final int startIndex;
  final int endIndex;

  const CategorySection({
    super.key,
    required this.title,
    required this.startIndex,
    required this.endIndex,
  });

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {

  final counters = Hive.box('CounterBox');
  List countersByCategory = [];

  @override
  void initState() {
    // TODO: implement initState
    final counter = counters.get('countersData');

    for(int start = widget.startIndex; start <= widget.endIndex; start++){
      final singleCounter = counter.firstWhere((item) => item['CounterID'] == start);
      if (singleCounter != null) {
        countersByCategory.add(singleCounter);
      }
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: SizeConfig.screenWidth * 1,
      height: SizeConfig.screenHeight * 0.33,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Title
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: Text(
              widget.title,
              style:  TextStyle(
                fontSize: SizeConfig.textMultiplier * 4,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
            ),
          ),

          // Tickets Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(countersByCategory.length, (index) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: TicketCard(
                    counter: countersByCategory[index]['CounterID'],
                    ticketNumber: countersByCategory[index]['TicketNumber'],
                  ),
                ),
              );
            },),
          ),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final int counter;
  final String ticketNumber;

  const TicketCard({
    super.key,
    required this.counter,
    required this.ticketNumber,
  });

  Color getStatusColor() {
    switch (ticketNumber) {
      case '0':
        return const Color(0xFF00EF91);
      case '-1':
        return Colors.grey;
      default:
        return Color(0xFFFF6892);
    }
  }

  String getStatusText() {
    switch (ticketNumber) {
      case '0000':
        return 'Active';
      case '-1':
        return 'Offline';
      default:
        return 'Serving';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Counter with green background
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF00EF91),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Counter $counter',
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),

          // Ticket Number in pink
          Column(
            children: [
              Text(
                'Ticket No.',
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 2,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                ticketNumber,
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 4.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6892),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Status
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: getStatusColor(),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                getStatusText(),
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 2.2,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


