## Setup
source("server.R")

## Specify layout
shinyUI(pageWithSidebar(
    
    headerPanel(HTML("Mortgage Calculator")),
    
    
    sidebarPanel(
        ## Construct input options
        
        ## Enter mortgage information
        h4("Mortgage parameters"),
        
        ## Loan amount
        numericInput("principal", "Amount borrowed", 500000, min=1),
        helpText("Total amount borrowed, also known as loan's principal."),
        
        ## Interest rate
        numericInput("interest", "Yearly interest rate (in %)", 5, min=0.01, max=100, step=0.01),
        helpText("The yearly interest rate (in %)."),
        
        ## Loan duration
        numericInput("duration", "Loan duration (in years)", 40, min=1/12, max=100, step=1/12),
        helpText("The total duration of the loan in years. It can be a fraction with 1/12 increments per extra month, for example 3.5 years (3 years and 6 months)."),
        
        ## Payment frequency
        sliderInput("payfreq", "Payment frequency (in months)", value=1, min=1, max=12, step=1),
        helpText("How frequently you will make payments? (in months) Minimum every month and maximum every year (12 months)."),
        
        ## When will you make your first payment?
        numericInput("firstpay", "Month of the first payment", 1, min=1, max=5 * 12, step=1),
        helpText("In which month will you make your first payment?"),
        
        ## Frquency of interest compounding
        numericInput("compoundfreq", "How frequently are interests compounded? (in months)", value=1, min=1, max=12, step=1),
        helpText("That is, how frequently interests are calculated. Banks will normally compound the interest at the same frequency that payments are made. Only consider a more frequent interest compounding than payment frequency if the loaner is willing to give you such a deal (for example, to reduce costs from commissions on currency trades or wire transfers).")
           
    ),
    
    mainPanel(
        h4("Overview"),
        verbatimTextOutput("payment"),
        h4("Loan's total remaining amount"),
        p("The following plot shows the loan's total remaining amount over time,  as well as the total amount paid."),
        showOutput("myChart", "nvd3"),
        h4("Payments table"),
        p("The following interactive table shows how much you pay (and when), the total amount you have payed and the remaining amount (it is only shown for the months when interest compounding is calculated)."),
        dataTableOutput("amort"),
        tags$hr()
    )
    
))