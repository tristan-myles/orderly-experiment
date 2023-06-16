library(orderly)

dirname <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(dirname)

orderly_root_path <- paste(dirname, "/experiment-1", sep="")

# creates a skeleton structure with READMEs explaining what the purpose of each folder
# these folders will get created as you use orderly so not really necessary to run this...
orderly_init(root=orderly_root_path)

# root must be orderly root
# first param is directory name which has the report (with an oderly.yml)
# root is the *orderly* root dir; i.e. the dir with the orderly_config.yml
id <- orderly::orderly_run("report_1", root=orderly_root_path)

# You can commit a specific run using it's ID
orderly_commit(id, root = orderly_root_path)

# use this to create a gitignore
# you only need to commit your src/ files and your report
orderly_use_gitignore(root=orderly_root_path)

# running a second report
id <- orderly::orderly_run("report_2", root=orderly_root_path)

# developing a second report which depends on the input of the first task
orderly::orderly_develop_start("report_2", root=orderly_root_path)
orderly::orderly_develop_status("report_2", root=orderly_root_path)

orderly::orderly_develop_clean("report_2", root=orderly_root_path)
orderly::orderly_develop_status("report_2", root=orderly_root_path)

