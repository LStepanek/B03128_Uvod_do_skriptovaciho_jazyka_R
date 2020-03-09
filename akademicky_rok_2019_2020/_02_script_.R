###############################################################################
###############################################################################
###############################################################################

## tvorba matic a základní příkazy --------------------------------------------

A <- matrix(c(1, 2, 3, 4), nrow = 2,
            ncol = 2)
B <- matrix(c(1, 3, 2, 4), nrow = 2,
            ncol = 2)
B <- matrix(c(1, 2, 3, 4), nrow = 2,
            ncol = 2, byrow = TRUE)
# vždy jeden z argumentů "nrow", či "ncol" je zbytný


## manipulace s maticemi ------------------------------------------------------

C <- matrix(letters[1:12], nrow = 3,
            byrow = T)
          
is.matrix(C)  # TRUE
class(C)      # "matrix"
mode(C)       # "character"; datový typ prvků
str(C)        # chr [1:3, 1:4] "a" "e" "i" ...
dim(C)        # c(3, 4); rozměry matice C

colnames(C) <- c("c1", "c2", "c3", "c4")
rownames(C) <- c("r1", "r2", "r3")
        # přidá jmenovky sloupcům i řádkům
C <- unname(C)
        # zbaví sloupce i řádky jmenovek
dimnames(C) <- list(
    c("r1", "r2", "r3"),
    c("c1", "c2", "c3", "c4")
)       # opět přidá jmenovky sloupcům i řádkům

rbind(C, c("x", "x", "x", "x"))
        # přidání řádku c("x", "x", "x", "x")
        # k matici C
cbind(C, c("x", "x", "x"))
        # přidání sloupce c("x", "x", "x")
        # k matici C
C[-1, ]   # odebrání 1. řádku matici C
C[, -2]   # odebrání 2. sloupce matici C


## submatice, indexování, adresace --------------------------------------------

C <- matrix(letters[1:12],
            nrow = 3,
            byrow = T,
            dimnames = list(
                c("r1", "r2", "r3"),
                c("c1", "c2", "c3", "c4")
            ))

C[2, 3]       # "g"; prvek 2. řádku, 3. sloupce
C["r2", "c3"] # "g"; prvek 2. řádku, 3. sloupce
C[1, ]        # c("a", "b", "c", "d");
              # tedy vektor 1. řádku matice C
              # s popisky

C[, 3]        # c("c", "g", "k");
              # tedy vektor 3. sloupce matice C
              # s popisky
C[c(1, 3), c(2, 4)]
              # matrix(c("b", "j", "d", "l"), 2)
              # submatice 1. a 3. řádku,
              # 2. a 4. sloupce matice C
              # s popisky
C["r2", ]     # c("e", "f", "g", "h");
              # tedy vektor 2. řádku matice C
              # s popisky

C[dim(C)[1], dim(C)[2]]
           # "l"; obecná adresace prvku
           # vpravo dole (např. neznáme-li
           # číselné rozměry matice)
C[5]       # "f"; major-column ordering
C[c(8, 9)] # c("g", "k")
C[13]      # NA
diag(C)    # c("a", "f", "k"); hlavní diagonála
diag(C[, dim(C)[2]:1])
           # c("d", "g", "j"); vedlejší diagonála


## pomocí R -------------------------------------------------------------------
## -- založme matici X
## -- najděme prvek třetího řádku druhého sloupce matice X
## -- jaký řádkový a sloupcový index mají prvky 0, 7 matice X$
## -- najděme minimum matice X a řádkový a sloupcový index této hodnoty
## -- najděme stopu matice X

X <- matrix(
    c(
        1, -5, -8,
        3, 0, 4,
        9, 1, 7,
        6, 2, 3
    ),
    nrow = 3
)


## ----------------------------------------------------------------------------

## <OPTIONAL>

## maticová algebra -----------------------------------------------------------

A <- matrix(c(1, 2, 3, 4), nrow = 2)
B <- matrix(c(5, 6, 7, 8), nrow = 2)
b <- c(1, 0)

A * B     # matrix(c(5, 12, 21, 32), 2)
A %*% B   # matrix(c(23, 34, 31, 46), 2)

t(A)      # matrix(c(1, 3, 2, 4), 2)

diag(2)   # matrix(c(1, 0, 0, 1), 2)

solve(A)  # matrix(c(-2, 1, 1.5, -0.5), 2)

eigen(A)$values

solve(A, b)        # c(-2, 1)

## </OPTIONAL>


## ----------------------------------------------------------------------------

## uvažujme markovský proces s počátečním stavovým vektorem

p <- c(1, 0, 0)

## a přechodovou maticí

S <- matrix(c(1/4, 1/2, 1/4,
              2/3, 0, 1/3,
              1/2, 1/2, 0), nrow = 3,
              byrow = TRUE)

## kde v i-tém řádku jsou vždy po řadě pravděpodobnosti přechodu
## z i-tého stavu do $j$-tého stavu pro všechna i, j \in {1, 2, 3}

## pomocí R
## -- ověřme, že matice S je stochastická
## -- určeme pravděpodobnosti, s jakými proces dospěl
## -- po pěti krocích do prvního, druhého či třetího stavu
## -- určeme, zda existuje dynamicky rovnovážný stav procesu


## ----------------------------------------------------------------------------

## tvorba polí a práce s nimi -------------------------------------------------

(X <- array(c(1:24), dim = c(4, 3, 2)))
# , , 1
#      [,1] [,2] [,3]
# [1,]    1    5    9
# [2,]    2    6   10
# [3,]    3    7   11
# [4,]    4    8   12
# , , 2
#     [,1] [,2] [,3]
# [1,]   13   17   21
# [2,]   14   18   22
# [3,]   15   19   23
# [4,]   16   20   24


