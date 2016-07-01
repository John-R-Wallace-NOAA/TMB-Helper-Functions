# TMB-Helper-Functions

# pickTMBdll()
Use pickTMBdll() to find and select the needed loaded TMB DLL's:

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
    
    obj <- TMB::MakeADFun(data, parameters, DLL = pickTMBdll(2))
    
    dyn.unload( pickTMBDLL(1) )
    # ...
    
    
    pickTMBDLL(1)

    All TMB DLL's:

    $linreg_Gamma_errors_parallel
    DLL name: linreg_Gamma_errors_parallel
    Filename: W:/ALL_USR/JRW/R.Not so Clean.64/linreg_Gamma_errors_parallel.dll
    Dynamic lookup: TRUE


    DLL selected: W:/ALL_USR/JRW/R.Not so Clean.64/linreg_Gamma_errors_parallel.dll 
