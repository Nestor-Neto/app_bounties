import 'dart:async';
import 'package:app_bounties/app/modules/models/user/user.dart';
import 'package:mobx/mobx.dart';
import 'package:app_bounties/app/modules/repository/repository_interface.dart';
part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  HomeStoreBase(this.dataRepository);

  final IRepository dataRepository;

  @observable
  int counter = 1;
  int counter02 = 0;
  int sizeList = 0;

  @observable
  String displayedUserData = '';

  @observable
  bool isLoading = false;

  @observable
  bool isInit = false;

  @observable
  String textButton = "Carregar Usuário";

  List<User>? usersData = [];

  void init() async {
    usersData = await dataRepository.getAllUsers().catchError((error) {
      throw error;
    });
    sizeList = usersData!.length + 2;
  }

  Future<void> incrementCounterAndFetchUser() async {
    isLoading = true;

    for (var user in usersData!) {
      if (user.id == counter) {
        displayedUserData =
            'ID: ${user.id} \nNome: ${user.name} \nEmail: ${user.email}';
        counter++;
        isLoading = false;
        textButton = 'Carregar Próximo Usuário';
        break;
      } else {
        counter02++;
      }
    }

    if (sizeList == counter) {
      displayedUserData = 'Fim da lista, Não existe usuário!';
      isInit = true;
      isLoading = false;
      textButton = 'iniciar novamente';
    } else if (counter > usersData!.length) {
      counter++;
    }
    isLoading = false;
  }

  void reset() async {
    isLoading = false;
    usersData = [];
    init();
    isInit = false;
    displayedUserData = '';
    textButton = "Carregar Usuário";
    counter = 1;
    sizeList = 0;
  }
}
