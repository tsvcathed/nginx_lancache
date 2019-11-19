#!/bin/bash

# Path to tc binary
TCPATH=/sbin/tc
# Interface to apply ingress policer to
IFACE=ens160
# Bandwidth in mibibytes per second to limit port 443 ingress traffic to - eg, 50% of link capacity
RATE=50mibit
# Police burst rate. Change if you want, otherwise leave as is.
BURST=1m

$TCPATH qdisc del dev $IFACE ingress   
$TCPATH qdisc add dev $IFACE ingress
$TCPATH filter add dev $IFACE ingress protocol ip basic match 'cmp(u16 at 0 layer transport eq 443)' action police rate $RATE burst $BURST