#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)


# Define server logic 
shinyServer(function(input, output, session) 
  {
  observe({
  
  Modelchoices <-tabel$Model2[tabel$Brand==as.character (input$Brand)]
  
  #Modelchoices <- as.character(Modelchoices)
  Modelchoices <- unique(Modelchoices)
  
  updateSelectInput(session, "Model",
                    choices = Modelchoices)
  }) 
  observe({
    
    EditionChoices <-tabel$Edition[tabel$Model2==as.character(input$Model) & tabel$Brand==as.character (input$Brand)]
    EditionChoices <- unique(EditionChoices)
    updateSelectInput(session, "Edition", choices = EditionChoices)
  })
  observe({
    
    AgeChoices <-tabel$Age[tabel$Edition==(input$Edition) & tabel$Model2==as.character(input$Model)]
    AgeChoices <- unique(AgeChoices)
    updateSelectInput(session, "Age", choices = AgeChoices)
  })
  observe({
    IBrand <-  as.character (input$Brand) 
    IModel <-  as.character (input$Model) 
    IEdition <-  as.character (input$Edition) 
    IAge <- as.numeric (input$Age) 
    IMileage <- as.numeric (input$Mileage)
    
    
                   
  
  #tyyype <- typeof(IAge)
  Prices <- tabel$NewPrice[tabel$Brand==IBrand & tabel$Edition==IEdition & tabel$Model2==IModel & tabel$Age==IAge]
  Price <- mean(Prices)
  DRates <- tabel$RDPY[tabel$Brand==IBrand & tabel$Edition==IEdition & tabel$Model2==IModel & tabel$Age==IAge]
  MeanDRate <- mean(DRates)
  if(IMileage<=26924){DRate <- MeanDRate*(1-0.16664875172646890686873829026376)}
  else if (IMileage>=26924 & IMileage<=35649){DRate <- MeanDRate*(1-0.05790086417331870094428982144869)}
  else if (IMileage>=35649 & IMileage<=50260){DRate <- MeanDRate*(1.014233197441279193493872339360153)}
  else DRate <- MeanDRate*(1.2087026551109738745091821023071)
  CurValue <- Price - Price*(DRate/100)*IAge
  CurValue <- Price - Price*(DRate/100)*IAge
  Dep <- Price-CurValue 
  Rows <- length(Prices)
  output$text <- renderText({paste('Your car is estimated to have a current value of: $',format(round(CurValue, 2), nsmall = 2)
, '. Its new price was: $',Price, '. It has depreciated for $',format(round(Dep, 2), nsmall = 2),
                ' in value and has decreased for', format(round(DRate, 2), nsmall = 2), '% each year.', 'This estimation was based on', Rows, 'similar cars')})
  
  })
  
  
  
  
  
  
  observe({
    IBrand2 <-  as.character (input$Brand2) 
    IModel2 <-  as.character (input$Model2) 
    IEdition2 <-  as.character (input$Edition2) 
    IAge2 <- as.numeric (input$Age2) 
    IMileage2 <- as.numeric (input$Mileage2)
    IFueltype <- input$Fueltype
    ITransmission <- input$Transmission
    IDrivetype <- input$Drivetype
    IColor <- input$Color
    IntColor <- input$InteriorColor
    Price2 <- input$NewPrice
    
    #DRates2 <- tabel$RDPY[tabel$Brand==IBrand2 & tabel$Edition==IEdition2 & tabel$Model2==IModel2 & tabel$Age==IAge2 & tabel$Fueltype==IFueltype]
    DRates2 <- tabel$RDPY[tabel$Brand==IBrand2 & tabel$Model2==IModel2 & tabel$Edition==IEdition2 & tabel$Age==IAge2 & tabel$Fueltype==IFueltype]
    
    MeanDRate2 <- mean(DRates2)
    if(IMileage2<=26924){DRate2 <- MeanDRate2*(1-0.16664875172646890686873829026376)}
    else if (IMileage2>=26924 & IMileage2<=35649){DRate2 <- MeanDRate2*(1-0.05790086417331870094428982144869)}
    else if (IMileage2>=35649 & IMileage2<=50260){DRate2 <- MeanDRate2*(1.014233197441279193493872339360153)}
    else DRate2 <- MeanDRate2*(1.2087026551109738745091821023071)
    CurValue2 <- Price2 - Price2*(DRate2/100)*IAge2
    Dep2 <- Price2-CurValue2 
    Rows2 <- length(DRates2)
    output$text2 <- renderText({paste( 'Your car is estimated to have a current value of: $',format(round(CurValue2, 2), nsmall = 2)
                                     , '. Its new price was: $',Price2, '. It has depreciated for $',format(round(Dep2, 2), nsmall = 2),
                                     ' in value and has decreased for', format(round(DRate2, 2), nsmall = 2), '% each year.', 'This estimation was based on', Rows2, 'similar cars')})
    
        })
  
  observe({
    observeEvent(input$actionBrand, {
      updateSelectInput(session, "Brand2",
                        selected = unique(tabel$Brand))
    })}) 
  
  observe({
    Modelchoices2 <-tabel$Model2[tabel$Brand==(input$Brand2)]
    Modelchoices2 <- unique(Modelchoices2)
    updateSelectInput(session, "Model2",
                      choices = Modelchoices2)
  }) 
  observe({
    observeEvent(input$actionModel, {
     updateSelectInput(session, "Model2",
                      selected = unique(tabel$Model2[tabel$Brand==(input$Brand2)]))
    })}) 
  observe({
    
    EditionChoices2 <-tabel$Edition[tabel$Model2==as.character(input$Model2)]
    EditionChoices2 <- unique(EditionChoices2)
    updateSelectInput(session, "Edition2", choices = EditionChoices2)
  })
  observe({
    observeEvent(input$actionEdition, {
      updateSelectInput(session, "Edition2",
                        selected = unique(tabel$Edition[tabel$Model2==input$Model2]))
    })})
  observe({
    
    AgeChoices2 <-tabel$Age[tabel$Edition==(input$Edition2)]
    AgeChoices2 <- unique(AgeChoices2)
    updateSelectInput(session, "Age2", choices = AgeChoices2)
  })
  observe({
    observeEvent(input$actionAge, {
      updateSelectInput(session, "Age2",
                        selected = unique(tabel$Age[tabel$Edition==(input$Edition2)]))
    })})
  observe({
    
    FtChoices2 <-tabel$Fueltype[tabel$Age==(input$Age2)]
    FtChoices2 <- unique(FtChoices2)
    updateSelectInput(session, "Fueltype", choices = FtChoices2)
  })
  observe({
    observeEvent(input$actionFueltype, {
      updateSelectInput(session, "Fueltype",
                        selected = unique(tabel$Fueltype[tabel$Age==(input$Age2)]))
    })})
  observe({
    
    TChoices2 <-tabel$Transmission[tabel$Fueltype==(input$Fueltype)]
    TChoices2 <- unique(TChoices2)
    updateSelectInput(session, "Transmission", choices = TChoices2)
  })
  observe({
    observeEvent(input$actionTransmission, {
      updateSelectInput(session, "Transmission",
                        selected = unique(tabel$Transmission[tabel$Fueltype==(input$Fueltype)]))
    })})
  observe({
    
    DtChoices2 <-tabel$Drivetype[tabel$Transmission==(input$Transmission)]
    DtChoices2 <- unique(DtChoices2)
    updateSelectInput(session, "Drivetype", choices = DtChoices2)
  })
  observe({
    observeEvent(input$actionDrivetype, {
      updateSelectInput(session, "Drivetype",
                        selected = unique(tabel$Drivetype[tabel$Transmission==(input$Transmission)]))
    })})
  observe({
    
    ColorChoices2 <-tabel$Color[tabel$Drivetype==(input$Drivetype)]
    ColorChoices2 <- unique(ColorChoices2)
    updateSelectInput(session, "Color", choices = ColorChoices2)
  })
  observe({
    observeEvent(input$actionColor, {
      updateSelectInput(session, "Color",
                        selected = unique(tabel$Color[tabel$Drivetype==(input$Drivetype)]))
    })})
  observe({
    
    ICChoices2 <-tabel$Interior.Color[tabel$Color==(input$Color)]
    ICChoices2 <- unique(ICChoices2)
    updateSelectInput(session, "InteriorColor", choices = ICChoices2)
  })
  observe({
    observeEvent(input$actionIColor, {
      updateSelectInput(session, "InteriorColor",
                        selected = unique(tabel$Interior.Color[tabel$Color==(input$Color)]))
    })})
})
  
