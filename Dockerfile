FROM debian:stretch-slim
ARG CF_INSTALLER_URL
ARG CF_SILENT_PROPERTIES_URL
ENV CF_INSTALL_FOLDER=/opt/coldfusion2016
EXPOSE 8500

COPY ./start.sh /root/start.sh

RUN apt-get update \
	&& apt-get -yq install curl libstdc++6 apache2 unzip \
	&& ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.22 /usr/lib/libstdc++.so.6 \
	&& cd /root \
	&& curl ${CF_INSTALLER_URL} --output /tmp/ColdFusionInstaller.bin \
	&& curl ${CF_SILENT_PROPERTIES_URL} --output /tmp/silent.properties \
	&& chmod +x /tmp/ColdFusionInstaller.bin \
	&& /tmp/ColdFusionInstaller.bin -f /tmp/silent.properties \
	&& chown -h nobody:bin ${CF_INSTALL_FOLDER}/cfusion/wwwroot/cfide \
	#&& apt-get -yq purge curl \
	&& apt-get -yq autoclean \
	&& apt-get -yq autoremove \
	&& apt-get -yq clean \
	# Remove apt caches
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	# Set execute on start
	&& chmod +x ./start.sh
	
ENTRYPOINT ["/root/start.sh"]