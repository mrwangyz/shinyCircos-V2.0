useSweetAlert()
#******#headerbar
header <- bs4DashNavbar(
)
#******#sidebar
sidebar <- bs4DashSidebar(
  width = "220px",
  collapsed = FALSE,
  skin = "light",
  tags$head(
    tags$script('<script src="https://kit.fontawesome.com/29eb425cd7.js" crossorigin="anonymous"></script>')
  ),
  bs4SidebarMenu(
    id = "sidebar",
    bs4SidebarMenuItem("shinyCircos-V2.0",tabName = "shi-cir", icon = icon("home",lib = "font-awesome"),selected = TRUE),
    br(),
    bs4SidebarMenuItem("Data Upload",tabName = "dat-upl", icon = icon("upload",lib = "font-awesome")),
    bs4SidebarMenuItem("Circos Parameters",tabName = "dat-vie", icon = icon("cogs",lib = "font-awesome")),
    bs4SidebarMenuItem("Circos Plot",tabName = "cir-par", icon = icon("image",lib = "font-awesome")),
    bs4SidebarMenuItem("Gallery",tabName = "gal", icon = icon("adjust",lib = "font-awesome")),
    bs4SidebarMenuItem("Help",tabName = "help", icon = icon("question",lib = "font-awesome")),
    bs4SidebarMenuItem("About",tabName = "about", icon = icon("info",lib = "font-awesome")),
    bs4SidebarMenuItem("Contact",tabName = "contact", icon = icon("compass"))
  )
)
#******#main body
body <- bs4DashBody(
  
   bs4TabItems(
     bs4TabItem(
       tabName = "shi-cir",
       h1(" Welcome to shinyCircos, hope you can enjoy using it!"),
       br(),
       # fluidRow(
       #   column(
       #     width = 4,
       #     bs4InfoBox(
       #       width = 12,
       #       title = "Current version",
       #       value = "2.0.0",
       #       icon = ionicon(name = "cog"),
       #       color = "info",
       #       gradient = TRUE,
       #       fill = TRUE
       #     )
       #   ),
       #   column(
       #     width = 4,
       #     bs4InfoBox(
       #       width = 12,
       #       title = "Online time of the current version",
       #       value = "2022/7/20",
       #       icon = ionicon(name = "time"),
       #       color = "teal",
       #       gradient = TRUE,
       #       fill = TRUE,
       #     )
       #   ),
       #   column(
       #     width = 4,
       #     bs4InfoBox(
       #       width = 12,
       #       title = "Contact",
       #       value = "Your opinion is very important!",
       #       icon = icon("envelope"),
       #       color = "lightblue",
       #       gradient = TRUE,
       #       fill = TRUE,
       #       tabName = "contact"
       #     )
       #   )
       # ),
       shiny::includeHTML("www/main.html")
     ),
     bs4TabItem(
       tabName = "dat-upl",
       tags$head(
         HTML('<script src="https://kit.fontawesome.com/29eb425cd7.js" crossorigin="anonymous"></script>'),
         tags$style("
                 input[type='file'] {width:5em;}
                 .toggleButton {width:100%;}
                 .clearButton {float:right; font-size:12px;}
                 .fa-angle-down:before, .fa-angle-up:before {float:right;}
                 .popover{text-align:left;width:500px;background-color:#000000;}
                 .popover-title{color:#FFFFFF;font-size:16px;background-color:#000000;border-color:#000000;}
                 .jhr{display: inline; vertical-align: top; padding-left: 10px;}
                 #sidebarPanel_1 {width:25em;}
                 #mainPanel_1 {left:28em; position:absolute; min-width:27em;}"
         ),
         tags$style(HTML(".shiny-output-error-validation {color: red;}")),
         tags$style(
           HTML(".checkbox {margin: 0}
                 .checkbox p {margin: 0;}
                 .shiny-input-container {margin-bottom: 0;}
                 .navbar-default .navbar-brand {color: black; font-size:150%;}
                 .navbar-default .navbar-nav > li > a {color:black; font-size:120%;}"
           )
         ),
         tags$script(
           HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')
         )
       ),
       
       width = 12,
       br(),
       pickerInput(
         inputId = "datatype",
         label =  tags$div(
           HTML('<font><h4><i class="fa-solid fa-play"></i> Select the data source:</font>'),
           bs4Dash::tooltip(
             actionButton(
               inputId = "datup_tip1", 
               label="" , 
               icon = icon("question"),
               status="info",
               size = "xs"
             ),
             title = "'upload data'need you choose your own data and parameters,'sample data'is not required",
             placement = "bottom"
           )
         ),
         choices = c("upload data"="a", "sample data"="b")
       ),
       br(),
       
       #
       ###upload data
       #
       
       conditionalPanel(
         condition = "input.datatype=='a'",
         fileInput(
           inputId = "alldata",
           label = tags$div(
             HTML('<font><h4><i class="fa-solid fa-play"></i> Upload all data</font>'),
             bs4Dash::tooltip(
               actionButton(
                 inputId = "datup_tip2", 
                 label="" , 
                 icon=icon("question"),
                 status="info",
                 size = "xs"
               ),
               title = "You can upload data in batches,but remember to save each time",
               placement = "top"
             )
           ),
           multiple = TRUE
         ),
         br(),
         br(),
         conditionalPanel(
           condition = "output.alldata1",
           uiOutput("dataclassify"),
           fluidRow(
             column(
               3,
               fluidRow(
                 column(
                   6,
                   bs4Dash::tooltip(
                     actionBttn(
                       inputId = "save1",
                       label = "Save data",
                       style = "unite",
                       color = "success",
                       icon = icon("save")
                     ),
                     title = "After clicking save data, you can continue to upload data",
                     placement = "top"
                   )
                 ),
                 column(
                   6,
                   conditionalPanel(
                     condition = "input.save1",
                     bs4Dash::tooltip(
                       actionBttn(
                         inputId = "dataup_go",
                         label = "SUBMIT!!",
                         style = "unite",
                         color = "success",
                         icon = icon("forward")
                       ),
                       title = "Click to go to the next page to set parameters and preview data",
                       placement = "bottom"
                     )
                   )
                 )
               )
             ),
             column(
               9
             )
           )
         )
       ),
       
       #
       ###sample data
       #
       conditionalPanel(
         condition = "input.datatype=='b'",
         tags$div(
           HTML('<font><h4><i class="fa-solid fa-play"></i> Please select the sample data plan</font>'),
           bs4Dash::tooltip(
             actionButton(
               inputId = "datup_sam_tipplan", 
               label="" , 
               icon=icon("question"),
               status="info",
               size = "xs"
             ),
             title = "Different plans correspond to different data and parameters. In sample data mode, user adjustments to parameters will not be applied.",
             placement = "bottom"
           )
         ),
         pickerInput(
           inputId = "sam_dataplan",
           label = NULL, 
           choices = c(
             "Option 1"="1",
             "Option 2"="2",
             "Option 3"="3",
             "Option 4"="4",
             "Option 5"="5",
             "Option 6"="6",
             "Option 7"="7",
             "Option 8"="8",
             "Option 9"="9",
             "Option 10"="10"
           )
         ),
         br(),
         bs4Dash::tooltip(
           actionBttn(
             inputId = "dataup_example_go",
             label = "SUBMIT!!!",
             style = "unite",
             color = "success",
             icon = icon("forward")
           ),
           title = "Click to view data and parameters",
           placement = "bottom"
         )
       )
     ),
     bs4TabItem(
       tabName = "dat-vie",
       conditionalPanel(
         condition = "input.datatype == 'b'&& input.dataup_example_go",
         uiOutput("example_data_ui"),
         bs4Dash::tooltip(
           actionBttn(
             inputId = "sam_dat_vie_ok",
             label = "SUBMIT!!",
             style = "unite",
             color = "success",
             icon = icon("forward")
           ),
           title = "Draw using the current parameters",
           placement = "bottom"
         )
       ),
       conditionalPanel(
         condition = "input.datatype == 'a' && input.dataup_go",
         bs4Card(
           collapsible = FALSE,
           title = HTML('<i class="fa-solid fa-circle"></i> Chromosome data'),
           width = 12,
           conditionalPanel(
             condition = "output.chrdata1",
             fluidRow(
               column(
                 6,
                 tags$div(
                   HTML(' <font color="#2196F3"><h4><i class="fa-solid fa-play"></i> File name</font>'),
                   bs4Dash::tooltip(
                     actionButton(
                       inputId = "datvie_tip1", 
                       label="" , 
                       icon=icon("question"),
                       status="info",
                       size = "xs"
                     ),
                     title = "The filename when uploading the file",
                     placement = "bottom"
                   )
                 )
               ),
               column(
                 6,
                 tags$div(
                   HTML(' <font color="#2196F3"><h4><i class="fa-solid fa-play"></i> Chromosome type</font>'),
                   bs4Dash::tooltip(
                     actionButton(
                       inputId = "datvie_tip2", 
                       label="" , 
                       icon=icon("question"),
                       status="info",
                       size = "xs"
                     ),
                     title = "Chromosomes data can be either general data with three columns or cytoband data with five columns. 
                     The first three columns of either type of data should be the chromosome ID,
                     the start and end coordinates of different genomic regions. See example data for more details.",
                     placement = "bottom"
                   )
                 )
               )
             ),
             fluidRow(
               column(
                 6,
                 fluidRow(
                   column(
                     10,
                     uiOutput("sortable_chr")
                   ),
                   column(
                     2,
                     bs4Dash::tooltip(
                       actionBttn(
                         inputId = "view_chr_data",
                         label = NULL,
                         style = "unite",
                         color = "success",
                         icon = icon("eye")
                       ),
                       title = "Click to preview chromosome data",
                       placement = "bottom"
                     )
                   )
                 )
               ),
               column(
                 6,
                 fluidRow(
                   column(
                     11,
                     pickerInput(
                       inputId = "chr_type",
                       label = NULL,
                       choices = c("general" = "1", "cytoband" = "2")
                     )
                   ),
                   column(
                     1,
                     bs4Dash::tooltip(
                       actionBttn(
                         inputId = "chr_setting",
                         label = NULL,
                         style = "unite",
                         color = "success",
                         icon = icon("cog")
                       ),
                       title = "Chromosome parameter settings",
                       placement = "bottom"
                     )
                   )
                 )
               ),
               tags$head(tags$style(paste0("#jquidatvie_chrvie .modal-dialog{ max-width:1200px}"))),
               jqui_draggable(
                 bsModal(
                   id = "jquidatvie_chrvie",
                   title = NULL,
                   trigger = "view_chr_data",
                   size = "large",
                   DTOutput("viewChr")
                 )
               ),
               tags$head(tags$style("#jquicirpar_chrsetting .modal-dialog{ width:1200px}")),
               jqui_draggable(
                 bsModal(
                   id = "jquicirpar_chrsetting",
                   title = NULL,
                   trigger = "chr_setting",
                   size = "large",
                   conditionalPanel(
                     condition = "input.chr_type == '1'",
                     pickerInput(
                       inputId = "trackChr",
                       label = tags$div(
                         HTML('<font><h5><i class="fa-solid fa-play"></i><b> Chromosome band</b></font>'),
                         bs4Dash::tooltip(
                           actionButton(
                             inputId = "datvie_tip3", 
                             label="" , 
                             icon=icon("question"),
                             status="info",
                             size = "xs"
                           ),
                           title = "whether to show chromosome band",
                           placement = "bottom"
                         )
                       ),
                       choices = c("Show" = "track", "Hide" = "")
                     ),
                     conditionalPanel(
                       condition = "input.trackChr == 'track'",
                       textInput(
                         inputId = "colorChr",
                         label = tags$div(
                           HTML('<font><h5><i class="fa-solid fa-play"></i><b> Color(s):</b></font>'),
                           bs4Dash::tooltip(
                             actionButton(
                               inputId = "datvie_tip4", 
                               label="" , 
                               icon=icon("question"),
                               status="info",
                               size = "xs"
                             ),
                             title = "Colors to be used for each chromosome/sector. Character vector of arbitrary length representing colors is accepted and adjusted automatically to the number of sectors. For example, 'grey' or 'grey,red,green,blue'. Hex color codes as '#FF0000' are also supported.",
                             placement = "bottom"
                           )
                         ),
                         value="grey"
                       ),
                       numericInput(
                         inputId = "heightChr",
                         label = tags$div(
                           HTML('<font><h5><i class="fa-solid fa-play"></i><b>Band height:</b></font>'),
                           bs4Dash::tooltip(
                             actionButton(
                               inputId = "datvie_tip5", 
                               label="" , 
                               icon=icon("question"),
                               status="info",
                               size = "xs"
                             ),
                             title = "Height of the chromosome band, which should be greater than 0 and smaller than 0.9.",
                             placement = "bottom"
                           )
                         ),
                         value=0.02, 
                         min=0.01, 
                         max=0.9,
                         step=0.01
                       )
                     )
                   ),
                   conditionalPanel(
                     condition = "input.chr_type == '2'",
                     numericInput(
                       inputId = "heightChr_cyt",
                       label = tags$div(
                         HTML('<font><h5><i class="fa-solid fa-play"></i><b> Band height:</b></font>'),
                         bs4Dash::tooltip(
                           actionButton(
                             inputId = "datvie_tip6", 
                             label="" , 
                             icon=icon("question"),
                             status="info",
                             size = "xs"
                           ),
                           title = "Height of the chromosome band, which should be greater than 0 and smaller than 0.9.",
                           placement = "bottom"
                         )
                       ),
                       value=0.05, 
                       min=0.01, 
                       max=0.9,
                       step=0.01
                     )
                   ),
                   pickerInput(
                     inputId = "outAxis",
                     label = tags$div(
                       HTML('<font><h5><i class="fa-solid fa-play"></i><b>Genomic position axis</b></font>'),
                       bs4Dash::tooltip(
                         actionButton(
                           inputId = "datvie_tip7", 
                           label="" , 
                           icon=icon("question"),
                           status="info",
                           size = "xs"
                         ),
                         title = "whether to display the genomic position axis",
                         placement = "bottom"
                       )
                     ),
                     choices = c("Show" = "1", "Hide" = "2"),
                     selected = "1"
                   ),
                   conditionalPanel(
                     condition = "input.outAxis == '1'",
                     numericInput(
                       inputId = "outAxis_size",
                       label = tags$div(
                         HTML('<font><h5><i class="fa-solid fa-play"></i><b>Genome position axis font size</b></font>'),
                         bs4Dash::tooltip(
                           actionButton(
                             inputId = "datvie_tip11", 
                             label="" , 
                             icon=icon("question"),
                             status="info",
                             size = "xs"
                           ),
                           title = "The genome position axis font size,too large may cause some problems",
                           placement = "bottom"
                         )
                       ),
                       value=0.7,
                       min=0.1,
                       max=3, 
                       step=0.1
                     )
                   ),
                   pickerInput(
                     inputId = "labelChr",
                     label = tags$div(
                       HTML('<font><h5><i class="fa-solid fa-play"></i><b>Chromosome IDs</b></font>'),
                       bs4Dash::tooltip(
                         actionButton(
                           inputId = "datvie_tip8", 
                           label="" , 
                           icon=icon("question"),
                           status="info",
                           size = "xs"
                         ),
                         title = "whether to display the genomic IDs",
                         placement = "bottom"
                       )
                     ),
                     choices = c("Show" = "1", "Hide" = "2")
                   ),
                   conditionalPanel(
                     condition = "input.labelChr == '1'",
                     numericInput(
                       inputId = "labelChr_size",
                       label = tags$div(
                         HTML('<font><h5><i class="fa-solid fa-play"></i><b>Chromosome IDs font size</b></font>'),
                         bs4Dash::tooltip(
                           actionButton(
                             inputId = "datvie_tip9", 
                             label="" , 
                             icon=icon("question"),
                             status="info",
                             size = "xs"
                           ),
                           title = "The font size of chromosome ID, too large may cause some problems",
                           placement = "bottom"
                         )
                       ),
                       value=1.2,
                       min=0.1,
                       max=3, 
                       step=0.1
                     )
                   ),
                   textInput(
                     inputId = "gapChr",
                     label = tags$div(
                       HTML('<font><h5><i class="fa-solid fa-play"></i><b>Distances between adjacent sectors</b></font>'),
                       bs4Dash::tooltip(
                         actionButton(
                           inputId = "datvie_tip12", 
                           label="" , 
                           icon=icon("question"),
                           status="info",
                           size = "xs"
                         ),
                         title = "Gaps between neighbouring sectors. Numeric vector of arbitrary length is accepted and adjusted automatically to the number of sectors. For example, '1' or '1,2,3,1'. The first value corresponds to the gap between the first and the second sector.",
                         placement = "bottom"
                       )
                     ),
                     value = "1"
                   ),
                   numericInput(
                     inputId = "distance_Chr",
                     label = tags$div(
                       HTML('<font><h5><i class="fa-solid fa-play"></i><b>Distance between adjacent tracks</b></font>'),
                       bs4Dash::tooltip(
                         actionButton(
                           inputId = "datvie_tip13", 
                           label="" , 
                           icon=icon("question"),
                           status="info",
                           size = "xs"
                         ),
                         title = "The next part can be 'label''track''link'",
                         placement = "bottom"
                       )
                     ),
                     value=0.01, 
                     min=0, 
                     max=0.1,
                     step=0.01
                   )
                 )
               )
             )
           )
         ),
         bs4Card(
           collapsible = FALSE,
           title = HTML('<i class="fa-solid fa-circle"></i> Track data'),
           width = 12,
           uiOutput("sortable_track")
         ),
         bs4Card(
           collapsible = FALSE,
           title = HTML('<i class="fa-solid fa-circle"></i> Label data'),
           width = 12,
           uiOutput("sortable_label")
         ),
         bs4Card(
           collapsible = FALSE,
           title = HTML('<i class="fa-solid fa-circle"></i> Link data'),
           width = 12,
           uiOutput("sortable_link")
         ),
         bs4Dash::tooltip(
           actionBttn(
             inputId = "dat_vie_ok",
             label = "SUBMIT!!",
             style = "unite",
             color = "success",
             icon = icon("forward")
           ),
           title = "Draw using the current parameters",
           placement = "bottom"
         )
       )
     ),
     bs4TabItem(
       tabName = "cir-par",
       conditionalPanel(
         condition = "input.datatype == 'a'",
         conditionalPanel(
           condition = "input.dat_vie_ok",
           fluidRow(
             column(
               width = 6,
               fluidRow(
                 column(
                   width = 4,
                   bs4Dash::tooltip(
                     actionBttn(
                       inputId = "cirpar_advancesetting",
                       label = "Advance",
                       style = "unite",
                       color = "success",
                       icon = icon("cog")
                     ),
                     title = "Legend settings",
                     placement = "bottom"
                   ),
                   tags$head(tags$style("#jquicirpar_advancesetting .modal-dialog{ max-width:800px}")),
                   jqui_draggable(
                     bsModal(
                       id = "jquicirpar_advancesetting",
                       title = NULL,
                       trigger = "cirpar_advancesetting",
                       size = "large",
                       fluidRow(
                         column(
                           width = 6
                         ),
                         column(
                           width = 6,
                           
                         )
                       ),
                       HTML('<font><h3><i class="fa-solid fa-circle"></i> Legend</font>'),
                       fluidRow(
                         column(
                           width = 6,
                           pickerInput(
                             inputId = "addlegend",
                             label = tags$div(
                               HTML('<font><h4><i class="fa-solid fa-play"></i> Add legend</font>'),
                               bs4Dash::tooltip(
                                 actionButton(
                                   inputId = "cirplo_leg_tip1",
                                   label="" ,
                                   icon=icon("question"),
                                   status="info",
                                   size = "xs"
                                 ),
                                 title = "Whether to add a legend",
                                 placement = "bottom"
                               )
                             ),
                             choices = c("yes" , "no"),
                             selected = "no"
                           )
                         ),
                         column(
                           width = 6,
                           conditionalPanel(
                             condition = "input.addlegend == 'yes'",
                             pickerInput(
                               inputId = "legendpos",
                               label = tags$div(
                                 HTML('<font><h4><i class="fa-solid fa-play"></i> Legend position</font>'),
                                 bs4Dash::tooltip(
                                   actionButton(
                                     inputId = "cirplo_leg_tip2",
                                     label="" ,
                                     icon=icon("question"),
                                     status="info",
                                     size = "xs"
                                   ),
                                   title = "Legend position, providing both right and bottom positions",
                                   placement = "bottom"
                                 )
                               ),
                               choices = c("Right","Bottom"),
                               selected = "Right"
                             )
                           )
                         )
                       ),
                       hr(),
                       HTML('<font><h3><i class="fa-solid fa-circle"></i> Plot size</font>'),
                       sliderTextInput(
                         inputId = "plotmultiples",
                         label = tags$div(
                           HTML('<font><h4><i class="fa-solid fa-play"></i> Percentage</font>'),
                           bs4Dash::tooltip(
                             actionButton(
                               inputId = "cirplo_leg_tipnew",
                               label="" ,
                               icon=icon("question"),
                               status="info",
                               size = "xs"
                             ),
                             title = "relative to the size of the original image",
                             placement = "bottom"
                           )
                         ),
                         choices = c(50:300),
                         selected = 100
                       ),
                       hr(),
                       HTML('<font><h3><i class="fa-solid fa-circle"></i> Highlignt</font>'),
                       tags$div(
                         HTML('<font><h4><i class="fa-solid fa-play"></i> Paste data below:</font>'),
                         bs4Dash::tooltip(
                           actionButton(
                             inputId = "cirplo_highlight",
                             label="" ,
                             icon=icon("question"),
                             status="info",
                             size = "xs"
                           ),
                           title = "Each row should contain five components separated by commas including:start sector position, end sector position, start track position,end track position, color value with transparency. For example, 'chr1,1,10000,'#FF0000'.Don not forget transparency it is important.",
                           placement = "bottom"
                         )
                       ),
                       tags$textarea(
                         id = "hltData",
                         rows = 10,
                         cols = 60,
                         ""
                       ),
                       sliderTextInput(
                         inputId = "hltrans",
                         label = HTML('<font><h4><i class="fa-solid fa-play"></i> Choose transparency(%)</font>'),
                         choices = c(1:100),
                         selected = 25
                       ),
                       actionBttn(
                         inputId = "savehlData",
                         label = "SAVE",
                         style = "unite",
                         color = "success",
                         size = "sm"
                       ),
                       actionBttn(
                         inputId = "clearhlData",
                         label = "CLEAN",
                         style = "unite",
                         color = "danger",
                         size = "sm"
                       ),
                       hr(),
                       HTML('<font><h3><i class="fa-solid fa-circle"></i> Index</font>'),
                       pickerInput(
                         inputId = "trac_index",
                         label = tags$div(
                           HTML('<font><h4><i class="fa-solid fa-play"></i> Add track index</font>'),
                           bs4Dash::tooltip(
                             actionButton(
                               inputId = "cirplo_leg_tip3",
                               label="" ,
                               icon=icon("question"),
                               status="info",
                               size = "xs"
                             ),
                             title = "Add index to each track.",
                             placement = "bottom"
                           )
                         ),
                         choices = c("Yes","No"),
                         selected = "No"
                       ),
                       hr(),
                       bs4Dash::tooltip(
                         actionBttn(
                           inputId = "updateplot",
                           label = "Update",
                           style = "unite",
                           color = "success"
                         ),
                         title = "Redraw using the current parameters",
                         placement = "bottom"
                       )
                       
                     )
                   )
                 ),
                 column(
                   width = 8,
                   conditionalPanel(
                     condition = "output.circosfigure",
                     fluidRow(
                       column(
                         width = 6,
                         downloadBttn(
                           outputId = "shinyCircos.pdf", 
                           label = "Download PDF-file",
                           style = "unite",
                           color = "success"
                         )
                       ),
                       column(
                         width = 6,
                         downloadBttn(
                           outputId = "shinyCircos.svg",
                           label = "Download SVG-file",
                           style = "unite",
                           color = "success"
                         )
                       )
                       
                     )
                     
                   )
                   
                 )
               )
             ),
             column(
               width = 6,
               
             )
           )
         )
       ),
       
       conditionalPanel(
         condition = "input.dat_vie_ok >= 1 | input.sam_dat_vie_ok >= 1",
         uiOutput("sortable_plot")
       )
     ),
     bs4TabItem(
       tabName = "gal",
       includeHTML("www/gallery.html")
     ),
     bs4TabItem(
       tabName = "help",
       HTML('<font><h3><i class="fa-solid fa-play"></i> Language</font>'),
       fluidRow(
         column(
           width = 3,
           pickerInput(
             inputId = "helplan",
             label = NULL,
             choices = c("English" = 1,"简体中文" = 2),
             selected = 2
           ),
         ),
         column(
           width = 3,
           conditionalPanel(
             condition = "input.helplan == '1'",
             downloadButton("Englishhelpmanual", "Download help manual(English)")
           ),
           conditionalPanel(
             condition = "input.helplan == '2'",
             downloadButton("Chinesehelpmanual", "下载中文帮助手册")
           )
         ),
         column(
           width = 6
         )
       ),
       hr(),
       conditionalPanel(
         condition = "input.helplan == '1'",
         includeHTML("www/help-English.html")
       ),
       conditionalPanel(
         condition = "input.helplan == '2'",
         includeHTML("www/help-Chinese.html")
       )
     ),
     bs4TabItem(
       tabName = "about",
       shiny::includeHTML("www/about.html")
     ),
     bs4TabItem(
       tabName = "contact",
       shiny::includeHTML("www/contact.html")
     )
   )
)


#bottom bar
foot <- bs4DashFooter(
  includeHTML("www/ffooter.html")
)

ui <- bs4DashPage(
  header, sidebar, body , footer = foot ,controlbar = NULL,scrollToTop = TRUE,dark = NULL,title = "Welcome to shinyCircos-V2.0"
)