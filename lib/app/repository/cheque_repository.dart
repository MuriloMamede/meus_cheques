

import 'package:meuscheques/app/provider/cheque_provider.dart';


class ChequeRepository {

final ChequeApiClient apiClient = ChequeApiClient();



getCheques(accountReference){
  return apiClient.getCheques(accountReference);
}
save(obj){
  return apiClient.save(obj);
}
delete(int chequeNumber,int acountId){
  return apiClient.delete(chequeNumber,acountId);
}
edit(obj){
  return apiClient.edit( obj );
}


}