import 'package:samip_grubrr/network/api_helper.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';

class ApiRepo {
  final String _loginEndpoint = 'BranchLogin';

  Future<Map<String, dynamic>> loginUser(
      {required String userName, required String password}) async {
    Map<String, String> body = {
      BaseApiConstants.password: password,
      BaseApiConstants.username: userName,
      BaseApiConstants.appVersion: '1.0',
      BaseApiConstants.deviceType: '1',
      BaseApiConstants.deviceId: 'c4db5cb7e4a46365',
      BaseApiConstants.moduleId: '1',
      BaseApiConstants.fcmId:
          'ef5Dk7VIGsU:APA91bHhPJLrfv2oLhMCT8geh1v0sZGZyvtGXMvU_AAV6ncep3O_g1po0n1Wy_ACNm5HLv6KEjJgZ8I-SNJZnZ5wp1Bsz_QQi82YUTy8-0IwctLICHz_Zy49NBV0OowslifNcgrahad5',
    };
    Map<String, String> _header = {'Version': '1'};
    try {
      final res = await ApiBaseHelper()
          .apiPost(_loginEndpoint, body, _header, isAuthenticated: false);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
