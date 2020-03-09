###############################################################################
###############################################################################
###############################################################################

## hello world ----------------------------------------------------------------

print("hello world")


## ----------------------------------------------------------------------------

###############################################################################

## práce s nápovědou ----------------------------------------------------------

help(print)
?print
???print  # fulltextové prohledávání offline souborů s nápovědou


## instalace nadstavbových balíčků --------------------------------------------

install.packages(
    "swirl",
    dependencies = TRUE,
    repos = "http://cran.us.r-project.org"
)


## numerická hodnota ----------------------------------------------------------

5; -13.8; 4.5578e15
is.numeric(-13.8)   # TRUE
class(-13.8)        # "numeric"
class(Inf)          # "numeric"


## celé číslo -----------------------------------------------------------------

5L; 13L; -5L
is.integer(-13L)   # TRUE
class(-13L)        # "integer"
is.integer(-13)    # FALSE
class(-13)         # "numeric"

x <- 5L
class(x)           # "integer"
x <- as.numeric(x)
class(x)           # "numeric"


## komplexní číslo ------------------------------------------------------------

1 + 2i; 0 + 1i
is.complex(1 + 2i)   # TRUE
class(0 + 1i)        # "complex"
class(sqrt(-1 + 0i)) # "complex"
class(sqrt(-1))      # Warning message:
                     # In sqrt(-1) : NaNs produced


## logická hodnota ------------------------------------------------------------

TRUE; FALSE; T; F
is.logical(TRUE)     # TRUE
class(FALSE)         # "logical"
class("TRUE")        # "character"
class(T)             # "logical"
class(F)             # "logical"


## textový řetězec ------------------------------------------------------------

"ahoj"; 'xweiwogw23425ng'; ""
is.character("ahoj")  # TRUE
class("bla bla")      # "character"
class("123")          # "character"
class(123)            # "numeric"
is.numeric(Inf)       # TRUE
is.numeric("Inf")     # FALSE

x <- 123
class(x)              # "numeric"
x <- as.character(x)
class(x)              # "character"


## chybějící hodnota, NULL, Not a Number --------------------------------------

log(-1)          # NaN
is.na(NaN)       # TRUE
is.nan(NA)       # FALSE
is.nan(1 / 0)    # FALSE
1 / 0            # Inf


## atributy objektů -----------------------------------------------------------

class("ahoj")    # "character"
class(NaN)       # "numeric"
class(NA)        # "logical"
class(class(NA)) # "character"
length("123")    # 1
length(123)      # 1
length(NaN)      # 1
length(NA)       # 1


## přiřazení hodnoty k proměnné -----------------------------------------------

x = 5

# nebo
x <- 5
5 -> x     # totéž

# nebo
assign("x", 5)  # analogické k x <- 5 či x = 5


## zkusme apriorně (bez ověření v R) vyslovit, o jaké datové typy
## jde v následujících případech ----------------------------------------------

1.8
is.logical(is.numeric(-5000))
sqrt(4)           # sqrt() je druhá odmocnina
sqrt(4L)
TRUE
"FALSE"
asin(2)           # asin() je arcus sinus
1 / Inf
-2 / INF
class(TRUE)
class(class(is.complex(1 + 1i)))
"357L"
as.integer("357L")
as.integer("357")
length(12)


## ----------------------------------------------------------------------------

###############################################################################

## vektory a operace s nimi ---------------------------------------------------

###############################################################################

## tvorba vektorů a základní příkazy ------------------------------------------

c()              # prázdný vektor
length(c())      # 0
c(3, 1, 2)       # vektor o délce 3 a prvcích 3, 1, 2
c("a", "d")      # vektor o dél. 2 a prvcích "a", "d"
c(c(3, 1, 2), 4) # vektor o prvcích 3, 1, 2, 4
c(3, 1, 2, 4)    # zkráceně totéž


x <- c(3, 1, 2)
length(x)       # 3
y <- 1
z <- c(2)
w <- c(5, 7)
x <- c(x, y)    # prodloužení vektoru x
                # o hodnotu y
w <- c(w, z)    # prodloužení vektoru w
                # o vektor z
                # jednoprvkový vektor je
                # skalárem, jednou hodnotou
c <- c(1, 2, 3)
c               # vektor o prvcích 1, 2, 3
                # byť je c referovaný termín,
                # funkce c je zachována
                # a vznikl vektor c


## vektory textových řetězců --------------------------------------------------

x <- c(3, 1, 2)
y <- c("a", "b", "c")
names(x) <- y    # pojmenuje prvky
                 # vektoru x
x
unname(x)        # zbaví prvky vektoru
                 # x jeho jejich jmen
setNames(x, y)   # opět pojmenuje
                 # prvky vektoru x


## subvektory, indexování, adresace -------------------------------------------

