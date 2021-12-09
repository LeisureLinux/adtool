#### Description:

adtool is a unix command line utility for Active Directory administration. Features include user and group creation, deletion, modification, password setting and directory query and search capabilities. Not fully tested yet so far.

#### [Bilibili Video](https://www.bilibili.com/video/BV1Ri4y1R7S8/)

#### System requirements:

adtool requires LDAP libraries to be installed (www.openldap.org). To use secure (ldaps://) connections OpenLDAP has to have been built with SSL support. SSL support is required for the password setting feature to work.

Copy the build-openldap.sh to the uncompressed openldap dir, run the script first

#### Installation:

Run build-adtool.sh after openldap libraries built successfully.

#### Configuration:

An example configuration file is installed to {prefix}/etc/adtool.cfg.dist. Rename this to adtool.cfg and edit as appropriate. Alternatively, command line options can be used.

#### Usage:

See the adtool man page

#### Todo:

1. ~~Add aarch64 support~~
2. ~~Add static compiling(muslib) support~~
3. "make install-strip" is not working when cross compiling, STRIPPROG is not working
4. See the TODO file

#### FAQ:

1. I encounter "am\_\_api_version" hard coded in aclocal.m4, error: "can't find aclocal-1.7"
   Fix:
   ```
   autoreconf --force --install
   ```
