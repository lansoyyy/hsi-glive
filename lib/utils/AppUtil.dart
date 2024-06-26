// ignore_for_file: file_names

import 'package:glive/models/app/BalanceModel.dart';
import 'package:glive/models/database/FundModel.dart';
import 'package:glive/models/database/TransactionModel.dart';
import 'package:glive/repositories/fundRepository.dart';
import 'package:glive/repositories/TransactionRepository.dart';
import 'package:glive/utils/commonFunctions.dart';

class AppUtil {
  static Future<BalanceModel> loadBalance(String fundsId) async {
    List<List> responses = [];
    if (isSuperAdmin()) {
      responses = await Future.wait([FundRepository.getAll(), TransactionRepository.getAll()]);
    } else {
      responses = await Future.wait([
        FundRepository.getAllByFundId(fundsId),
        TransactionRepository.getAllByFundId(fundsId),
      ]);
    }
    List<FundModel> fundModels = responses[0] as List<FundModel>;
    List<TransactionModel> transactionModels = responses[1] as List<TransactionModel>;
    List allModels = [...fundModels, ...transactionModels];

    allModels.sort((a, b) => DateTime.parse(a.createdAt).compareTo(DateTime.parse(b.createdAt)));

    double tempDonated = 0;
    double tempFunds = 0;

    for (var element in allModels) {
      if (element is FundModel) {
        if (element.type == "adjust") {
          tempFunds = tempFunds + int.parse(element.amount);
        }
      }
      if (element is TransactionModel) {
        if (element.status == "success") {
          tempDonated = tempDonated + int.parse(element.amount);
          tempFunds -= int.parse(element.amount);
        }
      }
    }

    return BalanceModel(funds: tempFunds, donated: tempDonated);
  }
}
