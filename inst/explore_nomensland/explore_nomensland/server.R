

shiny::shinyServer(function(input, output) {

  liste_table <- get_table('dictionnaire_tables') %>% 
    distinct(nom_table, commentaire_table)
  
  output$titre_table <- renderText({liste_table %>% filter(nom_table == input$tab) %>% 
      pull(commentaire_table)})
  
  output$result <- DT::renderDT({nomensland::get_table(input$tab)
  }, extensions = 'Scroller', options = list(pageLength = 20#,
                                             # deferRender = TRUE,
                                             # scrollX = 200,
                                             # scroller = TRUE
  ), filter = 'top')
  
  output$downloadData <- downloadHandler(
    
    filename = function() {
      paste(input$tab, input$filetype, sep = ".")
    },
    
    
    
    content = function(file) {
      sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")
      
      
      # write.table(nomensland::get_table(input$tab), file, sep = sep,
      #             na = "", quote = TRUE,
      #             row.names = FALSE)
      readr::write_delim(nomensland::get_table(input$tab), file, delim = sep, na = "")
    }
  )
})
