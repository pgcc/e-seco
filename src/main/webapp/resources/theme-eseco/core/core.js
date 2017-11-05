/**
 * E-SECO THEME CORE JAVASCRIPT
 */

/**
 * Set Input Masks throught jquery.maskedinput
 *
 * @param jQuery
 */
function setInputMasks(jQuery){
    jQuery(".mask-date").mask("aaa aaa 99 99:99:99 aaaa 9999",{placeholder:"___ ___ __ __:__:__ ____ ____"});
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