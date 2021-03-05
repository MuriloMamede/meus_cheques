
import 'package:meuscheques/app/provider/bank_provider.dart';

class BankRepository {

final BankApiClient apiClient = BankApiClient();



getBanks(){
  return apiClient.getBanks();
}
save(obj){
  return apiClient.save(obj);
}
delete(id){
  return apiClient.delete(id);
}
edit(obj){
  return apiClient.edit( obj );
}


}