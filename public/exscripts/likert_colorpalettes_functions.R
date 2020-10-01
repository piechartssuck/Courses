# Run this ----
unihtmlcolors <- function(count_of_unicolors) {
  
            count_of_unicolors <- length(unichoices)
            
            unipolar <- colorRampPalette(c("#b2d8d8", unicolor))(count_of_unicolors)
            
            show_col(unipolar)
            
            unihtml1 <- '<span style="font-size:16px;">'
            unihtml2 <- paste('<span style="color:', unipolar, ';">')
            unihtml3 <- unichoices
            unihtml4 <- "</span>"
            unihtml5 <- "</span>"
            
            html_colors <- tibble(unihtml1, unihtml2, unihtml3, unihtml4, unihtml5) %>%
              apply(1, paste, collapse = '\n') %>%
              as_tibble() %>%
              rowid_to_column("id") %>%
              group_by(id) %>% 
              do(rbind(.,c(.$id,rep(NA,NCOL(df)-1)))) %>%
              ungroup() %>% 
              data.frame() %>%
              select(-id) %>%
              as_tibble() %>% 
              mutate(across(everything(), ~replace_na(.x, "")))
            
            write.table(html_colors, 
                        file = "unihtmlcolors.txt",
                        col.names=FALSE, 
                        quote=FALSE, 
                        row.names=FALSE)
      }


# ... and this. ----
bihtmlcolors <- function(count_of_bicolors) {
  
  count_of_bicolors <- length(bichoices)
  
  bipolar <- colorRampPalette(c(bicolor_low, bicolor_high))(count_of_bicolors)
  
  show_col(bipolar)
  
  bihtml1 <- '<span style="font-size:16px;">'
  bihtml2 <- paste('<span style="color:', bipolar, ';">')
  bihtml3 <- bichoices
  bihtml4 <- "</span>"
  bihtml5 <- "</span>"
  
  html_colors <- tibble(bihtml1, bihtml2, bihtml3, bihtml4, bihtml5) %>%
    apply(1, paste, collapse = '\n') %>%
    as_tibble() %>%
    rowid_to_column("id") %>%
    group_by(id) %>% 
    do(rbind(.,c(.$id,rep(NA,NCOL(df)-1)))) %>%
    ungroup() %>% 
    data.frame() %>%
    select(-id) %>%
    as_tibble() %>% 
    mutate(across(everything(), ~replace_na(.x, "")))
  
  write.table(html_colors, 
              file = "bihtmlcolors.txt",
              col.names=FALSE, 
              quote=FALSE, 
              row.names=FALSE)
}
