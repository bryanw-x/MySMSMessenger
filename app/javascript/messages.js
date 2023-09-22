var app = angular.module('myApp', []);

app.config(['$httpProvider', function ($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = angular.element('meta[name=csrf-token]').attr('content');
}]);

app.controller('MessagesController', ['$scope', '$http', function ($scope, $http) {
    $scope.newMessage = {
        recipient_phone: '',
        text: ''
    };

    $scope.errorMessage = '';
    $scope.messages = [];

    $scope.sendMessage = function () {
        if (!isValidPhoneNumber($scope.newMessage.recipient_phone)) {
            $scope.errorMessage = 'Invalid phone number';
            return;
        }

        $http.post('/messages.json', $scope.newMessage).then(
            function (response) {
                $scope.messages.push(response.data);
                $scope.newMessage = {
                    recipient_phone: '',
                    text: ''
                };
                grabMessagesCount();
                grabMessages();
                $scope.errorMessage = '';
            },
            function (error) {
                console.error('Error:', error);
                $scope.errorMessage = 'An error occurred while sending the message. Please try again later.';
            }
        );
    };

    $scope.clear = function () {
        $scope.newMessage.recipient_phone = '';
        $scope.newMessage.text = '';
        $scope.errorMessage = '';
    };

    function isValidPhoneNumber(phoneNumber) {
        return /^\d{10}$/.test(phoneNumber);
    }

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
}]);
