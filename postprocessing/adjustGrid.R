adjustGrid <- function (plotdata) {

  plotdata <<- plotdata +
    theme(panel.grid.major = element_line(colour = "grey75", size=0.25)) +
    theme(panel.grid.minor = element_line(colour = "grey85", size=0.25))

}



