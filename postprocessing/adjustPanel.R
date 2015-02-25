adjustPanel <- function(plotdata) {

  plotdata <<- plotdata +
    theme(panel.background = element_rect(fill = "white",
                                          colour = NA)) +
    theme(panel.border = element_rect(fill = NA,
                                      color = "black",
                                      size=0.5,
                                      linetype="solid"))

}
