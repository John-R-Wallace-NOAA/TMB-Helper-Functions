
Compile <- function(file, flags = "", ..., del_Makeconf_flags = "", verbose = FALSE) { 
 
    Makeconf_file <- paste0(R.home("etc"), Sys.getenv("R_ARCH"), "/Makeconf")
    if(verbose) cat("\nGlobal Makeconf file being used:",  Makeconf_file, "\n")
    if(file.exists(Makeconf_file)) {
        Makeconf <- scan(Makeconf_file, what = "", sep = "\n", quiet = TRUE)
        Makeconf_args_global <- sub(" \\$\\(LTO\\)", "", sub(" \\$\\(DEBUGFLAG\\) ", " ", sub("CXXFLAGS = ", "", Makeconf[grep("^CXXFLAGS", Makeconf)])))
        if(verbose) cat("\nCXXFLAGS retreived:", Makeconf_args_global, "\n")
        if(length(del_Makeconf_flags) > 1 || del_Makeconf_flags != "") {
           for(i in del_Makeconf_flags)
              Makeconf_args_global <- sub(i, "", Makeconf_args_global)
        }
     } else
        Makeconf_args_global <- character(0)
     flags <- paste(Makeconf_args_global, "-Wno-ignored-attributes", paste(flags[flags!=""], collapse = " ")) ## Now flags overrides only the Makeconf cxxflags that are the same. [Need paste here, not 'c()'.]
     if(verbose) cat("\nRemaining CXXFLAGS plus flags added:", flags, "\n\n")
     TMB::compile(file = file, flags = flags, ...) 
}               
