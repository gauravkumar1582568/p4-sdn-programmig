/* -*- P4_16 -*- */
#include <core.p4>
#include <v1model.p4>

//My includes
#include "include/headers.p4"
#include "include/parsers.p4"

#define N_PREFS 1024
#define PORT_WIDTH 32
#define N_PORTS 32
#define THRESHOLD 48w1000000 // 1s # WARNING set bigger than HB frequency.

/*************************************************************************
************   C H E C K S U M    V E R I F I C A T I O N   *************
*************************************************************************/

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {  }
}

/*************************************************************************
**************  I N G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

    // Register to look up the port of the default next hop.
    register<bit<PORT_WIDTH>>(N_PREFS) primaryNH;
    register<bit<PORT_WIDTH>>(N_PREFS) alternativeNH;

    // Register to look up the timestamp of the latest heartbeat received
    // from that specific port.
    register<bit<48>>(N_PORTS) tstamp_ports;

    // Register containing link states. 0: No Problems. 1: Link failure.
    register<bit<1>>(N_PORTS) linkState;

    action rewriteMac(macAddr_t dstAddr){
	    hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
        hdr.ethernet.dstAddr = dstAddr;
	}

    action drop() {
        mark_to_drop(standard_metadata);
    }

    action read_port(bit<32>  index){
        meta.index = index;
        // Read primary next hop and write result into meta.nextHop.
        primaryNH.read(meta.nextHop,  meta.index);

        // Read linkState of default next hop.
        linkState.read(meta.linkState, meta.nextHop);
    }

    action read_alternativePort(){
        // Read alternative next hop into metadata
        alternativeNH.read(meta.nextHop, meta.index);
    }

    action get_timestamp_for_port(){
        tstamp_ports.read(meta.timestamp, (bit<32>)hdr.heartbeat.port);
    }

    action set_timestamp_for_port(){
        tstamp_ports.write((bit<32>)standard_metadata.ingress_port, standard_metadata.ingress_global_timestamp);
    }

    action send_heartbeat(){
        // we make sure the other switch treats the packet as probe from the other side
        hdr.heartbeat.from_cp = 0;
        standard_metadata.egress_spec = hdr.heartbeat.port;
    }

    action update_linkState(){
        // Update the linkState such that the data plane knows the link is dead.
        linkState.write((bit<32>)hdr.heartbeat.port, 1);
     }

    table ipv4_lpm {
        key = {
            hdr.ipv4.dstAddr: lpm;
        }
        actions = {
            read_port;
            drop;
        }
        size = 512;
        default_action = drop;
    }

    table rewrite_mac {
        key = {
             meta.nextHop: exact;
        }
        actions = {
            rewriteMac;
            drop;
        }
        size = 512;
        default_action = drop;
    }

    apply {
        // It is a heartbeat message
        if (hdr.heartbeat.isValid()){
            // Control plane sent the packet, there is one for each port.
            if (hdr.heartbeat.from_cp == 1){
                // Heartbeat packet contains the port number. We check the
                // the timestamp for that port.
                get_timestamp_for_port();
                // If it has been at least THRESHOLD since the last received
                // heartbeat, set the linkState to down.
                if (meta.timestamp != 0 && (standard_metadata.ingress_global_timestamp - meta.timestamp > THRESHOLD)){
                    update_linkState();

                    // clone to controller while still forwarding
                    clone(CloneType.I2E, 100);
                }
                send_heartbeat();
            }
            // The heartbeat is received from neighbors. Set the receive time
            // for the arrival port.
            else{
                set_timestamp_for_port();
                drop();
            }
        }
        if (hdr.ipv4.isValid()){
            ipv4_lpm.apply();

            if(meta.linkState > 0){
                read_alternativePort();
            }
            standard_metadata.egress_spec = (bit<9>) meta.nextHop;
		    rewrite_mac.apply();
        }
    }
}
/*************************************************************************
****************  E G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {

    apply {

        if (hdr.heartbeat.isValid() && standard_metadata.instance_type == 1)
        {
            // set failed link flag for the clone we send to the cp
            hdr.heartbeat.failed_link = 1;
        }

    }

}

/*************************************************************************
*************   C H E C K S U M    C O M P U T A T I O N   **************
*************************************************************************/

control MyComputeChecksum(inout headers hdr, inout metadata meta) {
     apply {
  update_checksum(
      hdr.ipv4.isValid(),
            { hdr.ipv4.version,
        hdr.ipv4.ihl,
              hdr.ipv4.dscp,
              hdr.ipv4.ecn,
              hdr.ipv4.totalLen,
              hdr.ipv4.identification,
              hdr.ipv4.flags,
              hdr.ipv4.fragOffset,
              hdr.ipv4.ttl,
              hdr.ipv4.protocol,
              hdr.ipv4.srcAddr,
              hdr.ipv4.dstAddr },
            hdr.ipv4.hdrChecksum,
            HashAlgorithm.csum16);
    }
}




/*************************************************************************
***********************  S W I T C H  *******************************
*************************************************************************/

//switch architecture
V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;
