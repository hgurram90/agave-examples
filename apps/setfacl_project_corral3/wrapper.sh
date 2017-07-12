set -x
WRAPPERDIR=$( cd "$( dirname "$0" )" && pwd )

${AGAVE_JOB_CALLBACK_RUNNING}
# Run the script with the runtime values passed in from the job request
PREFIX="/corral-repl/projects/NHERI/projects/${projectID}"
# Check to make sure the project directory exists
if [[ -d "$PREFIX" && -x "$PREFIX" ]];
then
  NUID=`/home/tg458981/bin/getUID.sh ${AGAVE_JOB_OWNER}`

  echo "UID is $NUID"
  if [ "$NUID" -eq "$NUID" ]
  then
      echo "$NUID is an integer !!"
  else
      echo "UID ($NUID) not found or not found to be an integer"
      ${AGAVE_JOB_CALLBACK_FAILURE}
      exit 1
  fi

  setfacl -R -m d:u:tg458981:rwX,u:${NUID}:rwX $PREFIX

  getfacl $PREFIX
  echo "Apparent Success!!"
else
  echo "Directory $PREFIX does not exist or is not accesible."
  ${AGAVE_JOB_CALLBACK_FAILURE}
	exit 1
fi

if [ ! $? ]; then
	echo "setfacl_project_corral3 exited with an error status. $?" >&2
	${AGAVE_JOB_CALLBACK_FAILURE}
	exit 1
fi