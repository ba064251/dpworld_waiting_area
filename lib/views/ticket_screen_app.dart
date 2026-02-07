import '../index.dart';
class TicketScreenApp extends StatelessWidget {
  const TicketScreenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Category 1
    final category1Tickets = [
      {'counter': 'Counter 1', 'ticketNumber': 'A001', 'status': 'active'},
      {'counter': 'Counter 2', 'ticketNumber': 'A002', 'status': 'offline'},
      {'counter': 'Counter 3', 'ticketNumber': 'A003', 'status': 'active'},
      {'counter': 'Counter 4', 'ticketNumber': 'A004', 'status': 'pending'},
      {'counter': 'Counter 5', 'ticketNumber': 'A005', 'status': 'active'},
    ];

    // Category 2
    final category2Tickets = [
      {'counter': 'Counter 1', 'ticketNumber': 'B001', 'status': 'active'},
      {'counter': 'Counter 2', 'ticketNumber': 'B002', 'status': 'active'},
      {'counter': 'Counter 3', 'ticketNumber': 'B003', 'status': 'offline'},
      {'counter': 'Counter 4', 'ticketNumber': 'B004', 'status': 'expired'},
      {'counter': 'Counter 5', 'ticketNumber': 'B005', 'status': 'pending'},
    ];

    // Category 3
    final category3Tickets = [
      {'counter': 'Counter 1', 'ticketNumber': 'C001', 'status': 'offline'},
      {'counter': 'Counter 2', 'ticketNumber': 'C002', 'status': 'active'},
      {'counter': 'Counter 3', 'ticketNumber': 'C003', 'status': 'active'},
      {'counter': 'Counter 4', 'ticketNumber': 'C004', 'status': 'active'},
      {'counter': 'Counter 5', 'ticketNumber': 'C005', 'status': 'pending'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Main Title
              Column(
                children: [
                  const Text(
                    'Ticket Management',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 2,
                    width: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00EF91), Color(0xFFFF6892)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Categories - evenly spaced
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Category 1
                    CategorySection(
                      title: 'Category 1',
                      tickets: category1Tickets,
                    ),

                    // Category 2
                    CategorySection(
                      title: 'Category 2',
                      tickets: category2Tickets,
                    ),

                    // Category 3
                    CategorySection(
                      title: 'Category 3',
                      tickets: category3Tickets,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> tickets;

  const CategorySection({
    Key? key,
    required this.title,
    required this.tickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Title
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000),
            ),
          ),
        ),

        // Tickets Row
        Row(
          children: tickets.map((ticket) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: TicketCard(
                  counter: ticket['counter']!,
                  ticketNumber: ticket['ticketNumber']!,
                  status: ticket['status']!,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class TicketCard extends StatelessWidget {
  final String counter;
  final String ticketNumber;
  final String status;

  const TicketCard({
    Key? key,
    required this.counter,
    required this.ticketNumber,
    required this.status,
  }) : super(key: key);

  Color getStatusColor() {
    switch (status) {
      case 'active':
        return const Color(0xFF00EF91);
      case 'offline':
        return Colors.grey;
      case 'pending':
        return const Color(0xFFFF6892);
      case 'expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatusText() {
    switch (status) {
      case 'active':
        return 'Active';
      case 'offline':
        return 'Offline';
      case 'pending':
        return 'Pending';
      case 'expired':
        return 'Expired';
      default:
        return status;
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
              counter,
              style: const TextStyle(
                fontSize: 9,
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
                  fontSize: 8,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                ticketNumber,
                style: const TextStyle(
                  fontSize: 14,
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
                  fontSize: 8,
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
