###############################################################################
###############################################################################
###############################################################################

## pracovní složka ------------------------------------------------------------

# zjištění, která složka je pracovní
getwd()

# výpis obsahu pracovní složky formou vektoru
dir()

# nastavení pracovní složky
setwd("<cesta k pracovní složce>")

# nastavení pracovní složky dialogovým oknem
setwd(choose.dir())


## ----------------------------------------------------------------------------

## import a export dat z textu ------------------------------------------------

browseURL(
    paste(
        "https://ubi.lf1.cuni.cz",
        "uvod-do-skriptovaciho-jazyka-r",
        sep = "/"
    )
)

my_html <- readLines(  # webscraping webové stránky
    con = paste(
        "https://ubi.lf1.cuni.cz",
        "uvod-do-skriptovaciho-jazyka-r",
        sep = "/"
    ),
    encoding = "UTF-8"
)

head(my_html, 20)


# uložení a načtení desktopového dokumentu  
writeLines(         # ukládám textový dokument
    text = paste(
        "One R to rule them all",
        "one R to find them",
        "one R to bring them all",
        "and in the darkness bind them",
        sep = "\n"  # separátor typu nový řádek
    ),
    con = "my_text.txt"
)

my_loaded_text <- readLines(
    con = "my_text.txt",
    encoding = "UTF-8"
)                   # načítám textový dokument


## import a export dat tabulky ------------------------------------------------

write.table(            # ukládám data.frame
    x = mtcars,
    sep = ";",
    row.names = FALSE,
    file = "mtcars.csv" # anebo "mtcars.txt"
)

my_mtcars <- read.table(
    file = "mtcars.csv",
    sep = ";",
    header = TRUE
)                       # načítám data.frame


# anebo
write.table(x = iris,
            file = "iris.txt")

my_iris <- read.table(
    file = "iris.txt",
    sep = " ",
    header = TRUE,
    stringsAsFactors = FALSE,
    check.names = FALSE,
                 # vynechá kontrolu korektnosti
                 # popisků sloupců
    colClasses = "character"
                 # přetypuje všechny sloupce
                 # na textové proměnné
)


## ----------------------------------------------------------------------------

## import a export dat tabulky z MS Excel -------------------------------------

# install.packages(
    # "openxlsx",
    # dependencies = TRUE,
    # repos = "http://cran.us.r-project.org"
# )

library("openxlsx")

#### nastavuji handling se zipováním v R
#### !!! nutné předem nainstalovat Rtools z adresy
#### https://cran.r-project.org/bin/windows/Rtools/
Sys.setenv(R_ZIPCMD = "C:/Rtools/bin/zip")

## vytvářím sešit
my_workbook <- createWorkbook()

## tohle jsou moje data, je to věstavěný dataset mtcars
my_table <- mtcars

## vytvářím excelový list
addWorksheet(
    wb = my_workbook,
    sheetName = "můj první list"
)

## ukládám do listu data
writeData(
    wb = my_workbook,
    sheet = "můj první list",
    rowNames = FALSE,
    colNames = TRUE,
    x = my_table
)


## NEPOVINNÉ ÚPRAVY VÝSLEDNÉHO EXCELOVÉHO DOKUMENTU ---------------------------

## nastavuji automatickou šířku sloupce
setColWidths(
    wb = my_workbook,
    sheet = "můj první list",
    cols = 1:dim(my_table)[2],
    widths = "auto"
)

## vytvářím dva své styly - jednak tučné písmo, jednak písmo zarovnané
## doprava v rámci buňky
my_bold_style <- createStyle(textDecoration = "bold")
right_halign_cells <- createStyle(halign = "right")

addStyle(
    wb = my_workbook,
    sheet = "můj první list",
    style = my_bold_style,
    rows = rep(1, dim(my_table)[2]),
    cols = 1:dim(my_table)[2]
)

addStyle(
    wb = my_workbook,
    sheet = "můj první list",
    style = right_halign_cells,
    rows = 1:(dim(my_table)[1]),
    cols = 2:(dim(my_table)[2] + 1),
    gridExpand = TRUE
)

## KONEC NEPOVINNÝCH ÚPRAV ----------------------------------------------------

## ukládám workbook
saveWorkbook(
    wb = my_workbook,
    file = "moje_tabulka_je_ted_v_excelu.xlsx",
    overwrite = TRUE
)

## načtení excelové tabulky
my_data <- read.xlsx(
  xlsxFile = "moje_tabulka_je_ted_v_excelu.xlsx",
  sheet = 1,   # anebo jméno listu
  colNames = TRUE
)


## export konzolového výpisu do souboru ---------------------------------------

(muzi <- rnorm(100, mean = 175, sd = 10))
(zeny <- rnorm(100, mean = 160, sd = 10))

t.test(muzi, zeny)

# výpis z konzole do textového souboru
capture.output(   
    t.test(muzi, zeny),
    file = "t_test.txt"          
)

# anebo
sink("tohle_je_taky_t_test.txt")
t.test(muzi, zeny)
sink()


