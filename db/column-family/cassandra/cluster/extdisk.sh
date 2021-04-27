DISK_NAME=""
FOLDER_NAME=""
while getopts :d:f:m option
do
    case "$option" in
        d)
            DISK_NAME=$OPTARG
            echo "option:d, value $OPTARG"
            ;;
        f)
            FOLDER_NAME=$OPTARG
            echo "option:f, value $OPTARG"
            ;;
        \?)
            echo "Usage: args [-i]"
            echo "-d disk name 'fdisk -l'"
            echo "-f cassandra folder name"
            exit 1;;
    esac
done
if [ -z "$DISK_NAME" ]
 then
  printf "Option -d specified\n"
fi
if [ -z "$FOLDER_NAME" ]
 then
  printf "Option -f specified\n"
fi
type=ext4
mount_dir=/$FOLDER_NAME
mkfs.$type /dev/$DISK_NAME
mkdir -p $mount_dir
echo "/dev/$DISK_NAME $mount_dir $type defaults 0 0" >> /etc/fstab
mount -a

mkdir /$FOLDER_NAME
mkdir /$FOLDER_NAME/cassandra
mkdir /$FOLDER_NAME/cassandra/data

chmod 777 /$FOLDER_NAME
chmod 777 /$FOLDER_NAME/cassandra/
chmod 777 /$FOLDER_NAME/cassandra/*