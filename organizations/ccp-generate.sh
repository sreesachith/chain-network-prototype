#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${P1PORT}/$6/" \
        -e "s/\${P2PORT}/$7/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${P1PORT}/$6/" \
        -e "s/\${P2PORT}/$7/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=rr
P0PORT=7051
P1PORT=7052
P2PORT=7057
CAPORT=7054
PEERPEM=organizations/peerOrganizations/rr.isfcr.com/tlsca/tlsca.rr.isfcr.com-cert.pem
CAPEM=organizations/peerOrganizations/rr.isfcr.com/ca/ca.rr.isfcr.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT $P2PORT)" > organizations/peerOrganizations/rr.isfcr.com/connection-rr.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT $P2PORT)" > organizations/peerOrganizations/rr.isfcr.com/connection-rr.yaml

ORG=ec
P0PORT=9051
P0PORT=9052
CAPORT=8054
PEERPEM=organizations/peerOrganizations/ec.isfcr.com/tlsca/tlsca.ec.isfcr.com-cert.pem
CAPEM=organizations/peerOrganizations/ec.isfcr.com/ca/ca.ec.isfcr.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT)" > organizations/peerOrganizations/ec.isfcr.com/connection-ec.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $P1PORT)" > organizations/peerOrganizations/ec.isfcr.com/connection-ec.yaml
