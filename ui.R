

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Group Split r for 2 Sample Unpaired t-Test "),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("eff",
                   "Effekt size",
                   min = 0,
                   max = 1,
                   value = 0.5),
       sliderInput("alpha",
                    "alpha",
                    value = 0.05,
                    min = 0,
                    max = 1,
                    step = 0.05),
       sliderInput("power",
                    "power",
                    value = 0.8,
                    min = 0,
                    max = 1,
                    step = 0.05)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("Plot"),
       textOutput("Text1"),
       textOutput("Text2")
    )
  )
))
