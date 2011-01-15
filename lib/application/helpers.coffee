this.app =
  activePage: ->
    $(".ui-page-active")
    
  reapplyStyles: (el) ->
    el.find('ul[data-role]').listview();
    el.find('div[data-role="fieldcontain"]').fieldcontain();
    el.find('button[data-role="button"]').button();
    el.find( "[type='radio'], [type='checkbox']" ).checkboxradio();
    el.find( "button, [type='button'], [type='submit'], [type='reset'], [type='image']" ).not( ".ui-nojs" ).button();
    el.find( "input, textarea" ).not( "[type='search'], [type='radio'], [type='checkbox'], button, [type='button'], [type='submit'], [type='reset'], [type='image']" ).textinput();
    el.find( "input, select" ).filter( "[data-role='slider'], [data-type='range']" ).slider();
    el.find( "select:not([data-role='slider'])" ).selectmenu();
    el.page()
    
  redirectTo: (page) ->
    $.mobile.changePage page
  
  goBack: ->
    $.historyBack()
    
  switch: ->
    $('#nav a').not($(this)).removeClass('on')
    $(this).addClass('on')
    console.log("Switch")
