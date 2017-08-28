#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library('shiny')

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Depreciation estimation tool"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(tabsetPanel(tabPanel('Conrete estimation',
      selectInput('Brand', label = h3('Brand'), choices = tabel$Brand , selected = 1)
      ,
      selectInput('Model', label = h3('Model'), choices = tabel$Model2 , selected = 1)
      ,
      selectInput('Edition', label = h3('Edition'), choices = tabel$Edition , selected = 1)
      ,
      selectInput('Age', label = h3('Age'), choices = tabel$Age, selected =  1)
      ,
      numericInput('Mileage', label = h3('Mileage'), value=0)
      
    ),
    tabPanel('Factor based estimation',
             numericInput('NewPrice', label = h3('Price'), value=0)
             , 
             actionButton("actionBrand", label = "Select All")
             ,
             selectInput('Brand2', label = h3('Brand'), choices = tabel$Brand , selected = 1, multiple = TRUE)
             ,
             actionButton("actionModel", label = "Select All")
             ,
             selectInput('Model2', label = h3('Model'), choices = tabel$Model2 , selected = 1, multiple = TRUE)
             ,
             actionButton("actionEdition", label = "Select All")
             ,
             selectInput('Edition2', label = h3('Edition'), choices = tabel$Edition , selected = 1, multiple = TRUE)
             ,
             actionButton("actionAge", label = "Select All")
             ,
             selectInput('Age2', label = h3('Age'), choices = tabel$Age, selected =  1, multiple = TRUE)
             ,
             numericInput('Mileage2', label = h3('Mileage'), value=0)
             ,
             actionButton("actionFueltype", label = "Select All")
             ,
             selectInput('Fueltype', label = h3('Fueltype'), choices = tabel$Fueltype, selected = 1, multiple = TRUE)
             ,
             actionButton("actionTransmission", label = "Select All")
             ,
             selectInput('Transmission', label = h3('Transmission'), choices = tabel$Transmission, selected = 1, multiple = TRUE)
             ,
             actionButton("actionDrivetype", label = "Select All")
             ,
             selectInput('Drivetype', label = h3('Drivetype'), choices = tabel$Drivetype, selected = 1, multiple = TRUE)
             ,
             actionButton("actionColor", label = "Select All")
             ,
             selectInput('Color', label = h3('Color'), choices = tabel$Color, selected = 1, multiple = TRUE)
             ,
             actionButton("actionIColor", label = "Select All")
             ,
             selectInput("InteriorColor", label = h3('InteriorColor'), choices = tabel$Interior.color, selected = 1, multiple = TRUE)
             ))),
    mainPanel( h2('Concrete estimation'),
      textOutput('text'), 
      h2('Factor based estimation'),
      textOutput('text2')
      )
  )
))
