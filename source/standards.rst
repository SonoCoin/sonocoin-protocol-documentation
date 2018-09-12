*********
Standards
*********

Cryptography
============

Hashes
******

All hashes use the SHA256 algorithm as defined in FIPS 180-4. The reference implementation uses the sha256 package from golang's standard library.

Example
+++++++

The SHA256 hash of the message "Hello World!" results in:

.. code-block:: go

    0x7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069


Signatures
**********
.. _EdDSA: https://tools.ietf.org/html/rfc8032
.. _Curve25519: https://en.wikipedia.org/wiki/Curve25519

All signatures use EdDSA_ with Curve25519_. The reference implementation uses the go-libsodium library.

Example
+++++++

Given the following keypair:

.. code-block:: go

    0x75a8c71c874456844313e4e0766d9aee0b225a95497b576f0c914a19ce1c5f96 // private
    0xbe725676384aa8b7ce1faf7a0c20b7cb3e862c139bc0a9479a8789346e4af234 // public

Signing the msg "Hello World!" with the given private key would result in the following signature.

.. code-block:: go

    0xa4a0e361cfb0a28c8f577fe6ba440d8e4a441d42a1d93b695cdd470d14ced778adb70a8e1762f42366235610cebd98e58f791fae11faa7342077c330fe5bc707
    

Encoding
========

Some networking data is encoded using RLP to allow for more efficient usage of bandwidth.

Recursive Length Prefix (RLP)
*****************************
.. _`Ethereum developers`: https://github.com/ethereum/wiki/wiki/%5BEnglish%5D-RLP

Recursive Length Prefix (RLP) is a serialization format originally created by the `Ethereum developers`_.
Unlike other binary serialization formats, RLP doesn't differentiate between different data types but only encodes data structure.

Definition
++++++++++

- Single bytes between **0x00** and **0x7f** are their own RLP encoding.

- Byte arrays with a length of **0** to **55** bytes are encoded using a special prefix of **0x80** plus the length of the array.

.. note:: Special case: Single bytes between **0x80** and **0xff** are encoded as a byte array of length 1 and are thus prefixed with **0x81**.

- Byte arrays larger than **55** bytes are encoded using two prefixes. The first prefix **pf1** defines how many bytes are going to be used to encode the length of the array. The second prefix **pf2** defines the length of the array. **pf1** is calculated by adding the length of **pf2** to **0xb7**. **pf2** is simply the length of the byte array and might be several bytes long.

- Lists of length **0** to **55** are prefixed with 0xc0 added to the length of the list in bytes. List items can be any other RLP encoded data (lists, byte arrays, bytes).

- List of length greater than **55** are similarly encoded using two prefixes. The first prefix **pf1** defines how many bytes are going to be used to encode the length of the list. The second prefix **pf2** defines the length of the list. **pf1** is calculated by adding the length of **pf2** to **0xf7**. **pf2** is simply the length of the list in bytes and might be several bytes long.

.. note:: 

    The first byte of the RLP encoding thus implies the data structure as follows:

    +--------------+-------------------------+
    | Byte range   | Data structure          |
    +==============+=========================+
    | [0x00, 0x7f] | Single byte             |
    +--------------+-------------------------+
    | [0x80, 0xb7] | Byte array of size 0-55 |
    +--------------+-------------------------+
    | [0xb8, 0xbf] | Byte array of size > 55 |
    +--------------+-------------------------+
    | [0xc0, 0xf7] | List of size 0-55       |
    +--------------+-------------------------+
    | [0xf8, 0xff] | List of size > 55       |
    +--------------+-------------------------+

Examples
++++++++
.. role:: red

.. role:: green

.. role:: lightblue

.. role:: darkblue


+------------------------+--------------------------------------------------------------------------------------------------+
| Data                   | RLP Encoding                                                                                     |
+========================+==================================================================================================+
| 0x05                   | [0x05]                                                                                           |
+------------------------+--------------------------------------------------------------------------------------------------+
| "H"                    | [0x68]                                                                                           |
+------------------------+--------------------------------------------------------------------------------------------------+
| "Hello"                | [:red:`0x85, 0x68, 0x65, 0x6c, 0x6c, 0x6f`]                                                      |
+------------------------+--------------------------------------------------------------------------------------------------+
| "World"                | [:lightblue:`0x85, 0x77 0x6f 0x72 0x6c 0x64`]                                                    |
+------------------------+--------------------------------------------------------------------------------------------------+
| ["Hello","World"]      | [0xcc, :red:`0x85, 0x68, 0x65, 0x6c, 0x6c, 0x6f`, :lightblue:`0x85, 0x77 0x6f 0x72 0x6c 0x64`]   |
+------------------------+--------------------------------------------------------------------------------------------------+
| [[], [[]], [[], [[]]]] | [ 0xc7, 0xc0, 0xc1, 0xc0, 0xc3, 0xc0, 0xc1, 0xc0 ]                                               |
+------------------------+--------------------------------------------------------------------------------------------------+

.. note:: Since RLP doesn't know any data types, examples encode strings using ASCII for simplicity.

Decimals 
========

The value of SonoCoin is represented by a 64 bit unsigned integer (uint64). In order to allow fractions of a SonoCoin to be transfered, a constant is defined that determines how many decimal places are included in the value.
SonoCoin uses 8 decimal places, meaning that the amount of SonoCoins is the uint64 value divided by :math:`10^8`.

Examples
********

+-------------------+------------+
| uint64 Value      | SonoCoin   |
+===================+============+
| 1                 | 0.00000001 |
+-------------------+------------+
| 10                | 0.0000001  |
+-------------------+------------+
| 100               | 0.000001   |
+-------------------+------------+
| 1000              | 0.00001    |
+-------------------+------------+
| 10000             | 0.0001     |
+-------------------+------------+
| 100000            | 0.001      |
+-------------------+------------+
| 1000000           | 0.01       |
+-------------------+------------+
| 10000000          | 0.1        |
+-------------------+------------+
| 100000000         | 1          |
+-------------------+------------+
| 1000000000        | 10         |
+-------------------+------------+
| 10000000000       | 100        |
+-------------------+------------+
| 100000000000      | 1000       |
+-------------------+------------+
| 1000000000000     | 10000      |
+-------------------+------------+
| 10000000000000    | 100000     |
+-------------------+------------+
| 100000000000000   | 1000000    |
+-------------------+------------+
| 1000000000000000  | 10000000   |
+-------------------+------------+
| 10000000000000000 | 100000000  |
+-------------------+------------+