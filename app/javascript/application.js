var app = angular.module('SMSMessengerApp', []);

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

        $scope.newMessage.recipient_phone = $scope.newMessage.recipient_phone.replace(/-/g, '');

        $http.post('/messages.json', $scope.newMessage).then(
            function (response) {
                $scope.messages.push(response.data);
                $scope.newMessage = {
                    recipient_phone: '',
                    text: ''
                };
                loadMessagesCount();
                loadMessages();
                $scope.errorMessage = '';
            },
            function (error) {
                console.error('Error:', error);
                $scope.errorMessage = 'Can not save!';
            }
        );
    };

    $scope.clear = function () {
        $scope.newMessage.recipient_phone = '';
        $scope.newMessage.text = '';
        $scope.errorMessage = '';
    };

    function isValidPhoneNumber(phoneNumber) {
        return /^\d{10}$/.test(phoneNumber) || /^\d{3}-\d{3}-\d{4}$/.test(phoneNumber);
    }

    function formatPhoneNumber(phoneNumber) {
        return phoneNumber.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
    }

    function loadMessagesCount() {
        $http.get('/messages/count.json').then(function (response) {
            $scope.messageCount = response.data.message_count;
        }, function (error) {
            console.error('Error', error);
        });
    }

    function loadMessages() {
        $http.get('/messages.json').then(function (response) {
            $scope.messages = response.data.map(message => {
                message.recipient_phone = formatPhoneNumber(message.recipient_phone);
                return message;
            });
        }, function (error) {
            console.error('Messages not loaded:', error);
        });
    }

    loadMessagesCount();
    loadMessages();
}]);