## ----------------------------------------------------------------------------

## manipulace s poli ----------------------------------------------------------

X[, , 1]    # první vrstva
X[, , 2]    # druhá vrstva
X[3, , 1]   # třetí řádek první vrstvy
X[, 2, ]    # druhé sloupce všech vrstev


## tvorba datových tabulek a základní příkazy ---------------------------------

mtcars
str(mtcars)
class(mtcars)          # "data.frame"
mode(mtcars)           # "list"
is.data.frame(mtcars)  # TRUE      
str(iris)
  # 'data.frame': 150 obs. of 5 variables
  # ...
dim(iris)              # c(150, 5)


## manipulace s datovými tabulkami --------------------------------------------

data <- mtcars
colnames(data)
colnames(data) <- paste("c",
                      1:dim(data)[2],
                      sep = "_")
rownames(data) <- paste("r",
                      1:dim(data)[1],
                      sep = "_")
              # změní jmenovky sloupcům i řádkům
head(data)    # náhled na prvních 6 řádků
head(data, 10)
              # náhled na prvních 10 řádků
tail(data)    # náhled na posledních 6 řádků
tail(data, 10)
              # náhled na posledních 10 řádků

rbind(data, rep(0, dim(data)[2]))
              # přidání řádku c(0, 0, ..., 0)
              # k data.frameu "data"
cbind(data, rep(0, dim(data)[1]))
              # přidání sloupce c(0, 0, ..., 0)
              # k data.frameu "data"
data.frame(data,
           "ahoj" = rep(0, dim(data)[1]))
              # přidání sloupce c(0, 0, ..., 0)
              # se jménem "ahoj" k data.frameu
              # "data"
data[-1, ]    # odebrání 1. řádku data.frameu
              # "data"
data[, -1]    # odebrání 1. sloupce data.frameu
              # "data"


## indexování, adresace -------------------------------------------------------

data[2, 3]    # 160; prvek 2. řádku, 3. sloupce
data["r_2", "c_3"]
              # 160; prvek pod danými popisky
data[1, ]     # c(21, 6, 160, 110, ...);
              # tedy vektor 1. řádku data.frameu
              # "data" s popisky
data[, 2]     # c(6, 6, 4, 6, ...);
              # tedy vektor 2. sloupce
              # data.frameu "data" s popisky                    
data$c_5      # c(3.90, 3.90, 3.85, 3.08, ...);
              # tedy vektor 2. sloupce
              # data.frameu "data" s popisky
data$c_5[1]   # 3.9;
              # tedy první prvek 2. sloupce
              # data.frameu "data"

data[dim(data)[1], dim(data)[2]]
                 # 2; obecná adresace prvku
                 # vpravo dole (např. neznáme-li
                 # číselné rozměry tabulky)
      data[5]    # 5. sloupec, nikoliv major-column
                 # ordering


## sloupcové přehledy ---------------------------------------------------------

colSums(data)
         # součty všech sloupců
apply(data, 2, sum)
         # totéž
colMeans(data)
         # průměry všech sloupců
apply(data, 2, mean)
         # totéž
data <- rbind(data, rep(NA, dim(data)[2]))
         # přidán řádek c(NA, NA, ...)
colMeans(data)
         # c(NA, NA, ...); pro získání průměrů
         # nutné přidat argument na.rm = TRUE
colMeans(data, na.rm = TRUE)
apply(data, 2, mean, na.rm = TRUE)
         # už funguje


## ----------------------------------------------------------------------------

## tvorba seznamů a základní příkazy ------------------------------------------

my_list <- list("a" = c(1:10),
                "b" = mtcars,
                "c" = matrix(1:8, 2),
                "z" = "ahoj")
str(my_list)
class(my_list)         # "list"
mode(my_list)          # "list"
is.list(my_list)       # TRUE


## manipulace se seznamy ------------------------------------------------------

names(my_list)      
names(my_list) <- LETTERS[
    1:length(my_list)
]           # přejmenovávám prvky listu

my_list[[length(my_list) + 1]] <- c(T, F)
names(length(my_list)) <- "XY"
            # přidání vektoru c(T, F)
            # k listu "my\_list" pod jménem
            # "XY"


## indexování, adresace -------------------------------------------------------

my_list[[2]]  # 2. prvek listu
my_list[["B"]]
              # prvek listu pod jmenovkou "B"
              # jde o původní datový typ
              # (data.frame)
my_list["B"]  # prvek listu pod jmenovkou "B"
              # jde (vždy) o list
my_list[c(2, 4)]
              # 2. a 4. prvek listu
my_list$C     # prvek listu pod jmenovkou "C"
my_list[[1]][2]
              # 2; 2. prvek 1. prvku listu
my_list[[2]][3, 5]
              # 3.85; z 2. prvku listu vybírám
              # prvek o souřadnicích (3, 5)


set.seed(1)
my_long_list <- lapply(
    sample(c(80:120), 100, TRUE),
    function(x) sample(
        c(50:150),
        x,
        replace = TRUE
    )
)   # list vektorů náhodné délky
    # generovaných z náhodných čísel

lapply(my_long_list, "[[", 14)
    # z každého prvku listu (vektoru)
    # vybírám jen jeho 14. prvek


## prvkové přehledy -----------------------------------------------------------

lapply(my_long_list, mean)
    # pro každý prvek listu (vektor)
    # vracím jeho průměr
  
lapply(my_long_list, length)
    # pro každý prvek listu (vektor)
    # vracím jeho délku


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





