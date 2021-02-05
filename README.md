# TMB-Helper-Functions

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
