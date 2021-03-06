
#' Create a canvas element for drawing
#'
#' @param cid the id of the canvas element
#' @param cwidth the width of the canvas element
#' @param cheight the height of the canvas element
#' @param cfill the color of the canvas element. Default to #FFFFFF (white)
#' @param drawingWidth the width of the drawing output. Default to 2
#' @param gumSize specify the size of the gum. Defaults to 10
#'
#' @return an HTML canvas element
#' @export
#'
#' @examples
#'if (interactive()) {
#'
#'ui <- fluidPage(
#'
#'
#'    h1("Draw some stuff here"),
#'
#'    fabric_drawing(cid = "canvas1")
#'
#'    )
#'
#'server <- function(input, output) {}
#'
#'shinyApp(ui = ui, server = server)
#'
#'}




fabric_drawing <- function(cid,
                          cwidth = 800,
                          cheight = 600,
                          cfill = "#FFFFFF",
                          drawingWidth = 2,
                          gumSize = 10){



htmltools::tagList(


  htmltools::HTML(glue::glue("

  <input id = erase{cid} type = 'checkbox' title='Check it to erase !'>

  <input id = {cid}drawing-color type = 'color' value = '#005E7A' style = 'width:30px;'>

  <input id = export{cid} type = 'button' style = 'width:55px;' value = 'Export'>

                             ")),

  htmltools::tags$canvas(id = cid, width = cwidth, height = cheight),

  fabric_dependency(),

  filesaver_dependency(),

  jquery_dependency(),


  htmltools::tags$script(htmltools::HTML(glue::glue(
    "

const {cid} = new fabric.Canvas('{cid}', {{
    backgroundColor: '{cfill}',
    isDrawingMode: true

    }});


{cid}.freeDrawingBrush.width  = {drawingWidth};


{cid}drawingColorEl = document.getElementById('{cid}drawing-color');

{cid}.freeDrawingBrush.color = {cid}drawingColorEl.value;

{cid}drawingColorEl.onchange = function() {{
    {cid}.freeDrawingBrush.color = {cid}drawingColorEl.value;
  }};


 $('#erase{cid}').click(function(){{

    if (this.checked) {{

      {cid}.freeDrawingBrush.color  = '{cfill}';

    }} else {{

      {cid}.freeDrawingBrush.color = {cid}drawingColorEl.value;

    }}



}});





 $('#erase{cid}').click(function(){{

    if (this.checked) {{

      {cid}.freeDrawingBrush.width   = {gumSize};

    }} else {{

      {cid}.freeDrawingBrush.width  = {drawingWidth};

    }}


}});


$('#export{cid}').click(function(){{

  $('#{cid}').get(0).toBlob(function(blob){{

    saveAs(blob, '{cid}-IMG.png');


  }});


}});







  "
  )))



)















}




















