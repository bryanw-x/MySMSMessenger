var app = angular.module('myApp', []);

app.controller('MessagesController', ['$scope', '$http', function($scope, $http) {
  $scope.messages = [];
  $scope.newMessage = {};
  $scope.showNewMessageForm = false;

  $scope.loadMessages = function() {
    $http.get('/messages.json').then(function(response) {
      $scope.messages = response.data;
    });
  };

  $scope.sendMessage = function() {
    $http.post('/messages.json', $scope.newMessage).then(function(response) {
      $scope.messages.push(response.data);
      $scope.newMessage = {};
    }, function(error) {
      console.error('Error sending message:', error);
    });
  };

  $scope.loadMessages();
}]);
