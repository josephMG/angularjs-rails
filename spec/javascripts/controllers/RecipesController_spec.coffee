describe "RecipesController", ->
  scope       = null
  ctrl        = null
  routeParams = null
  location    = null
  httpBackend = null

  flash       = null
  recipeId = 42

  fakeRecipe = 
    id: recipeId
    name:"Baked Potatoes"
    instruections: "Pierce potato with fork, nuke for 20 minutes"
  
  setupController2 = (recipeExists = true) ->
    inject(($location,$routeParams, $rootScope, $httpBackend, $controller, _flash_) -> 
      ######
      #because this component isn't provided by Angular, its name —for dependency injection purposes—is also flash
      #so using _flash_ 
      ######
      
      scope       = $rootScope.$new()
      httpBackend = $httpBackend
      location = $location
      routeParams = $routeParams
      routeParams.recipeId = recipeId
      flash = _flash_
      request = new RegExp("\/recipes/#{recipeId}")
      
      results = if recipeExists
        [200, fakeRecipe]
      else
        [404]
      
      httpBackend.expectGET(request).respond(results[0],results[1])
      
      ctrl        = $controller('RecipesController',
                                $scope: scope)
    )
  
  setupController = (keywords, results) ->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller) -> 
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      httpBackend = $httpBackend

      if results
        request = new RegExp("\/recipes.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('RecipesController',
                                $scope: scope
                                $location: location)
    )
 

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()
  
  beforeEach(module("receta"))

  describe 'controller initialization', ->
    describe 'recipe is found', ->
      beforeEach(setupController2())
      it 'loads the given recipe', ->
        httpBackend.flush()
        expect(scope.recipe).toEqualData(fakeRecipe)
    describe 'recipe is not found', ->
      beforeEach(setupController2(false))
      it 'loads the given recipe', ->
        httpBackend.flush()
        expect(scope.recipe).toBe(null)
        #what else?!
        expect(flash.error).toBe("There is no recipe with ID #{recipeId}")
    describe 'when no keywords present', ->
      beforeEach ->
        setupController(null,null)
 
      it 'defaults to no recipes', ->
        expect(scope.recipes).toEqualData([])

    describe 'with keywords', ->
      keywords = 'foo'
      recipes = [
        {
          id: 2
          name: 'Baked Potatoes'
        },
        {
          id: 4
          name: 'Potatoes Au Gratin'
        }
      ]
      beforeEach ->
        setupController(keywords,recipes)
        httpBackend.flush()
    
      it 'calls the back-end', ->
        expect(scope.recipes).toEqualData(recipes)
 
  describe 'search()', ->
    beforeEach ->
      setupController(null,null)
    
    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe('/')
      expect(location.search()).toEqualData({keywords: keywords})

