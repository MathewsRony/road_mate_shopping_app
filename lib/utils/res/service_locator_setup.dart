import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:road_mate_shopping_app/rest_api/home_page/home_page_rest_api.dart';
import 'package:road_mate_shopping_app/rest_api/home_page/home_page_service.dart';

/// register all services here

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  final gh = GetItHelper(locator, null, null);
  gh.lazySingleton<HomePageService>(() => HomePageRestApi());
}

HomePageService homePageService = locator<HomePageService>();
