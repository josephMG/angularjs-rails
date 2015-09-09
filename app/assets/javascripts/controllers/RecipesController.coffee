controllers = angular.module('controllers')

controllers.controller("RecipesController", [ '$scope', '$routeParams', '$location', '$resource', 'flash'
  ($scope,$routeParams,$location,$resource, flash)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    Recipe = $resource('/recipes/:recipeId', { recipeId: "@id", format: 'json' })
    
    if $routeParams.keywords
      Recipe.query(keywords: $routeParams.keywords, (results)-> $scope.recipes = results)
    else if $routeParams.recipeId
      Recipe.get({recipeId: $routeParams.recipeId},
        ( (recipe) -> $scope.recipe = recipe),
        ( (httpResponse) -> 
            $scope.recipe = null
            flash.error = "There is no recipe with ID #{$routeParams.recipeId}"
        )
      )
    else
      $scope.recipes = []
])
