import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabungan_frontend/core/models/transaction_model.dart';
import 'package:tabungan_frontend/core/repositories/transaction_repository.dart';
import 'package:tabungan_frontend/features/dashboard/app_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, this.animationController});

  final AnimationController? animationController;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            _buildAppBar(),
            Expanded(
              child: ValueListenableBuilder<List<TransactionModel>>(
                valueListenable: TransactionRepository().transactionsNotifier,
                builder: (context, transactions, child) {
                  if (transactions.isEmpty) {
                    return const Center(
                      child: Text(
                        'Belum ada riwayat transaksi',
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontSize: 16,
                          color: AppTheme.grey,
                        ),
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      top: 8, 
                      bottom: 62 + MediaQuery.of(context).padding.bottom,
                    ),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final int count = transactions.length > 10 ? 10 : transactions.length;
                      final int effectiveIndex = index < count ? index : count - 1;
                      
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: widget.animationController ?? const AlwaysStoppedAnimation(1.0),
                          curve: Interval(
                            (1 / count) * effectiveIndex, 
                            1.0,
                            curve: Curves.fastOutSlowIn
                          ),
                        ),
                      );
                      
                      widget.animationController?.forward();

                      return _HistoryItemView(
                        transaction: transactions[index],
                        animation: animation,
                        animationController: widget.animationController,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Laporan dan Riwayat',
            style: TextStyle(
              fontFamily: AppTheme.fontName,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppTheme.darkText,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryItemView extends StatelessWidget {
  const _HistoryItemView({
    super.key,
    required this.transaction,
    required this.animationController,
    required this.animation,
  });

  final TransactionModel transaction;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final isDeposit = transaction.type == TransactionType.deposit;
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    final dateFormatter = DateFormat('dd MMM yyyy, HH:mm', 'id_ID');

    final card = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.grey.withOpacity(0.1),
              offset: const Offset(2.0, 4.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDeposit
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isDeposit ? Colors.green : Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction.description.isNotEmpty
                          ? transaction.description
                          : (isDeposit ? 'Pemasukan' : 'Pengeluaran'),
                      style: const TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppTheme.darkText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          dateFormatter.format(transaction.date),
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppTheme.grey.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.nearlyBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            transaction.sumberDana,
                            style: const TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: AppTheme.nearlyBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${isDeposit ? '+' : '-'}${currencyFormatter.format(transaction.amount)}',
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: isDeposit ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (animationController == null || animation == null) {
      return card;
    }

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: card,
          ),
        );
      },
    );
  }
}
