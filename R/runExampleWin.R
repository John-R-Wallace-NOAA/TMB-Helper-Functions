

runExampleWin <- function(name = NULL, xF = "", clean = FALSE, cleanBefore = clean, cleanAfter = clean, exfolder = NULL, subarch = TRUE, ...) {

    if(is.null(exfolder)) 
        exfolder <- system.file("examples", package = "TMB")
    cwd <- setwd(exfolder)
    on.exit(setwd(cwd))
    
    arch <- .Platform$r_arch
    if (nzchar(arch) && subarch) {
        if (!file.exists(arch)) {
            dir.create(arch)
            file.copy(dir(pattern = "*.[cpp|R]"), arch)
        }
        setwd(arch)
    }
    
    V <- name
    
    if(subarch) 
       archPath <- paste0(exfolder, Sys.getenv("R_ARCH"), "/")
    else 
       archPath <- paste0(exfolder, "/")
     
    if(cleanBefore) {
       if(file.exists(paste0(archPath, V, '.o')))
          file.remove(paste0(archPath, V, '.o'))
       if(!is.null(unclass(getLoadedDLLs()[[V]])$path) && dynlib(paste0(archPath, V)) == unclass(getLoadedDLLs()[[V]])$path) 
          dyn.unload(dynlib(paste0(archPath, V)))
       if(file.exists(dynlib(paste0(archPath, V))))   
          file.remove(dynlib(paste0(archPath, V)))  
    }
    
    if(cleanAfter) {
       on.exit(file.remove(paste0(archPath, V, '.o')), add = TRUE)
       on.exit(dyn.unload(dynlib(paste0(archPath, V))), add = TRUE)
       on.exit(file.remove(dynlib(paste0(archPath, V))), add = TRUE)
       on.exit(file.remove(paste0(archPath, 'Makevars')), add = TRUE)
    }

    # Create a local 'Makevars' file without the all warnings, '-Wall', flag. Add extra flags with the 'xF' argument.
    Ri <- paste0(R.home(), '/include')
    Ti <- system.file("include", package = "TMB")
    Arch <- paste0(R.home(), '/bin', Sys.getenv("R_ARCH"))
         
    sink('Makevars')
       cat(paste0('\n\n', V, '.o: ', V, '.cpp\n'))
       cat(paste0('\tC:/rtools40/mingw64/bin/g++ -std=gnu++11 -I"', Ri, '" -DNDEBUG -I"', Ti, '" -DTMB_SAFEBOUNDS -DLIB_UNLOAD=R_unload_', V, 
                  ' -DTMB_LIB_INIT=R_init_', V, ' -O2 -mfpmath=sse -msse2 -mstackrealign -c ', xF, ' ', V, '.cpp -o ', V, '.o\n'))
       cat(paste0('\tC:/rtools40/mingw64/bin/g++ -std=gnu++11 -shared -s -static-libgcc -o ', V, '.dll ',  V, '.o -L', Arch,' -lR\n')) 
    sink()
    
    runExample(name = name, clean = FALSE, exfolder = exfolder, subarch = subarch, ...)
}

