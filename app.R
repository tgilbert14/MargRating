library(shiny)
library(shinyMobile)

# Define UI for application
ui <- f7Page(
  title = "Margarita and Pretzel Rating App",
  f7SingleLayout(
    navbar = f7Navbar(title = "Rate Your Margarita and Pretzel"),
    f7Card(
      title = "Enter Location Details",
      f7Text(inputId = "location", label = "Location", placeholder = "Enter location"),
      br(),
      f7Text(inputId = "margarita_rating", label = "Margarita Rating", placeholder = "Enter rating (1-5)"),
      br(),
      f7Text(inputId = "pretzel_rating", label = "Pretzel Rating", placeholder = "Enter rating (1-5)"),
      br(),
      f7Button(inputId = "submit", label = "Submit", color = "blue")
    ),
    f7Card(
      title = "Previous Ratings",
      tableOutput("table")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  ratings <- reactiveValues(data = data.frame(Location = character(), Margarita = numeric(), Pretzel = numeric()))
  
  observeEvent(input$submit, {
    new_entry <- data.frame(Location = input$location, Margarita = as.numeric(input$margarita_rating), Pretzel = as.numeric(input$pretzel_rating))
    ratings$data <- rbind(ratings$data, new_entry)
  })
  
  output$table <- renderTable({
    ratings$data
  }, rownames = FALSE)
}

# Run the application 
shinyApp(ui = ui, server = server)
