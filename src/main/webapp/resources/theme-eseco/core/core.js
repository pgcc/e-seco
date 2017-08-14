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
 * Init Core Plugins Initialization
 */
(function(){
    setInputMasks($);
})();