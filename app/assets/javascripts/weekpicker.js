var weekpicker = $(function() {
    var endDate, selectCurrentWeek, startDate;
    startDate = void 0;
    endDate = void 0;
    selectCurrentWeek = function() {
        window.setTimeout((function() {
            $('#weekpicker').datepicker('widget').find('.ui-datepicker-current-day a').addClass('ui-state-active');
        }), 1);
    };
    $('#weekpicker').datepicker({
        showOtherMonths: false,
        selectOtherMonths: false,
        onSelect: function(dateText, inst) {
            var date, dateFormat;
            date = $(this).datepicker('getDate');
            startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 1);
            endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 7);
            dateFormat = "dd-mm-yy"
            $('#weekpicker').val($.datepicker.formatDate(dateFormat, startDate, inst.settings) + ' - ' + $.datepicker.formatDate(dateFormat, endDate, inst.settings));
            selectCurrentWeek();
        },
        beforeShow: function() {
            selectCurrentWeek();
        },
        beforeShowDay: function(date) {
            var cssClass;
            cssClass = '';
            if (date >= startDate && date <= endDate) {
                cssClass = 'ui-datepicker-current-day';
            }
            return [true, cssClass];
        },
        onChangeMonthYear: function(year, month, inst) {
            selectCurrentWeek();
        }
    }).datepicker('widget').addClass('ui-weekpicker');
    $('.ui-weekpicker .ui-datepicker-calendar tr').on('mousemove', null, function() {
        $(this).find('td a').addClass('ui-state-hover');
    });
    $('.ui-weekpicker .ui-datepicker-calendar tr').on('mouseleave', null, function() {
        $(this).find('td a').removeClass('ui-state-hover');
    });
});

$(document).ready(weekpicker);
$(document).on('turbolinks:load', weekpicker);