# bsign64
bsign for elf64 binaries

How to use.

Configure with cmake and build it.

Fill sign.sh with your data (in header)
Put scripts and bsign file in one folder.

To sign:
./sign.sh path_to_file_for_signing 
(It will also export public key)

To verify:
./verify.sh signed_file public_key
