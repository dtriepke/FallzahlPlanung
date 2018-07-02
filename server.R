#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw
shinyServer(function(input, output) {
   
  output$Plot <- renderPlot({
    
  
    alpha <- input$alpha
    p <- input$power
    n1 <- r <- seq(0.1,10,0.01)
    eff <- input$eff
    
    for( i in 1:length(r)){
      eff2dummy <- 2
      n1[i] <- 2
      while ( eff < sqrt(eff2dummy) ) { # Schleife zur Bestimmung von n1
        n1[i] <- n1[i] + 1
        eff2dummy <- (qt(p = p, df = n1[i] * (1 + r[i]) - 2) +
                        qt(p = 1 - alpha, df = n1[i] * (1 + r[i]) - 2))^2 / 
          n1[i] * (1 + 1 / r[i])
      }
    }
    
    n2 <- n1 * r
    n <- n1 + n2
    plot( log(r), n1, type = "l", col = "red", lwd = 2.5, ylab = "n", 
          sub =     paste("r = 40:60 => {n = ", n[which(r == round(40/60,2) )],
                          ", n1 = ", n1[which( r == round(40/60,2) )],
                          ", n2 = ", n2[which(r == round(40/60,2) )],   
                          " rel. distance to r = 50:50 ", round(n[which(r == round(40/60,2) )] / min(n), 2), "}" ))
    
    lines( log(r),  ceiling(n1 * r), col = "green")
    lines( log(r), n1 + ceiling(n1 *r), col ="skyblue")
    legend("top", legend = c(expression(n[1]), expression(n[2]),"n"), lwd = 3,
           lty = 1, col = c("red", "green", "skyblue"))
    
    text(x = 0, y = min(n1 + n1 * r) + min(n1), labels = paste("n1 = n2 = ", min(n1 + n1 * r)/2))

  })
  
  
  #output$Text1 <- renderText(
  #  paste("50/50: n = ", min(n),", n1 = ", min(n)/2, ", n2 = ", min(n)/2 ))
  

})
