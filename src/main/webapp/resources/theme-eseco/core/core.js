/**
 * E-SECO THEME CORE JAVASCRIPT
 */

/**
 * Set Input Masks throught jquery.maskedinput
 * EXEMPLES http://xdsoft.net/jqplugins/datetimepicker/
 * @param jQuery
 */
function setInputMasks(jQuery) {
    jQuery('.datepicker').datetimepicker({
        format: 'Y/m/d',
        timepicker: false,
        mask: true
    });

    jQuery('.datetimepicker').datetimepicker({
        format: 'Y/m/d H:i',
        mask: true
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