/**
 * E-SECO THEME CORE JAVASCRIPT
 */

/**
 * Set Input Masks throught jquery.maskedinput
 *
 * @param jQuery
 */
function setInputMasks(jQuery) {
    jQuery(".datepicker").mask("9999/99/99", {placeholder: "yyyy/mm/dd"});
    jQuery('.datepicker').datetimepicker({
        'format': 'Y/m/d'
    });

    jQuery(".datetimepicker").mask("9999/99/99 99:99", {placeholder: "yyyy/mm/dd hh:mm"});
    jQuery('.datetimepicker').datetimepicker({
        'format': 'Y/m/d h:m'
    });
}

/**
 * Set Tooltips for elements with data-toggle tooltip markup
 *
 * @param jQuery
 */
function setTooltips(jQuery) {
    jQuery('[data-toggle="tooltip"]').tooltip();
}



/**
 * Init Core Plugins Initialization
 */
(function () {
    setInputMasks($);
    setTooltips($);
})();