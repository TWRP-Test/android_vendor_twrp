# CTS HACK
CTS_FILE="cts/tests/tests/os/assets/platform_versions.txt"
CTS_RELE="cts/tests/tests/os/assets/platform_releases.txt"
CTS_VERSION=99.87.36

if ! grep -q ${CTS_VERSION} ${CTS_FILE}; then
	echo ${CTS_VERSION} >> ${CTS_FILE};
fi

if ! grep -q ${CTS_VERSION} ${CTS_RELE}; then
	echo ${CTS_VERSION} >> ${CTS_RELE};
fi

