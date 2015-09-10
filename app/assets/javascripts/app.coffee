receta = angular.module('receta',[
  'templates', 
  'ngRoute', 
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])
receta.config([ '$routeProvider', 'flashProvider',
    ($routeProvider, flashProvider)->
      flashProvider.errorClassnames.push("alert-danger")
      flashProvider.warnClassnames.push("alert-warn")
      flashProvider.infoClassnames.push("alert-info")
      flashProvider.successClassnames.push("alert-success")
      
      $routeProvider
        .when('/', 
          templateUrl: "index.html"
          controller: 'RecipesController'
        ).when('/recipes/new',
          templateUrl: "form.html"
          controller: 'RecipesController'
        ).when('/recipes/:recipeId',
          templateUrl: "show.html"
          controller: 'RecipesController'
        ).when('/recipes/:recipeId/edit',
          templateUrl: "form.html"
          controller: 'RecipesController'
        )
])
controllers = angular.module('controllers',[])
