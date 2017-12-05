
cleanColumnNames <- function(x) {
  gsub(" ", "_", x, fixed = TRUE)       %>%
    gsub("%", "pct", x = ., fixed = TRUE) %>%
    gsub("#", "num", x = ., fixed = TRUE) %>%
    gsub("(", "_", x = ., fixed = TRUE) %>%
    gsub(")", "_", x = ., fixed = TRUE) %>%
    gsub("/", "_", x = ., fixed = TRUE) %>%
    gsub("(\\d+)", "x.\\1", x = .)
}