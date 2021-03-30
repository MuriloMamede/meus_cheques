
import 'package:meuscheques/app/provider/bank_account_provider.dart';


class BankAccountRepository {

final BankAccountApiClient apiClient = BankAccountApiClient();



getBanksAccounts(bankNumber){
  return apiClient.getBanksAccounts(bankNumber);
}
save(bankAccount){
  return apiClient.save(bankAccount);
}
delete(id){
  return apiClient.delete(id);
}
edit(bankAccount){
  return apiClient.edit( bankAccount );
}


}