x <- 1:10    # vektor o prvcích 1, 2, ..., 10
y <- 5:1     # vektor o prvcích 5, 4, ..., 1
z <- seq(from = 2, to = 10, by = 2)
             # vektor o prvcích 2, 4, 6, 8, 10
w <- seq(2, 10, 2)
             # totéž


x <- c(4, 2, 6, -3)
x[1]            # 4
x[1:2]          # c(4, 2)
x[5]            # NA
x[length(x)]    # -3
x[c(1, 3, 4)]   # c(4, 6, -3)
x[length(x):1]  # c(-3, 6, 2, 4)
rev(x)          # totéž, c(-3, 6, 2, 4)


## logické vektory ------------------------------------------------------------

y <- c(TRUE, TRUE, FALSE, TRUE) # logický vektor
x <- c(3, 1, 2, 5)
x[y]                 # (sub)vektor c(3, 1)
x[c(F, T, F, T)]     # subvektor c(1, 5)

z <- c("R", "G", "E", "F", "I")
z[c(T, F)]    # vybere pouze hodnoty
              # na lichých pozicích,
              # tedy "R", "E", "I"
              # neboli vektor
              # c("R", "E", "I")


## vypišme z vektoru x každou třetí a pátou hodnotu ---------------------------

x <- c(
    34, 65, 4, 0, 56, 23, 54, 17,
    4, 8, 5, 44, 84, -5, 4444, 49,
    37, 86, 45, 65, 36, 72, 54, 36,
    56, 74, 26, 88, 36, 76, 46,
    17, 84, 57, 25, -75, 634, 5578,
    -6, 46, 44, 743, 577, 466,
    645, 33, 64, 67
)


## faktory --------------------------------------------------------------------

x <- factor(
  c("muž", "žena", "muž", "muž")
)        # pořadí kategorií je defaultně
         # abecední
x <- factor(
  c("muž", "žena", "muž", "muž"),
  levels = c("žena", "muž")
)        # zde si pořadí kategorií
         # určíme sami

table(x)
# x
# žena  muž 
#    1    3 


## aritmetické operace --------------------------------------------------------

2 + 3                   # 5
15 + 25 + 35            # 75
c(1, 2) + c(10, 20)     # c(11, 22)
`+`(2, 3)               # 5
`+`(15, 25, 35)         # Error: operator needs
                        # one or two arguments
`+`(`+`(15, 25), 35)    # 75
`+`(c(1, 2), c(10, 20)) # c(11, 22)

12 * 3                  # 36
35 * 25 * 15            # 13125
c(12, 25) * c(3, 6)     # c(36, 150)
`*`(12, 3)              # 36
`*`(35, 25, 15)         # Error: operator needs
                        # one or two arguments
`*`(`*`(35, 25), 15)    # 13125
`*`(c(12, 25), c(3, 6)) # c(36, 150)

12 / 3                  # 4
45 / 5 / 3              # 3
c(12, 25) / c(3, 5)     # c(4, 5)
`/`(12, 3)              # 4
`/`(45, 5, 3)           # Error: operator needs
                        # one or two arguments
`/`(`/`(45, 5), 3)      # 3
`/`(c(12, 25), c(3, 5)) # c(4, 5)

2 ^ 3                   # 8
2 ** 3                  # 8; Python-like notace
4 ^ 3 ** 2              # 262144
4 ^ (3 ** 2)            # 262144
(4 ^ 3) ** 2            # 4096; pozor na
                        # uzávorkování !!!
c(25, 36) ^ 0.5         # c(5, 6); odmocňování
c(5, 3) ^ c(2, 3)       # c(25, 27)
c(5, 3) ** c(2, 3)      # c(25, 27)
`^`(2, 3)               # 8
`**`(2, 3)              # Error: could not find
                        # function "**"
`^`(4, 3, 2)            # Error: operator needs
                        # one or two arguments
`^`(`^`(4, 3), 2)       # 4096
`^`(c(5, 3), c(2, 3))   # c(25, 27)

12 %% 3                 # 0
10 %% 3                 # 1
10 %% -3                # -2
5 %% 0                  # NaN; n nesmí
                        # být nula !
17 %% 23                # 17

12 %/% 3                   # 4
10 %/% 3                   # 3
10 %/% -3                  # -2
5 %/% 0                    # Inf
17 %/% 23                  # 0
23 %/% 17                  # 1
17 %/% 5                   # 3; celočíselné
                           # dělení
(17 - 17 %% 5) / 5         # 3; explicitní
                           # výpočet
(17 %/% 5) * 5 + (17 %% 5) # 17


# definuji vlastní operátor
'%očaruj_pomocí%' <- function(x, y){x^2 + y}

5 %očaruj_pomocí% 4        # 5 \^{} 2 + 4 = 29
6 %očaruj_pomocí% -3       # 6 \^{} 2 - 3 = 33

