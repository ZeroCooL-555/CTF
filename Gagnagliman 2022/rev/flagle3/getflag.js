var flag = [];
var filter_index = 0;
const alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-={}";

function get_flag() {
	for (let i = 0; i < alphabet.length; i++) {
		var letter = alphabet[i];
		var check_letter = CheckInFilter(letter, filter_index);
		if (check_letter == true) {
			flag.push(letter);
			filter_index = filter_index + 1;
			i = 0
			if (filter_index == 23) {
				break;
			}
		}
	}
	return console.log(flag.join(''));
}
