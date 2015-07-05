angular.module("SWAT").factory "ConfirmationDialog", ($modal)->
  (message, action)->
    $modal.open(
      size: 'sm',
      templateUrl: '/swat/pages/management/confirmation.html',
      controller: 'ConfirmationCtrl',
      resolve:
        action: -> action
        message: -> message
    )