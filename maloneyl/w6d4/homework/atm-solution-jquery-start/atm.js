$(function() {

  var checkingBalance = 0;
  var savingsBalance = 0;

  function getDepositAmountForChecking() {
    amount = parseInt($("#checking-amount").val());
    checkingBalance += amount;
    updateDisplay();
  };

  function getDepositAmountForSavings() {
    amount = parseInt($("#savings-amount").val());
    savingsBalance += amount;
    updateDisplay();
  };

  function getWithdrawAmountForChecking() {
    amount = parseInt($("#checking-amount").val());
    balances = withdrawFunds(amount, checkingBalance, savingsBalance);
    checkingBalance = balances[0];
    savingsBalance = balances[1];
    updateDisplay();
  };

  function getWithdrawAmountForSavings() {
    amount = parseInt($("#savings-amount").val());
    balances = withdrawFunds(amount, savingsBalance, checkingBalance);
    savingsBalance = balances[0];
    checkingBalance = balances[1];
    updateDisplay();
  };

  function withdrawFunds(amount, primary, secondary) {
  if (amount <= primary) {
    primary = primary - amount;
  } else if ((amount > primary) && (amount <= (secondary + primary))) {
    secondary = (primary + secondary) - amount;
    primary = 0;
  }
  return [primary, secondary];
}

  function updateDisplay() {
    var $element = $("#checking-balance");
    if (checkingBalance <= 0) {
      $element.addClass('zero');
    } else {
      $element.removeClass('zero');
    }

    var $element2 = $("#savings-balance");
    if (savingsBalance <= 0) {
      $element.addClass('zero');
    } else {
      $element.removeClass('zero');
    }

    $("#checking-balance").text("$" + checkingBalance);
    $("#savings-balance").text("$" + savingsBalance);
    $("#checking-amount").val("");
    $("#savings-amount").val("");
  };

  $("#checking-deposit").on("click", getDepositAmountForChecking);
  $("#savings-deposit").on("click", getDepositAmountForSavings);
  $("#checking-withdraw").on("click", getWithdrawAmountForChecking);
  $("#savings-withdraw").on("click", getWithdrawAmountForSavings);

})
