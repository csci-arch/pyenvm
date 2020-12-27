# CONFIGS
VERBOSE=1
CLEAR_FULL=0
CONDA_PATH=""
# FLAGS
WARNING_FLAG=0
# CONSTANTS

WORKSPACE_PATH=~/.pyenvm/
CONF_FILE=~/.pyenvm/pyenvm.conf
RED='\033[1;31m'
BLUE='\033[1;94m'
GREEN='\033[1;32m'
YELLOW='\033[1;93m'
NC='\033[0m'


greetings()
{
  clear
  echo -e "${BLUE}Welcome to Python Environment Manager a0.0.0"
  echo "Please enter \"help\" to see possible commands"
  echo -e "${NC}\n"
}

save_config()
{
  echo -e "CONDA_PATH ${CONDA_PATH}\nVERBOSE ${VERBOSE}\nCLEAR_FULL ${CLEAR_FULL}" > $CONF_FILE
}

print_config()
{
  echo -e "CONDA_PATH\tequals to\t${CONDA_PATH}\nVERBOSE\t\tequals to\t${VERBOSE}\nCLEAR_FULL\tequals to\t${CLEAR_FULL}"
}

clear
echo -e "${BLUE}Welcome to Python Environment Manager v1.0.0"
echo "Please enter \"help\" to see possible commands"

if [ -f "$CONF_FILE" ]; then
    FAILED_VARS=("CONDA_PATH" "VERBOSE" "CLEAR_FULL")
    LEN_FAILED_VARS=${#FAILED_VARS[@]}
    OBL_VARS=("CONDA_PATH") # Can't work without these
    echo -e "${GREEN}Config file found in $CONF_FILE"
    while read line; do
      elements=()
      for element in $line
      do
        elements+=($element)
      done
      case ${elements[0]} in
      CONDA_PATH)
        CONDA_PATH=${elements[1]}
        FAILED_VARS=( "${FAILED_VARS[@]/${elements[0]}/}" )
        LEN_FAILED_VARS=$LEN_FAILED_VARS-1
        ;;
      VERBOSE)
        VERBOSE=${elements[1]}
        FAILED_VARS=( "${FAILED_VARS[@]/${elements[0]}/}" )
        LEN_FAILED_VARS=$LEN_FAILED_VARS-1
        ;;
      CLEAR_FULL)
        CLEAR_FULL=${elements[1]}
        FAILED_VARS=( "${FAILED_VARS[@]/${elements[0]}/}" )
        LEN_FAILED_VARS=$LEN_FAILED_VARS-1
        ;;
      esac
    done < $CONF_FILE
    echo -e "${GREEN}Configurations loaded successfuly"
    for var in ${FAILED_VARS[@]}
    do
      if [[ "${OBL_VARS[*]}" =~ "$var" ]]
      then
        echo -e "${RED}ERROR: $var couldn't found in config file"
        echo -e "${RED}Aborting..."
        return 0
      fi
    done
    if [[ $LEN_FAILED_VARS -gt 0 ]] && [[ $VERBOSE -eq 1 ]]
    then
      echo -e "${YELLOW}WARNING: ${FAILED_VARS[@]} couldn't found and default values will be used for these variables"
      WARNING_FLAG=1
    fi
else
    echo -e "${RED}ERROR: Config file couldn't found in $CONF_FILE"
    echo -e "${RED}Aborting..."
    return 0
fi

if [[ $VERBOSE -eq 1 ]] && [[ $WARNING_FLAG -eq 1 ]]
then
  echo -e "${YELLOW}Please set VERBOSE to 0 to supress warnings${NC}"
fi

echo -e "${NC}"

