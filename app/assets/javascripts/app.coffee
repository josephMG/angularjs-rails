receta = angular.module('receta',[
  'templates', 
  'ngRoute', 
  'ngResource',
  'controllers',
])
receta.config([ '$routeProvider',
    ($routeProvider)->
      $routeProvider
        .when('/', 
          templateUrl: "index.html"
          controller: 'RecipesController'
        ).when('/recipes/:recipeId',
          templateUrl: "show.html"
          controller: 'RecipesController'
        )
])
controllers = angular.module('controllers',[])
