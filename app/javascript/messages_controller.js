var app = angular.module('myApp', []);

app.config(['$httpProvider', function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = angular.element('meta[name=csrf-token]').attr('content');

}]);

app.controller('MessagesController', function($scope, $http) {
  $scope.newMessage = {};

  $scope.sendMessage = function() {
    $http.post('/messages.json', $scope.newMessage).then(function(response) {
      $scope.messages.push(response.data);
      $scope.newMessage = {};
    }, function(error) {
      console.error('Error:', error);
    });
 };

  $http.get('/messages.json').then(function(response) {
    $scope.messages = response.data;
  });
});
