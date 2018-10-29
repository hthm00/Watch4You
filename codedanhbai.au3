$("#mfInputAmount").val((0.0009).toFixed(4));
rollDice = function() {
if ($('.label-danger').text() !== '') {
$('#input-group-addonb').click();
} else if ($('.label-success').text() !== '') {
$("#mfInputAmount").val((0.0009).toFixed(4));
}
$('.margin-top-lg').click();
setTimeout(rollDice, 4000);
};
rollDice();