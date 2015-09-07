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
#          templateUrl: "<%= asset_path('templates/index.html') %>"
          templateUrl: "index.html"
          controller: 'RecipesController'
        )
])
controllers = angular.module('controllers',[])
