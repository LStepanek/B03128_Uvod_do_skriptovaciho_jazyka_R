###############################################################################
###############################################################################
###############################################################################

## komponenty funkce ----------------------------------------------------------

f <- function(x){x ^ 2}
f

formals(f)
body(f)
environment(f)


## vlastní funkce -------------------------------------------------------------

sectiCtverce <- function(a, b){
    
    # '''
    # vrací součet čtverců čísel "a" a "b"
    # '''
    
    return(a ^ 2 + b ^ 2)
    
}


## pořadí argumentů v hlavičce funkce -----------------------------------------

f <- function(ab, abc, b){
    1 * ab + 2* abc + 3 * b
}
f(ab = 1, abc = 2, b = 3) # 14
f(abc = 2, ab = 1, b = 3) # 14
f(1, 2, 3)                # 14
f(2, 1, 3)                # 13
f(ab = 1, ab = 2, b = 3)
    # formal argument "ab" matched
    # by multiple actual arguments
f(a = 1, abc = 2, b = 3)  # 14


## iterování nad funkcemi -----------------------------------------------------

set.seed(1); x <- floor(runif(100) * 100)

for(my_function in c(
    "mean",
    "min",
    "max",
    "median",
    "sd",
    "var",
    function(i) i %% 10
)){
    print(do.call(my_function, list(x)))
}


## defaultní argument ---------------------------------------------------------

f <- function(a = 1, b = 2){c(a, b)}
f()  # c(1, 2)

g <- function(a = 1, b = a * 2){c(a, b)}
g()  # c(1, 2)

h <- function(a = 1, b = d){
    d <- (a + 1) ^ 2; c(a, b)
}
h()  # c(1, 4)


## chybějící argument ---------------------------------------------------------

i <- function(a, b){
    c(missing(a), missing(b))
}
i()      # TRUE TRUE
i(a = 1) # FALSE  TRUE
i(b = 2) # TRUE FALSE
i(1, 2)  # FALSE FALSE


## dot-dot-dot argument -------------------------------------------------------

f <- function(x, ...){
    mean(x, ...)
}
f(c(0, 1, 2, 3, 3, 3, 3))
    # 2.142857
f(c(0, 1, 2, 3, 3, 3, 3), trim = 1) 
    # 3


## ----------------------------------------------------------------------------

###############################################################################

## příklady předzpracování dat ------------------------------------------------

library("openxlsx")

my_data <- read.xlsx(
    xlsxFile = "moje_data.xlsx",
    detectDates = TRUE
)

str(my_data)


## přetypovávám proměnné na textové
for(my_variable in setdiff(
    
    colnames(my_data),
    "datum_narozeni"
    
)){
    
    my_data[, my_variable] <- as.character(
        my_data[, my_variable]
    )
    
}

str(my_data)


## nyní přetypovávám vybrané proměnné na numerické
for(my_variable in c(
    
    "hmotnost",
    "vyska"
    
)){
    
    my_data[, my_variable] <- as.numeric(
        my_data[, my_variable]
    )
    
}

str(my_data)


## doplňuji pohlaví na sel-labeling hodnoty kategorií -------------------------

my_gender <- NULL

for(i in 1:dim(my_data)[1]){
    
    my_gender <- c(
        
        my_gender,
        if(my_data[i, "pohlavi"] == "z"){
            "zena"
        }else{
            "muz"
        }
        
    )
    
}

my_data[, "pohlavi"] <- my_gender


## dopočítávám věk pacientů k dnešnímu dni ------------------------------------

my_data <- data.frame(
    
    my_data,
    "vek" = as.numeric(
        Sys.Date() - my_data[, "datum_narozeni"]
    ) / 365.25,
    stringsAsFactors = FALSE
    
)


## definuji vlastní funkci pro výpočet BMI ------------------------------------

getMyBMI <- function(weight, height){
    
    # '''
    # vrací BMI pro danou hmotnost "weight" [kg] a vysku "height" [m]
    # '''
    
    return(
        weight / (height ^ 2)
    )
}

my_BMI <- NULL

for(i in 1:dim(my_data)[1]){
    
    my_BMI <- c(
        
        my_BMI,
        getMyBMI(
            weight = my_data[i, "hmotnost"],
            height = my_data[i, "vyska"] / 100
        )
        
    )
    
}

my_data[, "BMI"] <- my_BMI


## počítám průměry pro obě pohlaví --------------------------------------------

my_table <- NULL

for(my_variable in c(
    
    "hmotnost",
    "vyska",
    "BMI"
    
)){
    
    my_row <- NULL
    
    for(my_gender in c(
        
        "zena",
        "muz"
        
    )){
        
        my_row <- c(
            
            my_row,
            mean(
                my_data[
                    my_data[, "pohlavi"] == my_gender,
                    my_variable
                ]
            )
            
        )
        
        names(my_row)[length(my_row)] <- my_gender
        
    }
    
    my_table <- rbind(
        
        my_table,
        my_row
        
    )
    
    rownames(my_table)[dim(my_table)[1]] <- my_variable
    
}

write.csv2(
    x = my_table,
    file = "tabulka_s_prumery.csv"
)


## kreslím diagramy -----------------------------------------------------------

boxplot(
    hmotnost ~ pohlavi,
    my_data,
    col = "lightgrey",
    xlab = "pohlaví",
    ylab = "hmotnost [kg]"
)

boxplot(
    vyska ~ pohlavi,
    my_data,
    col = "lightgrey",
    xlab = "pohlaví",
    ylab = "výška [cm]"
)

boxplot(
    BMI ~ pohlavi,
    my_data,
    col = "lightgrey",
    xlab = "pohlaví",
    ylab = "BMI"
)

plot(
    BMI ~ vek,
    my_data,
    xlab = "věk [rok]",
    ylab = "BMI"
)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





