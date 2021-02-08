
compile_Win <- function(file, cppDir = getwd(), xF = "", ...) {

    # Create a local 'Makevars' file without the all warnings, '-Wall', flag. Add extra flags with the 'xF' argument.
	cwd <- setwd(cppDir)
    on.exit(setwd(cwd))
    V <- sub(paste0('.', tools::file_ext(file)), "", file)
    Ri <- paste0(R.home(), '/include')
    Ti <- system.file("include", package = "TMB")
    Arch <- paste0(R.home(), '/bin', Sys.getenv("R_ARCH"))
         
    sink('Makevars')
       cat(paste0('\n\n', V, '.o: ', V, '.cpp\n'))
       cat(paste0('\tC:/rtools40/mingw64/bin/g++ -std=gnu++11 -I"', Ri, '" -DNDEBUG -I"', Ti, '" -DTMB_SAFEBOUNDS -DLIB_UNLOAD=R_unload_', V, 
                  ' -DTMB_LIB_INIT=R_init_', V, ' -O2 -mfpmath=sse -msse2 -mstackrealign -c ', xF, ' ', V, '.cpp -o ', V, '.o\n'))
       cat(paste0('\tC:/rtools40/mingw64/bin/g++ -std=gnu++11 -shared -s -static-libgcc -o ', V, '.dll ',  V, '.o -L', Arch,' -lR\n')) 
    sink()
    
    compile(file = file, ...)
}
