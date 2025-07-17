#! /bin/bash

##############################################################
# AstroPush Pushover backend install script                  #
##############################################################

PREFIX=
UNINSTALL=no

print_usage() {
    echo " USAGE: $0 [options]"
    echo "   OPTIONS"
    echo "    -p, --prefix <prefix>        prepend <prefix> to file installation paths"
    echo "    -u, --uninstall              uninstall previously installed files"
    echo "    -h, --help                   prints this help"
    echo
    exit 0
}

ARG=
OPTS=$( getopt -q -u -l prefix:,uninstall,help p:uh $* )
if [ $? != 0 ]; then
    echo "ERROR: invalid options"
    print_usage
    exit 1
fi

for o in $OPTS; do
    case $ARG in
        prefix)
            ARG=
            if [ "${o:0:2}" = "'-" ]; then
                echo "ERROR: Missing argument for -p|--prefix option" 1>&2
                echo
                exit 1
            fi
            PREFIX=$o
            continue
            ;;
    esac
    
    case $o in            
        --uninstall|-u)
            UNINSTALL=yes
            ;;

        --prefix|-p)
            ARG=prefix
            ;;
        --help|-h)
            print_usage
            ;;
    esac
done


MYDIR=$( dirname $0 )
MYDIR=$( realpath "$MYDIR" )

BACKENDS_DIR=$PREFIX/usr/share/astropush/backends
CFG_DIR=$PREFIX/etc/astropush
DOC_DIR=$PREFIX/usr/share/doc/astropush

if [ ! -d "$CFG_DIR" ]; then
    echo "Error: config directory missing. Is astropush frontend installed?" 1>&2
    exit 1
fi

if [ ! -d "$BACKENDS_DIR" ]; then
    echo "Error: backends directory missing. Is astropush frontend installed?" 1>&2
    exit 1
fi

if [ "$UNINSTALL" = "yes" ]; then
    echo "### Uninstalling astropush Pushover backend..."
    rm -R "$BACKENDS_DIR/pushover"
    [ -f "$CFG_DIR/backend.pushover.conf" ] && rm "$CFG_DIR/backend.pushover.conf"
    rm "$DOC_DIR/README.backend.pushover.md"
    rm "$DOC_DIR/LICENSE.backend.pushover"
    echo "### Done!"
    exit 0
fi

echo "### Installing astropush Pushover backend..."

install -d "$BACKENDS_DIR/pushover"
install -m 644 $MYDIR/backend/backend.sh $MYDIR/backend/backend.pushover.conf.sample "$BACKENDS_DIR/pushover/"
install -m 644 $MYDIR/backend/backend.pushover.conf.sample "$CFG_DIR/backend.pushover.conf"
install -m 644 $MYDIR/README.md "$DOC_DIR/README.backend.pushover.md"
install -m 644 $MYDIR/LICENSE "$DOC_DIR/LICENSE.backend.pushover"

echo "### Pushover backend installed!"
echo "### Next steps, check "
echo "###     $CFG_DIR/push.conf.conf"
echo "###     $CFG_DIR/backend.pushover.conf"
echo "### to enable and configure it system-wide."
echo "### Check documentation for details."
echo
