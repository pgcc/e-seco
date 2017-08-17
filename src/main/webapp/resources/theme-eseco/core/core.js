/**
 * E-SECO THEME CORE JAVASCRIPT
 */

/**
 * Set Input Masks throught jquery.maskedinput
 *
 * @param jQuery
 */
function setInputMasks(jQuery){
    jQuery(".mask-date").mask("99/99/9999");
}

/**
 * Set Tooltips for elements with data-toggle tooltip markup
 *
 * @param jQuery
 */
function setTooltips(jQuery){
    jQuery('[data-toggle="tooltip"]').tooltip();
}



/**
 * Init Core Plugins Initialization
 */
(function(){
    setInputMasks($);
    setTooltips($);
})();