# definuji operátor, který vrací TRUE, právě když
# je první číslo celočíselným dělitelem druhého
'%d%' <- function(d, n){n %% d == 0}

3 %d% 9                    # TRUE
4 %d% 9                    # FALSE
`%d%`(7, 21)               # TRUE; prefix notace


## logické operace ------------------------------------------------------------

c(FALSE, FALSE, TRUE, TRUE) &
c(FALSE, TRUE, FALSE, TRUE)
    # c(FALSE, FALSE, FALSE, TRUE)

c(FALSE, FALSE, TRUE, TRUE) &&
c(FALSE, TRUE, FALSE, TRUE)
    # FALSE

c(FALSE, FALSE, TRUE, TRUE) |
c(FALSE, TRUE, FALSE, TRUE)
    # c(FALSE, TRUE, TRUE, TRUE)

c(FALSE, FALSE, TRUE, TRUE) ||
c(FALSE, TRUE, FALSE, TRUE)
    # FALSE, protože první dvojice vrací FALSE

xor(c(FALSE, FALSE, TRUE, TRUE),
  c(FALSE, TRUE, FALSE, TRUE))
    # c(FALSE, TRUE, TRUE, FALSE)


! TRUE              # FALSE
! 2 > 3             # TRUE 

all(c(3 > 2, 7 %% 3 == 1, 1 == 0))  # FALSE
all(c(3 > 2, 7 %% 3 == 1, 1 >= 0))  # TRUE

any(c(3 < 2, 7 %% 3 <= 0, FALSE))   # FALSE
any(c(3 < 2, 7 %% 3 >= 1, FALSE))   # TRUE


## operace porovnávání --------------------------------------------------------

2 == 3             # FALSE
`==`("a", "a")     # TRUE; prefix notace
all.equal(c(1, 2), c(1, 2 + 1e-13),
          tolerance = 1e-12)
                   # TRUE; porovnává vektory
                   # volitelnou danou tolerancí
identical(c(1, 2), c(1, 2 + 1e-13))
                   # FALSE, porovnává objekty
                   # a vrací TRUE jen při úplné
                   # shodě

2 < 3              # TRUE
"b" <= "a"         # FALSE; porovnává pořadí
                   # v abecedě
`>`(12, 11)        # TRUE; prefix notace
FALSE >= TRUE      # FALSE; porovnává hodnotu
                   # v booelovské aritmetice
                   # (TRUE := 1, FALSE := 0)
2 != 3             # TRUE     
TRUE != FALSE      # TRUE
`!=`(FALSE, FALSE) # FALSE; prefix notace

c(2, 6) %in% c(1:5)      # c(TRUE, FALSE)
"k" %in% LETTERS         # FALSE
"J" %in% letters         # FALSE
"May" %in% month.name    # TRUE
`%in%`("Jan", month.abb) # TRUE; prefix notace
"a" %in% "abeceda"       # FALSE

is.element(c(2, 6), c(1:5))
                         # c(TRUE, FALSE)
is.element(c(1:5), c(2, 6))
                         # c(FALSE, TRUE,
                         # FALSE, FALSE, FALSE)

isTRUE(3^2 > 2^3)        # TRUE


## množinové operace ----------------------------------------------------------

union(c(1, 2, 3), c(5, 1))       # c(1, 2, 3, 5)

intersect(c(1, 2, 3), c(5, 1))   # c(1)

setdiff(c(1, 2, 3), c(5, 1))     # c(2, 3)

union(setdiff(c(1, 2, 3), c(5, 1)),
      setdiff(c(5, 1), c(1, 2, 3)))
                                 # c(2, 3, 5)
                             
setequal(c(1, 2, 3), c(5, 1))    # FALSE
setequal(c(1, 2, 3), c(3, 2, 1)) # TRUE


## zaokrouhlování, formátování čísel ------------------------------------------

round(1.4, digits = 0)     # 1
round(-146.655, 2)         # -146.66

signif(1.458, digits = 1)  # 1
signif(1.458, digits = 2)  # 1.5
signif(1.458, digits = 3)  # 1.46
signif(1.458, digits = 4)  # 1.458

format(1.45, nsmall = 1)   # "1.45"
format(1.45, nsmall = 2)   # "1.45"
format(1.45, nsmall = 3)   # "1.450"


## konstanty ------------------------------------------------------------------

pi             # 3.141593; Ludolfovo číslo
exp(1)         # 2.718282; Eulerovo číslo
Inf            # nekonečno
-Inf           # mínus nekonečno
letters        # malá písmena anglické abecedy
LETTERS        # velká písmena anglické abecedy
month.name     # názvy měsíců
month.abb      # zkratky názvů měsíců
weekdays(Sys.Date())
               # vrátí aktuální den v týdnu
weekdays(seq(as.Date("2018-10-01"),
             as.Date("2018-10-07"), 1))
               # vypíše názvy dnů v týdnu


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





