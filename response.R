# load all responses into a data.frame

  #-----------------------------
  
  # Create function to bind all responses

    loadData <- function() {
      files <- list.files(file.path(responsesDir), full.names = TRUE)
      data <- lapply(files, read.csv, stringsAsFactors = FALSE)
      data <- do.call(rbind, data)
      data
    }

  #---------------------------
    
  # Run function (this is just to show that it works, the final version should write to some location)
  
    loadData()
