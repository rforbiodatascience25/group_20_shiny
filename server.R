# Define the Server (Backend)
server <- function(input, output) {
  output$dna <- renderText({
    gene_dna(length = input$n_bases, 
             base_probs = c(input$a_prob,input$t_prob,
                            input$c_prob,input$g_prob ))
  })
  output$rna <- renderText({
    transcribe_dna(input$dna)
  })
  output$protein <- renderText({
    translate_rna(input$rna)
  })
  output$freq_plot <- renderPlot({
    freq_df <- base_freqs(input$dna)
    barplot(freq_df$Freq,
            names.arg = freq_df$dna_vec,
            col = "#75AADB",
            border = "white",
            xlab = "Base",
            ylab = "Frequency",
            main = "Distribution of DNA bases")
  })
  output$aa_freq_plot <- renderPlot({
    aa_freq_df <- aa_freqs(input$protein)
    barplot(aa_freq_df$Freq,
            names.arg = aa_freq_df$aa_vec,
            col = "#75AADB",
            border = "white",
            xlab = "Amino acid",
            ylab = "Frequency",
            main = "Distribution of AA resiudes")
  })
}
