library("shiny")
library("bslib")
library("ggplot2")
source(file = "app_functions.R")
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
    ggplot2::ggplot(freq_df, aes(x = dna_vec, y = Freq, fill = dna_vec)) +
      geom_col(color = "black", alpha = 1) +
      labs(
        title = "Frequency of nucleotides",
        x = "Nucleotide",
        y = "Frequency") +
      scale_fill_manual(
        values = c(
          "A" = "steelblue",
          "T" = "darkorange",
          "C" = "firebrick",
          "G" = "seagreen"
        )
      ) +
      geom_hline(yintercept = 0) +
      theme_minimal(base_size = 18) +
      theme(legend.position = "none")
  })
  output$aa_freq_plot <- renderPlot({
    aa_freq_df <- aa_freqs(translate_rna(transcribe_dna(dna_seq())))
    ggplot2::ggplot(aa_freq_df, aes(x = aa_vec, y = Freq, fill = aa_vec)) +
      geom_col(color = "black", alpha = 1) +
      labs(
        title = "Frequency of Amino acid residues",
        x = "Amino acid",
        y = "Frequency") +
      scale_fill_manual(values = c( #skudud copilot for farveskalaen
        "A" = "goldenrod",
        "V" = "darkorange",
        "L" = "sienna",
        "I" = "chocolate",
        "M" = "tan4",
        "F" = "firebrick",
        "W" = "purple4",
        "P" = "peru",
        "G" = "grey50",
        "S" = "steelblue",
        "T" = "skyblue3",
        "N" = "lightseagreen",
        "Q" = "seagreen",
        "C" = "darkolivegreen",
        "K" = "royalblue",
        "R" = "navy",
        "H" = "slateblue",
        "D" = "indianred",
        "E" = "tomato",
        "Y" = "darkgoldenrod"
      )) +
      geom_hline(yintercept = 0) +
      theme_minimal(base_size = 18) +
      theme(legend.position = "none")
  })
}
