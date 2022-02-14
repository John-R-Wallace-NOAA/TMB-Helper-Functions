# TMB-Helper-Functions

## Compile() - a wrapper for compile()


    library(TMB) 
    # source() in R/Compile.R from this repo
        
     # TMB's compile() gives excess warnings when TMB/include/Eigen doesn't exist as is the case when TMB is downloaded from CRAN.
    # Note: file.remove() can take multiple file names, but there is no way to suppress the warning of a missing file not deleted [only file.create() has a argument to suppress warnings].
    if(file.exists('linreg_parallel.dll')) file.remove('linreg_parallel.dll'); if(file.exists('linreg_parallel.o')) file.remove('linreg_parallel.o')  
    TMB::compile('linreg_parallel.cpp')
    
    # New Compile wrapper removes the excess warnings
    if(file.exists('linreg_parallel.dll')) file.remove('linreg_parallel.dll'); if(file.exists('linreg_parallel.o')) file.remove('linreg_parallel.o')  
    Compile('linreg_parallel.cpp')
    
    # Using verbose = TRUE shows the details of what is happening
    if(file.exists('linreg_parallel.dll')) file.remove('linreg_parallel.dll'); if(file.exists('linreg_parallel.o')) file.remove('linreg_parallel.o')  
    Compile('linreg_parallel.cpp', verbose = TRUE)
             
    # Here the debug level is changed from O2 to O1 with the help of the 'del_Makeconf_flags' argument that deletes flag(s) from Makeconf CXXFLAGS
    if(file.exists('linreg_parallel.dll')) file.remove('linreg_parallel.dll'); if(file.exists('linreg_parallel.o')) file.remove('linreg_parallel.o')  
    Compile('linreg_parallel.cpp', flags = "-O1", del_Makeconf_flags = "-O2", verbose = TRUE) 
        
    # This call is less parsimonious than above, but the debug level is still changed from O2 to O1 since the right most "-O1" flag will override '-O2' that remains from CXXFLAGS.
    if(file.exists('linreg_parallel.dll')) file.remove('linreg_parallel.dll'); if(file.exists('linreg_parallel.o')) file.remove('linreg_parallel.o')  
    Compile('linreg_parallel.cpp', flags = '-O1', verbose = TRUE)
    
    # Use of character vector with individual elements (not one long string) is needed in 'del_Makeconf_flags' and can also be used in 'flags' argument for consistence.                   
    # Here the "-Wignored-attributes" is used to again see the excess warnings.
    # Break out of the excess warnings quickly (Esc in Windows) to see the details from verbose = TRUE.
    if(file.exists('linreg_parallel.dll')) file.remove('linreg_parallel.dll'); if(file.exists('linreg_parallel.o')) file.remove('linreg_parallel.o')  
    Compile('linreg_parallel.cpp', flags = c("-Wignored-attributes", "-O1"), del_Makeconf_flags = c("-Wall", "-O2"), verbose = TRUE) 


---
---

# Old functions below - may be deleted in the future

## runExampleWin()



    runExampleWin('simple', clean = TRUE)
    
    runExampleWin('simple', clean = TRUE, xF = '-Wno-aggressive-loop-optimizations')
    
    getLoadedDLLs()[['simple']]
    
    runExampleWin('simple', cleanBefore = TRUE, xF = '-Wno-aggressive-loop-optimizations')
    
    getLoadedDLLs()[['simple']]
    

    dir.create("c:/temp_TMB", showWarnings = FALSE)
    exTMB <- system.file("examples", package = "TMB")
    file.copy(paste0(exTMB, "/",  dir(exTMB, pattern = "ar1xar1.[cpp|R]")), "c:/temp_TMB")
    
    runExampleWin('ar1xar1', clean = TRUE, exfolder = "c:/temp_TMB")







## pickTMBdll()
Use pickTMBdll() to find and select the loaded TMB DLL's to use or delete:

    > pickTMBDLL(1)

    All TMB DLL's:

    $glmmTMB
    DLL name: glmmTMB
    Filename: W:/MRO/R-3.2.5/library/glmmTMB/libs/x64/glmmTMB.dll
    Dynamic lookup: TRUE

    $linreg_Gamma_errors_parallel
    DLL name: linreg_Gamma_errors_parallel
    Filename: W:/ALL_USR/JRW/R.Not so Clean.64/linreg_Gamma_errors_parallel.dll
    Dynamic lookup: TRUE


    DLL selected: W:/MRO/R-3.2.5/library/glmmTMB/libs/x64/glmmTMB.dll 
    
    
    > obj <- TMB::MakeADFun(data, parameters, DLL = pickTMBdll(2)) # Use linreg_Gamma_errors_parallel
    
    > dyn.unload( pickTMBDLL(1) ) # Remove glmmTMB
    # ...
    
    
    > pickTMBDLL() # glmmTMB gone

    All TMB DLL's:

    $linreg_Gamma_errors_parallel
    DLL name: linreg_Gamma_errors_parallel
    Filename: W:/ALL_USR/JRW/R.Not so Clean.64/linreg_Gamma_errors_parallel.dll
    Dynamic lookup: TRUE


    DLL selected: W:/ALL_USR/JRW/R.Not so Clean.64/linreg_Gamma_errors_parallel.dll 
