/**
 * Returns the input date constraints that we enforce.
 *
 * We do not allow for dates to be before January 1, 1900, and we don't support
 * future dates.
 *
 * @return {Object} with a min date and a max date
 */
var getInputDateConstraints = function() {
  var today = new Date(),
      minDate = '1900-01-01',
      maxDate = today.getFullYear() + '-' + ('0' + today.getMonth()).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);

  return {
    'min': minDate,
    'max': maxDate
  };
};
/**
 * Changes a free form "text" field to a date field.
 *
 * This is to get around the way placeholder for a date field; we are not able
 * to modify the placeholder text of a date input type.
 *
 * Therefore a workaround is to use a `text` input field, and when the user
 * clicks into it, it becomes a `date` field.
 *
 * @param {HTMLInputElement} event - the input field
 */
var changeToDateInput = function(event, min, max) {
  var newType = 'date',
      constraints = getInputDateConstraints();

  event.type = newType;
  event.min = min || constraints['minDate'];
  event.max = max || constraints['maxDate'];

  return event;
};

/**
 * Checks to see if the date given is a valid date based on our constraints.
 *
 * @param {HTMLInputElement} event - the input field
 *
 */
var validateDate = function(event, min, max) {
  if (!event || !event.value) return;

  var constraints = getInputDateConstraints();
  var _date,
    hasError = false,
    _min = moment(min || constraints['min']),
    _max = moment(max || constraints['max']);

  try {
    _date = moment(event.value);

    hasError = _date < _min || _date > _max;
  } catch(e) {
    hasError = true;
  }

  if (hasError) {
    event.parentElement.classList.add('has-danger');
    event.parentElement.children.help.classList.remove('invisible');
  } else {
    event.parentElement.classList.remove('has-danger');
    event.parentElement.children.help.classList.add('invisible');
  }
};
