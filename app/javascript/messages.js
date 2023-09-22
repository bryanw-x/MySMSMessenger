var app = angular.module('myApp', []);

app.config(['$httpProvider', function ($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = angular.element('meta[name=csrf-token]').attr('content');
}]);

app.controller('MessagesController', function ($scope, $http) {
    $scope.newMessage = {
        to: '',
        text: ''
    };

    $scope.sendMessage = function () {
        $http.post('/messages.json', $scope.newMessage).then(function (response) {
            $scope.messages.push(response.data);
            $scope.newMessage = {
                to: '',
                text: ''
            };
        }, function (error) {
            console.error('Error:', error);
        });
    };

    $scope.clear = function() {
        $scope.newMessage.recipient_phone= '';
        $scope.newMessage.text = '';
    };

    function grabMessagesCount() {
        $http.get('/messages/count.json').then(function (response) {
            $scope.messageCount = response.data.message_count;
        }, function (error) {
            console.error('Error', error);
        });
    }

    function grabMessages() {
        $http.get('/messages.json').then(function (response) {
            $scope.messages = response.data;
        }, function (error) {
            console.error('Messages not loaded:', error);
        });
    }

    grabMessagesCount();
    grabMessages();
});
