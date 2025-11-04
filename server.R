# Define the Server (Backend)
server <- function(input, output) {
  dna_seq <- reactive({
    gene_dna(length = input$n_bases,
             base_probs = c(input$a_prob,input$t_prob,
                            input$c_prob,input$g_prob))
  })
  
  output$dna <- renderText({
    dna_seq()
  })
  output$rna <- renderText({
    transcribe_dna(dna_seq())
  })
  output$protein <- renderText({
    translate_rna(transcribe_dna(dna_seq()))
  })
  output$freq_plot <- renderPlot({
    freq_df <- base_freqs(dna_seq())
    barplot(freq_df$Freq,
            names.arg = freq_df$dna_vec,
            col = "#b22222",
            border = "white",
            xlab = "Base",
            ylab = "Frequency",
            main = "Distribution of DNA bases")
    abline(h = 0, col = "black", lwd = 2)
  })
  output$aa_freq_plot <- renderPlot({
    aa_freq_df <- aa_freqs(translate_rna(transcribe_dna(dna_seq())))
    ggplot2::ggplot(aa_freq_df, aes(x = aa_vec, y = Freq, fill = aa_vec)) +
      geom_col(color = "black", alpha = 0.8) +
      labs(
        title = "Frequency of Amino acid residues",
        x = "Amino acid",
        y = "Frequency") +
      theme_minimal() +
      theme(legend.position = "none")
  })
}