## export konzolového výpisu do TeXového kódu ---------------------------------

library("xtable")

my_linear_model <- lm(mpg ~ hp + cyl,
                      mtcars)

xtable(my_linear_model, digits = 4)

# anebo
print(xtable(my_linear_model,
               digits = 4),
      floating = FALSE,
      tabular.environment = "tabular",
      hline.after = NULL,
      include.rownames = TRUE,
      include.colnames = TRUE)

## výstup v konzoli lze ihned použít např. k vysázení online dokumentu na
## https://tex.mendelu.cz/new/


## import exotických souborů do R ---------------------------------------------

library("foreign")

# import dat z SPSS
my_data <- read.spss(    
    file = "soubor_z_SPSS.sav",
    to.data.frame = TRUE
)


## ----------------------------------------------------------------------------

###############################################################################

## podmínka když --------------------------------------------------------------

x = 1

if(x == 1){
    print("x je rovno 1")
}      

# anebo
x = 2

if(x == 1){
    print("x je rovno 1")
}else{
    print("x není rovno 1")
}


## for cyklus -----------------------------------------------------------------

for(i in 1:5){
    
    print(i)
    
}

# anebo
for(my_letter in letters){
    
    print(
        paste(my_letter, "je fajn", sep = " ")
    )
    
}


## while cyklus ---------------------------------------------------------------

i <- 1

while(i <= 5){      
    print(i)
    i <- i + 1
}
  
# anebo
my_letters <- letters

while(length(my_letters) > 0){
    
    print(
        paste(my_letters[1], "je fajn", sep = " ")
    )
    my_letters <- my_letters[-1]
    
}


## repeat-until cyklus --------------------------------------------------------

i <- 1

while(TRUE){    
    if(i == 6){break}
    print(i)
    i <- i + 1
}

# anebo
my_letters <- letters

while(TRUE){      
    if(length(my_letters) == 0){break}    
    print(
        paste(my_letters[1], "je fajn", sep = " ")
    )
    my_letters <- my_letters[-1]      
}


## varovani -------------------------------------------------------------------

log(-5) # NaN; In log(-5) : NaNs produced

logaritmuj <- function(x){      
    # vrací přirozený logaritmus čísla "x"
    if(x <= 0){
        cat(
            "x je nekladné, bude vráceno NaN\n"
        )
    }
    return(suppressWarnings(log(x)))      
}

logaritmuj(-5) # NaN; x je nekladné, bude vráceno NaN


## chyby ----------------------------------------------------------------------

"1" + "1" # Error: non-numeric argument to binary
           # operator

sectiCtverce <- function(a, b){        
    # '''
    # vrací součet čtverců čísel "a" a "b"
    # '''        
    if(!is.numeric(a)){stop("a musí být číslo!")}
    if(!is.numeric(b)){stop("b musí být číslo!")}        
    return(a ^ 2 + b ^ 2)        
}

sectiCtverce(1, 2)   # 5
sectiCtverce(1, "2") # Error: b musí být číslo!


## ----------------------------------------------------------------------------

###############################################################################

## rodina funkcí apply() ------------------------------------------------------

# vrací průměry nad všemi sloupci "mtcars"
x <- apply(mtcars, 2, mean)

# méně šikovně to samé
x <- NULL
for(i in 1:dim(mtcars)[2]){
    x <- c(x, mean(mtcars[, i]))
}
names(x) <- colnames(mtcars)


## funkce apply() -------------------------------------------------------------

apply(mtcars, 2, mean)
  
my_start <- Sys.time()
(x <- apply(mtcars, 2, mean))
my_stop <- Sys.time()
my_stop - my_start # 0.019s
    
my_start <- Sys.time()
x <- NULL
for(i in 1:dim(mtcars)[2]){
    x <- c(x, mean(mtcars[, i]))
    names(x)[length(x)] <- colnames(mtcars)[i]
}
x
my_stop <- Sys.time()
my_stop - my_start # 0.039s


## funkce lapply() ------------------------------------------------------------

#### vhodná i pro adresaci v listu
my_long_list <- lapply(
    sample(c(80:120), 100, TRUE),
    function(x) sample(
        c(50:150), x, replace = TRUE
    )
)   # list vektorů náhodné délky
    # generovaných z náhodných čísel

lapply(my_long_list, "[[", 14)
    # z každého prvku listu (vektoru)
    # vybírám jen jeho 14. prvek


## náhrada for cyklu funkcí lapply() ------------------------------------------

# for cyklus
my_start <- Sys.time()

for_x <- NULL 
for(i in 1:100000){for_x <- c(for_x, i ^ 5)}
head(for_x)

my_stop <- Sys.time()
my_stop - my_start # 18.45s

# lapply
my_start <- Sys.time()

lapply_x <- unlist(
    lapply(
        1:100000, function(i) i ^ 5
    )
)
head(lapply_x)

my_stop <- Sys.time()
my_stop - my_start # 0.10s


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





