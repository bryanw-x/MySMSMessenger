var app = angular.module('myApp', []);

app.controller('MessagesController', function($scope, $http) {
  $http.get('/messages.json').then(function(response) {
    $scope.messages = response.data;
  });
});
