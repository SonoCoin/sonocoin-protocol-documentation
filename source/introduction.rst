************
Introduction
************

SonoCoin is a decentralized blockchain platform with a native crypto currency based on proof of stake (PoS). As such, there exist a variety of appilcations surrounding the SonoCoin ecosystem.

This documentation focuses on the protocol specification that allows nodes to communicate with each other and agree on the state of the blockchain in a decentralized manner.

SonoCoin Nodes
##############

A SonoCoin node is any piece of software that behaves according to the present SonoCoin protocol specification. Nodes form the basis of a SonoCoin network and perform several important functions:

* Peer-to-peer communication over TCP / UDP
* Blockchain storage
* Consensus establishment
* Gateway functionality

An open source :ref:`reference_implementation` of a SonoCoin node was implemented by the SonoCoin foundation.

SonoCoin Networks
#################

A SonoCoin network is formed by a large number of nodes interacting with each other according to the protocol specification. 

Currently, two public networks exists:

* Main network
* Test network

SonoCoin Clients
################

A SonoCoin client is any piece of software that interacts with a SonoCoin network. Clients use the gateway functionality of nodes to publish transactions or query the blockchain state.
Several different open source clients implementations have been developed by the SonoCoin foundation:

* Android Client
* iOS Client
* Desktop Client

.. note:: Github links will be added soon.
