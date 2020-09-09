mobiscroll.settings = {
  theme: 'ios',
  themeVariant: 'light'
};

var now = new Date(),
  currYear = now.getFullYear(),
  currMonth = now.getMonth(),
  currDay = now.getDate(),
  min = new Date(currYear, currMonth, currDay),
  max = new Date(currYear, currMonth + 6, currDay),
  firstload = true;


mobiscroll.calendar('#demo-booking-single', {
  display: 'inline',
  controls: ['calendar'],
  min: min,
  max: max,
  yearChange: false,
  responsive: {
      small: {
          months: 1
      },
      large: {
          months: 2
      }
  },
  onPageLoading: function (event, inst) {
      getPrices(event.firstDay, function callback(bookings) {
          inst.settings.labels = bookings.labels
          inst.settings.invalid = bookings.invalid;
          inst.redraw();
      });
  }
});

mobiscroll.calendar('#demo-booking-multiple', {
  display: 'inline',
  controls: ['calendar'],
  min: min,
  max: max,
  months: 'auto',
  yearChange: false,
  select: 'multiple',
  responsive: {
      small: {
          months: 1
      },
      large: {
          months: 2
      }
  },
  onInit: function (event, inst) {
      inst.setVal([
          new Date(currYear, currMonth, currDay + 1),
          new Date(currYear, currMonth, currDay + 5),
          new Date(currYear, currMonth, currDay + 6)
      ], true);
  },
  onPageLoading: function (event, inst) {
      getBookings(event.firstDay, function callback(bookings) {
          inst.settings.labels = bookings.labels
          inst.settings.invalid = bookings.invalid;
          inst.redraw();
      });
  }
});

mobiscroll.calendar('#demo-booking-recurring', {
  display: 'inline',
  controls: ['calendar', 'time'],
  min: min,
  max: max,
  labels: [],
  layout: 'fixed',
  calendarWidth: 400,
  cssClass: 'dm-calendar-booking',
  yearChange: false,
  steps: {
      hour: 2,
      minute: 60
  },
  responsive: {
      xsmall: {
          calendarWidth: undefined
      },
      medium: {
          rows: 7,
          circular: [false, false, false, true],
          calendarWidth: 400
      }
  },
  touchUi: false,
  timeFormat: 'h A',
  onInit: function (event, inst) {
      if (firstload) {
          mobiscroll.util.getJson('https://trial.mobiscroll.com/getrecbookings/', function (times) {
              // We are loading the available spots from a remote API. The data needs to be parsed and days need to be disabled.
              // In addition to that we'll have to display the number of available spots in lables plus update the time picker to only allow the valid selections.
              // The approach is to invalidate all times and override (make them valid) if that time slot is available for booking. (Think basketball court for two hours)
              var labels = [],
                  invalid = [],
                  valid = [];

              for (var i = 0; i < times.length; ++i) {
                  var time = times[i];
                  // set all times to invalid
                  invalid = invalid.concat({ d: 'w' + i, start: '00:00', end: '23:59' })

                  for (var j = 0; j < time.length; ++j) {
                      var t = time[j];
                      // override invalid values with valids
                      valid = valid.concat({ d: 'w' + i, start: t, end: t })
                  }

                  if (time.length === 0) {
                      // set day to invalid if there is no selectable time on that day
                      invalid = invalid.concat('w' + [i]);
                  } else {
                      // add the number of selectable times to labels
                      labels = labels.concat({ d: 'w' + i, text: time.length + ' SPOTS', background: 'none', color: '#e1528f' });
                  }
              }

              firstload = false;

              inst.option({
                  labels: labels,
                  invalid: invalid,
                  valid: valid
              });

          }, 'jsonp');
      }
  },
  onDayChange: function (event, inst) {
      inst.settings.colors = [{ d: 'w' + event.date.getDay(), background: '#e1528f' }]
      inst.redraw();
  }
});

function getPrices(d, callback) {
  var invalid = [],
      labels = [];

  mobiscroll.util.getJson('https://trial.mobiscroll.com/getprices/?year=' + d.getFullYear() + '&month=' + d.getMonth(), function (bookings) {
      for (var i = 0; i < bookings.length; ++i) {
          var booking = bookings[i],
              d = new Date(booking.d);

          if (booking.price > 0) {
              labels.push({
                  d: d,
                  text: '$' + booking.price,
                  background: 'none',
                  color: '#e1528f'
              });
          } else {
              invalid.push(d);
          }
      }
      callback({ labels: labels, invalid: invalid });
  }, 'jsonp');
}

function getBookings(d, callback) {
  var invalid = [],
      labels = [];

  mobiscroll.util.getJson('https://trial.mobiscroll.com/getbookings/?year=' + d.getFullYear() + '&month=' + d.getMonth(), function (bookings) {
      for (var i = 0; i < bookings.length; ++i) {
          var booking = bookings[i],
              d = new Date(booking.d);

          if (booking.nr > 0) {
              labels.push({
                  d: d,
                  text: booking.nr + ' SPOTS',
                  background: 'none',
                  color: '#e1528f'
              });
          } else {
              invalid.push(d);
          }
      }
      callback({ labels: labels, invalid: invalid });
  }, 'jsonp');
}