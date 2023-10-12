import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/debouncer.dart';
import 'package:kvn_farm_rich/app/models/team_model.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';

class MyTeamController extends GetxController {
  var isLoading = false.obs;
  var teamlist = <TeamDetails>[].obs;
  var searchList = <TeamDetails>[].obs;
  String keyword = '';
  @override
  void onInit() {
    getTeam();

    super.onInit();
  }

  getTeam() async {
    isLoading(true);
    teamlist.clear();
    try {
      final response = await ApiProvider().getTeam(
          Session.userId, Session.roleId, Session.roleId == '5' ? "" : "team");
      if (response != null) {
        if (response.status == true) {
          teamlist.addAll(response.data);
          searchList.addAll(response.data);
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  final debouncer = Debouncer(milliseconds: 1000);
  Future<void> search(String value) async {
    keyword = value.toUpperCase().toLowerCase().trim();
    debouncer.run(() {
      teamlist.value = searchList
          .where((element) => element.name
              .toString()
              .toUpperCase()
              .toLowerCase()
              .contains(value.toUpperCase().toLowerCase()))
          .toList();
    });
  }
}
