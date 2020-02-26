

shiny::shinyServer(function(input, output) {

  liste_table <- get_table('dictionnaire_tables') %>% 
    distinct(nom_table, commentaire_table)
  
  output$titre_table <- renderText({liste_table %>% filter(nom_table == input$tab) %>% 
      pull(commentaire_table)})
  
  output$result <- DT::renderDT({nomensland::get_table(input$tab)}, 
    filter = 'top', class = 'white-space: nowrap',
  options = list(lengthChange = FALSE, dom = 'Bfrtip', pageLength = 20,
                 buttons = c('copy', 'excel', 'colvis'),
                 scrollY = TRUE, scrollX = TRUE,
                 scroller = TRUE, server = FALSE))
  
  output$downloadData <- downloadHandler(
    
    filename = function() {
      paste(input$tab, input$filetype, sep = ".")
    },
    
    
    
    content = function(file) {
      if (input$filetype != 'xlsx'){
      sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")
      
      
      # write.table(nomensland::get_table(input$tab), file, sep = sep,
      #             na = "", quote = TRUE,
      #             row.names = FALSE)
      readr::write_delim(nomensland::get_table(input$tab), file, delim = sep, na = "")
      }
      if (input$filetype == 'xlsx'){
        wb <- openxlsx::createWorkbook()
        openxlsx::addWorksheet(wb, input$tab)
        openxlsx::writeData(wb, input$tab, nomensland::get_table(input$tab))
        openxlsx::saveWorkbook(wb, file, overwrite = TRUE)
      }
    }
  )
})
