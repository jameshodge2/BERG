\name{contents}
\alias{contents}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Creates and prints PROC CONTENTS style output
}
\description{
The contents() function creates two tables similar to those that are generated by SAS PROC CONTENTS: 1) Summary table with number of observations, rows, and file size; 2) A list of all variables (alphabetically or by variable number) with the option to write them to an excel sheet or an RTF file.
}
\usage{
contents(data, varnum = T, write = NULL, outfile = NULL, filename = NULL)
}
\arguments{
  \item{data}{
     dataframe used in the analysis
  }
  \item{varnum}{
     boolean input controlling order or variable list - set to false for alphabetical variable list.
  }
  \item{write}{
     OPTIONAL - character string either "word" or "excel" - controls whether to write to file and which file type.
  }
  \item{outfile}{
     File path for output file folder. Required if write argument is specified.
  }
  \item{filename}{
     File name for output file - DO NOT include file type extension. Required if write argument is specified.
  }
}
\details{
Generates two tables akin to output from SAS Proc Contents - 1 with summary information (i.e. name of dataframe, number of observations, and number of variables) and a second with a list of variables. Includes option to order the variable table alphabetically or by variable number (default, equivalent to the index value). Includes additional option to output to a word doc or excel file allowing the user to specify a file path. In the current iteration, the file path and file name must be specified separately in the outfile and filename arguments.

Dependent packages: dplyr, xlsx, officer
}
\value{
The function returns a 2 level list with the following tables:
     \item{metadata}{
          4 line table with dataframe name, number of observations, number of variables and object size (in bytes)
     }
     \item{var_table}{
          Table showing all variables in dataframe along with factor levels, and labels (if pulled in from SAS)
     }
}

\author{
James Hodge
}


\examples{
#-------------- Examples using base data set mtcars

# Default usage will sort variables by index number
test1 <- contents(data = mtcars)
test1$metadata
test1$var_table

# Changing the varnum option will order variables alphabetically
test2 <- contents(data = mtcars, varnum = F)
test2$metadata
test2$var_table
}

