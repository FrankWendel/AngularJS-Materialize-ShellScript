#!/bin/bash
#service_uteis_instalado.sh 4 
	DOMINIO=$1
	DNS1=$2
	DNS2=$3
	SUBNET=$4
	NETMASK=$5
	RANGE1=$6
	RANGE2=$7
	GATEWAY=$8
	INTERFACE=$9
	service_uteis_backup.sh /etc/dhcp/dhcpd.conf
	sudo echo -e "ddns-update-style none;\noption domain-name $DOMINIO;\noption domain-name-servers $DNS1, $DNS2;\ndefault-lease-time 600;\nmax-lease-time 7200;\nauthoritative;\nlog-facility local7;\nsubnet $SUBNET netmask $NETMASK {\nrange $RANGE1 $RANGE2;\noption routers $GATEWAY;\n}" > /etc/dhcp/dhcpd.conf
	service_uteis_backup.sh /etc/default/isc-dhcp-server
#	rm /etc/default/isc-dhcp-server
	echo "$INTERFACE"
	echo "INTERFACES=$INTERFACE"> /etc/default/isc-dhcp-server
	sudo service isc-dhcp-server restart
