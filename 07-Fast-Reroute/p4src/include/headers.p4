/* -*- P4_16 -*- */
#include <core.p4>
#include <v1model.p4>
#define N_PREFS 1024
#define PORT_WIDTH 32
#define NONE 255
#define HEARTBEAT 0x1234

typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;
typedef bit<20> label_t;

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}
header ipv4_t {
    bit<4>    version;
    bit<4>    ihl;
    bit<2>    ecn;
    bit<6>    dscp;
    bit<16>   totalLen;
    bit<16>   identification;
    bit<3>    flags;
    bit<13>   fragOffset;
    bit<8>    ttl;
    bit<8>    protocol;
    bit<16>   hdrChecksum;
    ip4Addr_t srcAddr;
    ip4Addr_t dstAddr;
}
header heartbeat_t {
    bit<9>    port;
    bit<1>    from_cp;
    bit<1>    failed_link;
    bit<5>    padding;
}
struct metadata {
    bit<1> linkState;
    bit<32> nextHop;
    bit<32> index;
    bit<48> timestamp;
}
struct headers {
    ethernet_t                      ethernet;
    heartbeat_t                     heartbeat;
    ipv4_t                          ipv4;
}