while :
do
  read -p "(${CONDA_DEFAULT_ENV}) ?> " prompt
  PROMPTARR=()
  for element in $prompt
  do
    PROMPTARR+=($element)
  done

  case $prompt in # Parameterless commands
    help)
        echo -e "help\t\t\t\t\t\t\t\t Displays this help text"
        echo -e "document\t\t\t\t\t\t\t Displays every possible help text"
        echo -e "list\t\t\t\t\t\t\t\t Lists conda environments installed on your system"
        echo -e "new\t\t\t\t\t\t\t\t Creates a new conda environments"
        echo -e "clone\t\t\t\t\t\t\t\t Creates a copy of an existing conda environment"
        echo -e "del\t\t\t\t\t\t\t\t Deletes a specific conda environment"
        echo -e "activate\t\t\t\t\t\t\t Activates the specified conda environment"
        echo -e "update\t\t\t\t\t\t\t\t Updates a conda environment by other environments or requirement files"
        echo -e "export\t\t\t\t\t\t\t\t Exports requirement file from a conda environment"
        echo -e "check\t\t\t\t\t\t\t\t Prints libraries installed in specified environment"
        echo -e "pip\t\t\t\t\t\t\t\t Executes pip commands using active conda environment"
        echo -e "get\t\t\t\t\t\t\t\t Displays specified configurations"
        echo -e "set\t\t\t\t\t\t\t\t Sets configurations of environment manager"
        echo -e "exit\t\t\t\t\t\t\t\t Exits from the manager"
        echo -e "clear\t\t\t\t\t\t\t\t Clears the screen"
        echo -e ""
        continue
        ;;
    document)
    echo -e "help\t\t\t\t\t\t\t\t Displays this help text"
    echo -e "document\t\t\t\t\t\t\t Displays every possible help text"
    echo -e "list\t\t\t\t\t\t\t\t Lists conda environments installed on your system"
    echo -e "new\t\t\t\t\t\t\t\t Creates a new conda environments"
    echo -e "clone\t\t\t\t\t\t\t\t Creates a copy of an existing conda environment"
    echo -e "del\t\t\t\t\t\t\t\t Deletes a specific conda environment"
    echo -e "activate\t\t\t\t\t\t\t Activates the specified conda environment"
    echo -e "update\t\t\t\t\t\t\t\t Updates a conda environment by other environments or requirement files"
    echo -e "export\t\t\t\t\t\t\t\t Exports requirement file from a conda environment"
    echo -e "check\t\t\t\t\t\t\t\t Prints libraries installed in specified environment"
    echo -e "pip\t\t\t\t\t\t\t\t Executes pip commands using active conda environment"
    echo -e "get\t\t\t\t\t\t\t\t Displays specified configurations"
    echo -e "set\t\t\t\t\t\t\t\t Sets configurations of environment manager"
    echo -e "exit\t\t\t\t\t\t\t\t Exits from the manager"
    echo -e "clear\t\t\t\t\t\t\t\t Clears the screen"
    echo -e "\n${RED}######################################################################################### NEW ####################################################################################${NC}"
    echo -e "new help\t\t\t\t\t\t\t Displays this help text"
    echo -e "new <env_name>\t\t\t\t\t\t\t Creates a new conda environment named <env_name>"
    echo -e "new <env_name> <req_name>\t\t\t\t\t Creates a new conda environment named <env_name> and installs libraries from requirements folder named <req_name>"
    echo -e "\n${RED}######################################################################################### CLONE ##################################################################################${NC}"
    echo -e "clone help\t\t\t\t\t Displays this help text"
    echo -e "clone <env_name> from <target_env_name>\t\t Creates a clone of <target_env_name> named <env_name>"
    echo -e "\n${RED}########################################################################################## DEL ###################################################################################${NC}"
    echo -e "del help\t\t\t\t\t\t\t Displays this help text"
    echo -e "del <env_name>\t\t\t\t\t\t\t Deletes the conda environment named <env_name>"
    echo -e "\n${RED}######################################################################################## ACTIVATE ################################################################################${NC}"
    echo -e "activate help\t\t\t\t\t\t\t Displays this help text"
    echo -e "activate <env_name>\t\t\t\t\t\t Activates the conda environment named <env_name>"
    echo -e "\n${RED}########################################################################################## SET ###################################################################################${NC}"
    echo -e "set help\t\t\t\t\t\t\t Displays this help text"
    echo -e "set <var_name> <var_val>\t\t\t\t\t Sets <var_name> to <var_val> and saves it to config file"
    echo -e "Possible Configs are:"
    echo -e " CONDA_PATH\t\t\t\t\t\t\t The most outer path of the conda"
    echo -e " VERBOSE\t\t\t\t\t\t\t Controls whether warnings will be printed or not, takes 1 or 0 as value"
    echo -e " CLEAR_FULL\t\t\t\t\t\t\t Controls whether clear command will clear everything or not, takes 1 or 0 as value"
    echo -e "\n${RED}########################################################################################## GET ###################################################################################${NC}"
    echo -e "get help\t\t\t\t\t\t\t Displays this help text"
    echo -e "get <var_name>\t\t\t\t\t\t\t Prints value of the entered configuration variable"
    echo -e "get all\t\t\t\t\t\t\t\t Prints values of the all configuration variables"
    echo -e "\n${RED}########################################################################################## PIP ###################################################################################${NC}"
    echo -e "${YELLOW}This command overwrites pips' original help section and if you want to get there please enter \"pip -h\" or \"pip --help\"${NC}"
    echo -e "pip help\t\t\t\t\t\t\t Displays this help text"
    echo -e "pip <command>\t\t\t\t\t\t\t Executes the command with pip of active environment"
    echo -e "\n${RED}######################################################################################### UPDATE #################################################################################${NC}"
    echo -e "update help\t\t\t\t\t\t\t Displays this help text"
    echo -e "update <env_name> [--file --env] [--pip --conda] <target>\t Updates pip or conda of specified environment using another environment or requirements file "
    echo -e "\n${RED}######################################################################################### EXPORT #################################################################################${NC}"
    echo -e "export help\t\t\t\t\t\t\t Displays this help text"
    echo -e "export <env_name> [--conda --pip] <file_path>\t\t\t Exports requirements of pip or conda environment of given conda environment"
    echo -e "\n${RED}######################################################################################### CHECK ##################################################################################${NC}"
    echo -e "check help\t\t\t\t\t\t\t Displays this help text"
    echo -e "check <env_name> [--conda --pip]\t\t\t\t Displays installed libraries of pip or conda environment of given conda environment"
    echo -e ""
        continue
        ;;
    list)
        conda env list
        echo -e ""
        continue
        ;;
    exit)
        break;;
    clear)
      if [[ $CLEAR_FULL -eq 0 ]]
      then
        greetings
      else
        clear
      fi
      continue
      ;;
  esac

  if [[ "${#PROMPTARR[@]}" -eq 1 ]] && [[ "${PROMPTARR[0]}" != "pip" ]]
  then
    echo -e "Invalid command entered: ${PROMPTARR[0]} command needs parameters to operate\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
    echo -e ""
  else
    case "${PROMPTARR[0]}" in #Commands with param
      new )
          if [[ "${#PROMPTARR[@]}" -eq 2 ]]
          then
            case "${PROMPTARR[1]}" in
              help )
                echo -e "new help\t\t\t\t\t\t\t Displays this help text"
                echo -e "new <env_name>\t\t\t\t\t\t\t Creates a new conda environment named <env_name>"
                echo -e "new <env_name> <req_name>\t\t\t\t\t Creates a new conda environment named <env_name> and installs libraries from requirements folder named <req_name>"
                echo -e ""
                ;;
              * )
                conda create --name "${PROMPTARR[1]}"
            esac
          elif [[ "${#PROMPTARR[@]}" -eq 3 ]]
          then
            conda create --name "${PROMPTARR[1]}" --file "${PROMPTARR[2]}"
          else
            echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            echo -e ""
          fi
          ;;
      clone )
          if [[ "${#PROMPTARR[@]}" -eq 2 ]]
          then
            case "${PROMPTARR[1]}" in
              help )
                echo -e "clone help\t\t\t\t\t Displays this help text"
                echo -e "clone <env_name> from <target_env_name>\t\t Creates a clone of <target_env_name> named <env_name>"
                echo -e ""
                ;;
              * )
              echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
              echo -e ""
            esac
          elif [[ "${#PROMPTARR[@]}" -eq 4 ]]
          then
            conda create --name "${PROMPTARR[1]}" --clone "${PROMPTARR[3]}"
          else
            echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            echo -e ""
          fi
          ;;
      del )
          if [[ "${#PROMPTARR[@]}" -eq 2 ]]
          then
            case "${PROMPTARR[1]}" in
              help )
                echo -e "del help\t\t\t\t\t\t\t Displays this help text"
                echo -e "del <env_name>\t\t\t\t\t\t\t Deletes the conda environment named <env_name>"
                echo -e ""
                ;;
              * )
                conda activate "${PROMPTARR[1]}"
                conda deactivate
                conda remove --name "${PROMPTARR[1]}" --all
                ;;
            esac
          else
            echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            echo -e ""
          fi
          ;;
      activate )
          if [[ "${#PROMPTARR[@]}" -eq 2 ]]
          then
            case "${PROMPTARR[1]}" in
              help )
                echo -e "activate help\t\t\t\t\t\t\t Displays this help text"
                echo -e "activate <env_name>\t\t\t\t\t\t Activates the conda environment named <env_name>"
                echo -e ""
                ;;
              * )
                conda activate "${PROMPTARR[1]}"
                ;;
            esac
          else
            echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            echo -e ""
          fi
          ;;
      set )
          if [[ "${#PROMPTARR[@]}" -eq 2 ]]
          then
            case "${PROMPTARR[1]}" in
              help )
                echo -e "set help\t\t\t\t\t\t\t Displays this help text"
                echo -e "set <var_name> <var_val>\t\t\t\t\t Sets <var_name> to <var_val> and saves it to config file"
                echo -e "Possible Configs are:"
                echo -e " CONDA_PATH\t\t\t\t\t\t\t The most outer path of the conda"
                echo -e " VERBOSE\t\t\t\t\t\t\t Controls whether warnings will be printed or not, takes 1 or 0 as value"
                echo -e " CLEAR_FULL\t\t\t\t\t\t\t Controls whether clear command will clear everything or not, takes 1 or 0 as value"
                echo -e ""
                ;;
              * )
              echo -e "Bad syntax: ${PROMPTARR[@]} isn't a valid command\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            esac
          elif [[ "${#PROMPTARR[@]}" -eq 3 ]]
          then
            case "${PROMPTARR[1]}" in
              VERBOSE )
                VERBOSE=${PROMPTARR[2]}
                save_config
                echo "Current configurations are as follows:"
                print_config
                ;;
              CONDA_PATH )
                CONDA_PATH=${PROMPTARR[2]}
                save_config
                echo "Current configurations are as follows:"
                print_config
                ;;
              CLEAR_FULL )
                CLEAR_FULL=${PROMPTARR[2]}
                save_config
                echo "Current configurations are as follows:"
                print_config
                ;;
              * )
                echo -e "Bad syntax: ${PROMPTARR[1]} isn't a valid config variable\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            esac
          else
            echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            echo -e ""
          fi
          ;;
      get )
          if [[ "${#PROMPTARR[@]}" -eq 2 ]]
          then
            case "${PROMPTARR[1]}" in
              help )
                echo -e "get help\t\t\t\t\t\t\t Displays this help text"
                echo -e "get <var_name>\t\t\t\t\t\t\t Prints value of the entered configuration variable"
                echo -e "get all\t\t\t\t\t\t\t\t Prints values of the all configuration variables"
                echo -e ""
                ;;
              VERBOSE )
                echo "VERBOSE equals to ${VERBOSE}"
                ;;
              CONDA_PATH )
                echo "CONDA_PATH equals to ${CONDA_PATH}"
                ;;
              CLEAR_FULL )
                echo "CLEAR_FULL equals to ${CLEAR_FULL}"
                ;;
              all )
                echo "Current configurations are as follows:"
                print_config
                ;;
              * )
                echo -e "Bad syntax: ${PROMPTARR[@]} isn't a valid command\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
                ;;
            esac
          else
            echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            echo -e ""
          fi
          ;;
      pip )
          case "${PROMPTARR[1]}" in
            help )
              echo -e "${YELLOW}This command overwrites pips' original help section and if you want to get there please enter \"pip -h\" or \"pip --help\"${NC}"
              echo -e "pip help\t\t\t\t\t\t\t Displays this help text"
              echo -e "pip <command>\t\t\t\t\t\t\t Executes the command with pip of active environment"
              echo -e ""
              ;;
            * )
              ${CONDA_PATH}/envs/${CONDA_DEFAULT_ENV}/bin/pip ${PROMPTARR[@]:1:${#PROMPTARR}}
              ;;
          esac
          ;;
      update )
          if [[ "${#PROMPTARR[@]}" -eq 2 ]]
          then
            case "${PROMPTARR[1]}" in
              help )
                echo -e "update help\t\t\t\t\t\t\t Displays this help text"
                echo -e "update <env_name> [--file --env] [--pip --conda] <target>\t Updates pip or conda of specified environment using another environment or requirements file "
                echo -e ""
                ;;
              * )
              echo -e "Bad syntax: ${PROMPTARR[@]} isn't a valid command\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            esac
          elif [[ "${#PROMPTARR[@]}" -eq 5 ]]
          then
            case "${PROMPTARR[2]}" in
              --env )
                case "${PROMPTARR[3]}" in
                  --pip )
                    ${CONDA_PATH}/envs/"${PROMPTARR[4]}"/bin/pip freeze > "${WORKSPACE_PATH}requirements.txt"
                    ${CONDA_PATH}/envs/"${PROMPTARR[1]}"/bin/pip install -r "${WORKSPACE_PATH}requirements.txt"
                    trash "${WORKSPACE_PATH}requirements.txt"
                    ;;
                  --conda )
                    conda env export --name "${PROMPTARR[4]}" > "${WORKSPACE_PATH}requirements.yml"
                    conda env update --name "${PROMPTARR[1]}" --file "${WORKSPACE_PATH}requirements.yml"
                    trash "${WORKSPACE_PATH}requirements.txt"
                    ;;
                  * )
                    echo -e "Bad syntax: ${PROMPTARR[3]} isn't a valid option\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
                esac
                ;;
              --file )
                case "${PROMPTARR[3]}" in
                  --pip )
                    ${CONDA_PATH}/envs/"${PROMPTARR[1]}"/bin/pip install -r "${PROMPTARR[4]}"
                    ;;
                  --conda )
                    conda env update --name "${PROMPTARR[1]}" --file "${PROMPTARR[4]}"
                    ;;
                  * )
                    echo -e "Bad syntax: ${PROMPTARR[3]} isn't a valid option\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
                esac
                ;;
              * )
                echo -e "Bad syntax: ${PROMPTARR[2]} isn't a valid option\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            esac
          else
            echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            echo -e ""
          fi
          ;;
      export )
          if [[ "${#PROMPTARR[@]}" -eq 2 ]]
          then
            case "${PROMPTARR[1]}" in
              help )
                echo -e "export help\t\t\t\t\t\t\t Displays this help text"
                echo -e "export <env_name> [--conda --pip] <file_path>\t\t\t Exports requirements of pip or conda environment of given conda environment"
                echo -e ""
                ;;
              * )
              echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
              echo -e ""
            esac
          elif [[ "${#PROMPTARR[@]}" -eq 4 ]]
          then
            case "${PROMPTARR[2]}" in
              --pip )
                ${CONDA_PATH}/envs/"${PROMPTARR[1]}"/bin/pip freeze > "${PROMPTARR[3]}"
                ;;
              --conda )
                conda env export --name "${PROMPTARR[1]}" > "${PROMPTARR[3]}"
                ;;
              * )
                echo -e "Bad syntax: ${PROMPTARR[2]} isn't a valid option\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            esac
          else
            echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            echo -e ""
          fi
          ;;
      check )
      if [[ "${#PROMPTARR[@]}" -eq 2 ]]
      then
            case "${PROMPTARR[1]}" in
              help )
                echo -e "check help\t\t\t\t\t\t\t Displays this help text"
                echo -e "check <env_name> [--conda --pip]\t\t\t\t Displays installed libraries of pip or conda environment of given conda environment"
                echo -e ""
                ;;
              * )
              echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
              echo -e ""
            esac
          elif [[ "${#PROMPTARR[@]}" -eq 3 ]]
          then
            case "${PROMPTARR[2]}" in
              --pip )
                ${CONDA_PATH}/envs/${CONDA_DEFAULT_ENV}/bin/pip list
                echo ""
                ;;
              --conda )
                conda list --name ${CONDA_DEFAULT_ENV}
                echo ""
                ;;
              * )
                echo -e "Bad syntax: ${PROMPTARR[2]} isn't a valid option\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            esac
          else
            echo -e "Bad syntax: ${#PROMPTARR[@]} variables are given\nPlease enter \"${PROMPTARR[0]} help\" command to see syntax and parameters of this command"
            echo -e ""
          fi
          ;;
      *)
          echo -e "Invalid command entered\nCheck help section by using \"help\" command to see valid commands";;
    esac
  fi
done
