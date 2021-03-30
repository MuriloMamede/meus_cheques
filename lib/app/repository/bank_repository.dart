
import 'package:meuscheques/app/provider/bank_provider.dart';

class BankRepository {

final BankApiClient apiClient = BankApiClient();



getBanks(){
  return apiClient.getBanks();
}
save(bank){
  return apiClient.save(bank);
}
delete(id){
  return apiClient.delete(id);
}
edit(bank){
  return apiClient.edit( bank );
}


}