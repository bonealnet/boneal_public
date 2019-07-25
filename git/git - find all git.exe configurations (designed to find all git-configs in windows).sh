#!/bin/bash
#
#	RUN VIA GIT BASH:
#
#   "${HOME}/Documents/GitHub/Coding/git/git - find all git.exe configurations (designed to find all git-configs in windows).sh"
#
# ------------------------------------------------------------

ROLLBACK_IFS="${IFS}";
IFS=$'\n'; # Set the global for-loop delimiter to newlines (ignore spaces)

ALL_SYSTEM_CONFIGS="${USERPROFILE}/_git_configs.system.txt";
ALL_GLOBAL_CONFIGS="${USERPROFILE}/_git_configs.globals.txt";

echo -n "" > "${ALL_SYSTEM_CONFIGS}";
echo -n "" > "${ALL_GLOBAL_CONFIGS}";

SEARCH_DIRECTORIES=();
SEARCH_DIRECTORIES+=("${LOCALAPPDATA}/");
SEARCH_DIRECTORIES+=("${PROGRAMFILES}/");
SEARCH_DIRECTORIES+=("${PROGRAMFILES} (x86)/");

for EACH_DIRECTORY in "${SEARCH_DIRECTORIES[@]}"; do

	EACH_DIR_REALPATH=$(realpath "${EACH_DIRECTORY}");

	find "${EACH_DIR_REALPATH}" \
	-name 'git.exe' \
	-print0 \
	2>"/dev/null" \
	| while IFS= read -r -d $'\0' EACH_GIT_EXE; do

		EACH_GIT_WIN32=$(realpath "${EACH_GIT_EXE}");
		EACH_GIT_LINUX=""; MM="${EACH_GIT_WIN32/C:/\/c}"; MM="${MM//\\/\/}"; EACH_GIT_LINUX=$(realpath "${MM}");

		SYSTEM_CONF_PATH=$("${EACH_GIT_LINUX}" config --system --list --show-origin | head -n 1 | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p');
		SYSTEM_CONF_LINUX=""; MM="${SYSTEM_CONF_PATH/C:/\/c}"; MM="${MM//\\/\/}"; SYSTEM_CONF_LINUX=$(realpath "${MM}");
		SYSTEM_ALREADY_NOTED=$(cat "${ALL_SYSTEM_CONFIGS}" | grep "${SYSTEM_CONF_LINUX}");
		if [ ! -n "${SYSTEM_ALREADY_NOTED}" ]; then
			echo "${SYSTEM_CONF_LINUX}" >> "${ALL_SYSTEM_CONFIGS}";
		fi;

		GLOBAL_CONF_PATH=$("${EACH_GIT_LINUX}" config --global --list --show-origin | head -n 1 | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p');
		GLOBAL_CONF_LINUX=""; MM="${GLOBAL_CONF_PATH/C:/\/c}"; MM="${MM//\\/\/}"; GLOBAL_CONF_LINUX=$(realpath "${MM}");
		GLOBAL_ALREADY_NOTED=$(cat "${ALL_GLOBAL_CONFIGS}" | grep "${GLOBAL_CONF_LINUX}");
		if [ ! -n "${GLOBAL_ALREADY_NOTED}" ]; then
			echo "${GLOBAL_CONF_LINUX}" >> "${ALL_GLOBAL_CONFIGS}";
		fi;

	done;
done;

echo "";
echo "[ SYSTEM ] Git-Config(s):";
for EACH_SYSTEM_CONFIG in $(cat "${ALL_SYSTEM_CONFIGS}"); do
	echo " ${EACH_SYSTEM_CONFIG}";
done;

echo "";
echo "[ GLOBAL ] Git-Config(s):";
for EACH_GLOBAL_CONFIG in $(cat "${ALL_GLOBAL_CONFIGS}"); do
	echo "  ${EACH_GLOBAL_CONFIG}";
done;

IFS="${ROLLBACK_IFS}";

# ------------------------------------------------------------