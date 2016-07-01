
pickTMBDLL <- function(n = 1) {

   dlls <- getLoadedDLLs()
   isTMBdll <- function(dll) !is(try(getNativeSymbolInfo("MakeADFunObject", 
        dll), TRUE), "try-error")
   TMBdll <- sapply(dlls, isTMBdll)

   cat("\nAll TMB DLL's:\n\n")
   print(dlls[TMBdll])

   cat("\nDLL selected:", dlls[TMBdll][[n]][[2]], "\n\n")

   invisible(dlls[TMBdll][[n]][[2]])
}

