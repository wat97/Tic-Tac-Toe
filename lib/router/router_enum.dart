enum RouterPath { splash, login, dashboard, planGeneral }

class RouterNavigation {
  static get routesplash => '/${RouterPath.splash.name}';
  static get routelogin => '/${RouterPath.login.name}';
  static get routedashboard => '/${RouterPath.dashboard.name}';
  static get routeplangeneral => '/${RouterPath.planGeneral.name}';
}
