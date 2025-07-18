# HTMLWidget <- R6::R6Class("HTMLWidget",
#                              public = list(
#                                  initialize = function() {
#                                  },
# 
                                 generate_tab = function(title="Tab",tabs=c("1","2","3"),tabContents=c("a","b","c"),
                                                         titleTab="",titleWidth=135,
                                                         plainTabs=FALSE,indent=0,topMargin=5,
                                                         colours=c("#3498db","#888","#888"),fontSize="12px",
                                                         plain=FALSE,width=550,height=NULL,open=0) {
                                   if (is.null(height)) ht<-'' else ht<-paste0('height: ',height,'px;')
                                   if (open==0) openCode<-''
                                   else openCode<-paste0(
                                     'document.getElementById("',title,'||',tabs[open],'").style.display = "block";'
                                   )
                                   
                                   if (!plainTabs) 
                                     tabBorders<-''
                                   else tabBorders<-paste0('border: none;')
                                   
                                   script<-paste0(
                                     '<script>',
                                     'function openTab(evt, tabName) {',
                                     '  var tabState;',
                                     '  if (tabName!="tabtitle") {',
                                     '    tabState = document.getElementById(tabName).style.display;',
                                     '    closeTabs(evt, tabName);',
                                     '    if (tabState!="block") {',
                                     '      document.getElementById(tabName).style.display = "block";',
                                     '      evt.currentTarget.className += " active";',
                                     '    }',
                                     '  }',
                                     '}',
                                     'function closeTabs(evt, tabName) {',
                                     '  var i, tabID, panelID, buttonID, tabcontent, tablinks;',
                                     '    tabID = tabName.split("||",1);',
                                     '    tablinks = document.getElementsByClassName("tablinks");',
                                     '    tabcontent = document.getElementsByClassName("tabcontent");',
                                     '    for (i = 0; i < tabcontent.length; i++) {',
                                     '      panelID=tabcontent[i].id.split("||",1);',
                                     '      if (panelID[0]==tabID[0]) {',
                                     '        tabcontent[i].style.display = "none";',
                                     '      }',
                                     '    }',
                                     '    for (i = 0; i < tabcontent.length; i++) {',
                                     '      buttonID=tablinks[i].id.split("||",1);',
                                     '      if (buttonID[0]==tabID[0]) {',
                                     '        tablinks[i].className = tablinks[i].className.replace(" active", "");',
                                     '      }',
                                     '    }',
                                     '}',
                                     # openCode,
                                     '</script>'
                                   )
                                   
                                   style<-paste0(
                                     '<style>',
                                     # Style the tab 
                                       '.tab {overflow: hidden;',
                                       'margin: 0px 0px 0px 0px;',
                                       'padding: 5px 0px 0px 0px;',
                                       'border: none;',
                                       'background-color: inherit;',
                                     'border-bottom: solid ',colours[3],' 1px;',
                                     'width: ',width+2,'px;',
                                     'margin: none;',
                                       '}',

                                     # Style the buttons inside the tab 
                                     '.tab button {',
                                     'background-color: #ccc;',
                                     'float: left;',
                                     'border: none;',
                                     'outline: none;',
                                     'cursor: pointer;',
                                     'padding: 2px 10px;',
                                     'margin: 0px 1px;',
                                     'transition: 0.3s;',
                                     'font-size: ',fontSize,';',
                                     'font-weight: normal;',
                                     'border-top-left-radius: 4px;',
                                     'border-top-right-radius: 4px;',
                                     '}',

                                     # Change background color of buttons on hover 
                                       '.tab button:hover {',
                                         'background-color: #ddd;',
                                       '}',

                                     # Create an active/current tablink class 
                                     '.tab button.active {',
                                     'background-color: ',colours[2],';',
                                     'color: white;',
                                     '}',
                                     
                                     # Style the null tab content 
                                     '.tabnullcontent {',
                                     'display: none;',
                                     'padding: 0px 0px;',
                                     'margin: 0px;',
                                     'border: 1px solid ',colours[3],';','border-top: none;',
                                     'width: ',width,'px;',
                                     'height: 0px;',
                                     '}',
                                     
                                     # Style the tab content 
                                     '.tabcontent {',
                                     'display: none;',
                                     'padding: 0px 0px;',
                                     'margin: 0px;',
                                     'border: 1px solid ',colours[3],';','border-top: none;',
                                     'width: ',width,'px;',
                                     ht,
                                     '}',
                                     '</style>'
                                   )
                                   
                                   buttons<-''
                                   panels<-''
                                   if (titleWidth==0) titleShow<-''
                                   else titleShow<-paste0('<b>',title,'</b>')
                                   buttons <- paste0(buttons,
                                                     '  <button id="tabtitle',title,'" class="tablinks" onclick="closeTabs(event,\'',title,'\')"',
                                                        ' style="background-color:rgba(0,0,0,0);color:black;cursor:default;',
                                                        'font-weight: 500;font-size:13px;width:',titleWidth,'px;text-align: right;',
                                                        'margin:0px;padding: 0px;">',
                                                     titleShow,
                                                     '</button>')
                                   if (nchar(titleTab)>0)
                                     panels <- paste0(panels,
                                                      '  <div id="',title,'" class="tabcontent" style="display:block">',
                                                      titleTab,
                                                      '</div>')
                                   else
                                     panels <- paste0(panels,
                                                      '  <div id="',title,'" class="tabcontent" style="display:none;"','width:',width-indent,'px;','>',
                                                      '</div>')
                                   for (itab in 1:length(tabs)) {
                                     panelID<-paste0(title,'||',tabs[itab])
                                     if (itab==open) {
                                       buttons <- paste0(buttons,
                                                         '  <button class="tablinks active" onclick="openTab(event,\'',panelID,'\')" id="',paste0(panelID,"button"),'">',
                                                         tabs[itab],
                                                         '</button>')
                                       panels <- paste0(panels,
                                                        '  <div id="',panelID,'" class="tabcontent" style="',tabBorders,';',
                                                        'width:',width-indent,'px;',';margin-left:',indent,'px;','display:block;">',
                                                        tabContents[itab],
                                                        '</div>')
                                     } else {
                                       buttons <- paste0(buttons,
                                                         '  <button class="tablinks" onclick="openTab(event,\'',panelID,'\')" id="',paste0(panelID,"button"),'">',
                                                         tabs[itab],
                                                         '</button>')
                                       panels <- paste0(panels,
                                                        '  <div id="',panelID,'" class="tabcontent" style="',tabBorders,';',
                                                        'width:',width-indent,'px;',';margin-left:',indent,'px;','">',
                                                        tabContents[itab],
                                                        '</div>')
                                     }
                                   }
                                   
                                   buttons<-paste0('<div class="tab" style="','width:',width-indent+2,'px;',
                                                   'padding:0px;margin:0px;','margin-left:',indent,'px;','padding-top:',topMargin,'px;',
                                                   # 'border:solid;',
                                                   '">',buttons,'</div>')
                                   if (plain)
                                     html_content <- paste0(
                                       buttons,
                                       panels
                                     )
                                   else
                                     html_content <- paste0(
                                       style,
                                       buttons,
                                       panels,
                                       script
                                     )
                                   return(html_content)
                                 }
                                 
#                              )
# )
# 
