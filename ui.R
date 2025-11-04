# Define the User Interface (Frontend)
ui <- page_fluid(
  layout_columns(
    col_widths = 12,
    card(
      titlePanel("Virtual Central Dogma"),
      style = "background-color: #f0f0f0; padding: 15px;"
    )),
  layout_columns(
    col_widths = 12,
    card(
      titlePanel("About"),
      helpText("Generates a DNA sequence based on desired length and 
               base distributions.")
    )),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Virtual Gene Generator"),
      sliderInput(inputId = "n_bases",
                  label = "Number of bases:",
                  min = 3,
                  max = 60,
                  value = 30,
                  step = 3,
                  width = "100%"),
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        numericInput(inputId = "a_prob",
                     label = "Adenine probability",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.1),
        numericInput(inputId = "g_prob",
                     label = "Guanine probability",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.1),
        numericInput(inputId = "c_prob",
                     label = "Cytosine probability",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.1),
        numericInput(inputId = "t_prob",
                     label = "Thymine probability",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.1)
      ))),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Virtual Gene output"),
      mainPanel(
        verbatimTextOutput(outputId = "dna")
      )
    )),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Virtual RNA polymerase"),
      mainPanel(
        verbatimTextOutput(outputId = "rna")
      )
    )),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Virtual ribosome"),
      mainPanel(
        verbatimTextOutput(outputId = "protein")
      )
    )),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Nucleotide Frequency Histogram"),
      mainPanel(
        plotOutput(outputId = "freq_plot")
      ))
    ),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Amino acid frequency histogram"),
      mainPanel(
        plotOutput(outputId = "aa_freq_plot")
      ))
  )
  
  
)
