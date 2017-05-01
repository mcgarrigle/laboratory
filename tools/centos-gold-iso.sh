yum install -y genisoimage
mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom
mkdir /iso
shopt -s dotglob
cp -ri /media/cdrom/* /iso
cp ../ks/gold.ks /iso/
vi /iso/isolinux/isolinux.cfg 
mkisofs -o /tmp/centos-gold-7,3,1611.iso -b isolinux/isolinux.bin -c isolinux/boot.cat --no-emul-boot --boot-load-size 4 --boot-info-table -J -R -V Gold .
