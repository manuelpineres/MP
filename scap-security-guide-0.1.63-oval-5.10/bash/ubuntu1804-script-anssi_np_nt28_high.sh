#!/usr/bin/env bash
###############################################################################
#
# Bash Remediation Script for Profile for ANSSI DAT-NT28 High (Enforced) Level
#
# Profile Description:
# This profile contains items for GNU/Linux installations storing sensitive information that can be accessible from unauthenticated or uncontroled networks.
#
# Profile ID:  anssi_np_nt28_high
# Benchmark ID:  UBUNTU-BIONIC
# Benchmark Version:  0.1.63
# XCCDF Version:  1.1
#
# This file was generated by OpenSCAP 1.3.6 using:
# $ oscap xccdf generate fix --profile anssi_np_nt28_high --fix-type bash xccdf-file.xml
#
# This Bash Remediation Script is generated from an OpenSCAP profile without preliminary evaluation.
# It attempts to fix every selected rule, even if the system is already compliant.
#
# How to apply this Bash Remediation Script:
# $ sudo ./remediation-script.sh
#
###############################################################################

###############################################################################
# BEGIN fix (1 / 46) for 'partition_for_home'
###############################################################################
(>&2 echo "Remediating rule 1/46: 'partition_for_home'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_home' IS MISSING!")

# END fix for 'partition_for_home'

###############################################################################
# BEGIN fix (2 / 46) for 'partition_for_tmp'
###############################################################################
(>&2 echo "Remediating rule 2/46: 'partition_for_tmp'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_tmp' IS MISSING!")

# END fix for 'partition_for_tmp'

###############################################################################
# BEGIN fix (3 / 46) for 'partition_for_var'
###############################################################################
(>&2 echo "Remediating rule 3/46: 'partition_for_var'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_var' IS MISSING!")

# END fix for 'partition_for_var'

###############################################################################
# BEGIN fix (4 / 46) for 'partition_for_var_log'
###############################################################################
(>&2 echo "Remediating rule 4/46: 'partition_for_var_log'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_var_log' IS MISSING!")

# END fix for 'partition_for_var_log'

###############################################################################
# BEGIN fix (5 / 46) for 'partition_for_var_log_audit'
###############################################################################
(>&2 echo "Remediating rule 5/46: 'partition_for_var_log_audit'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_var_log_audit' IS MISSING!")

# END fix for 'partition_for_var_log_audit'

###############################################################################
# BEGIN fix (6 / 46) for 'sudo_remove_no_authenticate'
###############################################################################
(>&2 echo "Remediating rule 6/46: 'sudo_remove_no_authenticate'")

for f in /etc/sudoers /etc/sudoers.d/* ; do
  if [ ! -e "$f" ] ; then
    continue
  fi
  matching_list=$(grep -P '^(?!#).*[\s]+\!authenticate.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      # comment out "!authenticate" matches to preserve user data
      sed -i "s/^${entry}$/# &/g" $f
    done <<< "$matching_list"

    /usr/sbin/visudo -cf $f &> /dev/null || echo "Fail to validate $f with visudo"
  fi
done

# END fix for 'sudo_remove_no_authenticate'

###############################################################################
# BEGIN fix (7 / 46) for 'sudo_remove_nopasswd'
###############################################################################
(>&2 echo "Remediating rule 7/46: 'sudo_remove_nopasswd'")

for f in /etc/sudoers /etc/sudoers.d/* ; do
  if [ ! -e "$f" ] ; then
    continue
  fi
  matching_list=$(grep -P '^(?!#).*[\s]+NOPASSWD[\s]*\:.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      # comment out "NOPASSWD" matches to preserve user data
      sed -i "s/^${entry}$/# &/g" $f
    done <<< "$matching_list"

    /usr/sbin/visudo -cf $f &> /dev/null || echo "Fail to validate $f with visudo"
  fi
done

# END fix for 'sudo_remove_nopasswd'

###############################################################################
# BEGIN fix (8 / 46) for 'package_audit_installed'
###############################################################################
(>&2 echo "Remediating rule 8/46: 'package_audit_installed'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "auditd"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'package_audit_installed'

###############################################################################
# BEGIN fix (9 / 46) for 'service_auditd_enabled'
###############################################################################
(>&2 echo "Remediating rule 9/46: 'service_auditd_enabled'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] && { dpkg-query --show --showformat='${db:Status-Status}\n' 'audit' 2>/dev/null | grep -q installed; }; then

SYSTEMCTL_EXEC='/usr/bin/systemctl'
"$SYSTEMCTL_EXEC" unmask 'auditd.service'
"$SYSTEMCTL_EXEC" start 'auditd.service'
"$SYSTEMCTL_EXEC" enable 'auditd.service'

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'service_auditd_enabled'

###############################################################################
# BEGIN fix (10 / 46) for 'grub2_enable_iommu_force'
###############################################################################
(>&2 echo "Remediating rule 10/46: 'grub2_enable_iommu_force'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'grub2-common' 2>/dev/null | grep -q installed && { [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; }; then

# Correct the form of default kernel command line in GRUB
if grep -q '^GRUB_CMDLINE_LINUX=.*iommu=.*"'  '/etc/default/grub' ; then
       # modify the GRUB command-line if an iommu= arg already exists
       sed -i "s/\(^GRUB_CMDLINE_LINUX=\".*\)iommu=[^[:space:]]\+\(.*\"\)/\1iommu=force\2/"  '/etc/default/grub'
else
       # no iommu=arg is present, append it
       sed -i "s/\(^GRUB_CMDLINE_LINUX=\".*\)\"/\1 iommu=force\"/"  '/etc/default/grub'
fi
update-grub

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'grub2_enable_iommu_force'

###############################################################################
# BEGIN fix (11 / 46) for 'rsyslog_files_groupownership'
###############################################################################
(>&2 echo "Remediating rule 11/46: 'rsyslog_files_groupownership'")
(>&2 echo "FIX FOR THIS RULE 'rsyslog_files_groupownership' IS MISSING!")

# END fix for 'rsyslog_files_groupownership'

###############################################################################
# BEGIN fix (12 / 46) for 'rsyslog_files_ownership'
###############################################################################
(>&2 echo "Remediating rule 12/46: 'rsyslog_files_ownership'")
(>&2 echo "FIX FOR THIS RULE 'rsyslog_files_ownership' IS MISSING!")

# END fix for 'rsyslog_files_ownership'

###############################################################################
# BEGIN fix (13 / 46) for 'rsyslog_files_permissions'
###############################################################################
(>&2 echo "Remediating rule 13/46: 'rsyslog_files_permissions'")
(>&2 echo "FIX FOR THIS RULE 'rsyslog_files_permissions' IS MISSING!")

# END fix for 'rsyslog_files_permissions'

###############################################################################
# BEGIN fix (14 / 46) for 'ensure_logrotate_activated'
###############################################################################
(>&2 echo "Remediating rule 14/46: 'ensure_logrotate_activated'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

LOGROTATE_CONF_FILE="/etc/logrotate.conf"
CRON_DAILY_LOGROTATE_FILE="/etc/cron.daily/logrotate"

# daily rotation is configured
grep -q "^daily$" $LOGROTATE_CONF_FILE|| echo "daily" >> $LOGROTATE_CONF_FILE

# remove any line configuring weekly, monthly or yearly rotation
sed -i '/^\s*\(weekly\|monthly\|yearly\).*$/d' $LOGROTATE_CONF_FILE

# configure cron.daily if not already
if ! grep -q "^[[:space:]]*/usr/sbin/logrotate[[:alnum:][:blank:][:punct:]]*$LOGROTATE_CONF_FILE$" $CRON_DAILY_LOGROTATE_FILE; then
	echo "#!/bin/sh" > $CRON_DAILY_LOGROTATE_FILE
	echo "/usr/sbin/logrotate $LOGROTATE_CONF_FILE" >> $CRON_DAILY_LOGROTATE_FILE
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'ensure_logrotate_activated'

###############################################################################
# BEGIN fix (15 / 46) for 'file_permissions_systemmap'
###############################################################################
(>&2 echo "Remediating rule 15/46: 'file_permissions_systemmap'")
(>&2 echo "FIX FOR THIS RULE 'file_permissions_systemmap' IS MISSING!")

# END fix for 'file_permissions_systemmap'

###############################################################################
# BEGIN fix (16 / 46) for 'sysctl_fs_protected_hardlinks'
###############################################################################
(>&2 echo "Remediating rule 16/46: 'sysctl_fs_protected_hardlinks'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

# Comment out any occurrences of fs.protected_hardlinks from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf; do

  matching_list=$(grep -P '^(?!#).*[\s]*fs.protected_hardlinks.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "fs.protected_hardlinks" matches to preserve user data
      sed -i "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set runtime for fs.protected_hardlinks
#
/sbin/sysctl -q -n -w fs.protected_hardlinks="1"

#
# If fs.protected_hardlinks present in /etc/sysctl.conf, change value to "1"
#	else, add "fs.protected_hardlinks = 1" to /etc/sysctl.conf
#
# Test if the config_file is a symbolic link. If so, use --follow-symlinks with sed.
# Otherwise, regular sed command will do.
sed_command=('sed' '-i')
if test -L "/etc/sysctl.conf"; then
    sed_command+=('--follow-symlinks')
fi

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^fs.protected_hardlinks")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "1"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^fs.protected_hardlinks\\>" "/etc/sysctl.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    "${sed_command[@]}" "s/^fs.protected_hardlinks\\>.*/$escaped_formatted_output/gi" "/etc/sysctl.conf"
else
    # \n is precaution for case where file ends without trailing newline
    
    printf '%s\n' "$formatted_output" >> "/etc/sysctl.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'sysctl_fs_protected_hardlinks'

###############################################################################
# BEGIN fix (17 / 46) for 'sysctl_fs_protected_symlinks'
###############################################################################
(>&2 echo "Remediating rule 17/46: 'sysctl_fs_protected_symlinks'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

# Comment out any occurrences of fs.protected_symlinks from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf; do

  matching_list=$(grep -P '^(?!#).*[\s]*fs.protected_symlinks.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "fs.protected_symlinks" matches to preserve user data
      sed -i "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set runtime for fs.protected_symlinks
#
/sbin/sysctl -q -n -w fs.protected_symlinks="1"

#
# If fs.protected_symlinks present in /etc/sysctl.conf, change value to "1"
#	else, add "fs.protected_symlinks = 1" to /etc/sysctl.conf
#
# Test if the config_file is a symbolic link. If so, use --follow-symlinks with sed.
# Otherwise, regular sed command will do.
sed_command=('sed' '-i')
if test -L "/etc/sysctl.conf"; then
    sed_command+=('--follow-symlinks')
fi

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^fs.protected_symlinks")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "1"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^fs.protected_symlinks\\>" "/etc/sysctl.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    "${sed_command[@]}" "s/^fs.protected_symlinks\\>.*/$escaped_formatted_output/gi" "/etc/sysctl.conf"
else
    # \n is precaution for case where file ends without trailing newline
    
    printf '%s\n' "$formatted_output" >> "/etc/sysctl.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'sysctl_fs_protected_symlinks'

###############################################################################
# BEGIN fix (18 / 46) for 'file_groupowner_etc_group'
###############################################################################
(>&2 echo "Remediating rule 18/46: 'file_groupowner_etc_group'")



chgrp 0 /etc/group

# END fix for 'file_groupowner_etc_group'

###############################################################################
# BEGIN fix (19 / 46) for 'file_groupowner_etc_gshadow'
###############################################################################
(>&2 echo "Remediating rule 19/46: 'file_groupowner_etc_gshadow'")



chgrp 42 /etc/gshadow

# END fix for 'file_groupowner_etc_gshadow'

###############################################################################
# BEGIN fix (20 / 46) for 'file_groupowner_etc_passwd'
###############################################################################
(>&2 echo "Remediating rule 20/46: 'file_groupowner_etc_passwd'")



chgrp 0 /etc/passwd

# END fix for 'file_groupowner_etc_passwd'

###############################################################################
# BEGIN fix (21 / 46) for 'file_groupowner_etc_shadow'
###############################################################################
(>&2 echo "Remediating rule 21/46: 'file_groupowner_etc_shadow'")



chgrp 42 /etc/shadow

# END fix for 'file_groupowner_etc_shadow'

###############################################################################
# BEGIN fix (22 / 46) for 'file_owner_etc_group'
###############################################################################
(>&2 echo "Remediating rule 22/46: 'file_owner_etc_group'")



chown 0 /etc/group

# END fix for 'file_owner_etc_group'

###############################################################################
# BEGIN fix (23 / 46) for 'file_owner_etc_gshadow'
###############################################################################
(>&2 echo "Remediating rule 23/46: 'file_owner_etc_gshadow'")



chown 0 /etc/gshadow

# END fix for 'file_owner_etc_gshadow'

###############################################################################
# BEGIN fix (24 / 46) for 'file_owner_etc_passwd'
###############################################################################
(>&2 echo "Remediating rule 24/46: 'file_owner_etc_passwd'")



chown 0 /etc/passwd

# END fix for 'file_owner_etc_passwd'

###############################################################################
# BEGIN fix (25 / 46) for 'file_owner_etc_shadow'
###############################################################################
(>&2 echo "Remediating rule 25/46: 'file_owner_etc_shadow'")



chown 0 /etc/shadow

# END fix for 'file_owner_etc_shadow'

###############################################################################
# BEGIN fix (26 / 46) for 'file_permissions_etc_group'
###############################################################################
(>&2 echo "Remediating rule 26/46: 'file_permissions_etc_group'")




chmod u-xs,g-xws,o-xwt /etc/group

# END fix for 'file_permissions_etc_group'

###############################################################################
# BEGIN fix (27 / 46) for 'file_permissions_etc_gshadow'
###############################################################################
(>&2 echo "Remediating rule 27/46: 'file_permissions_etc_gshadow'")




chmod u-xs,g-xws,o-xwrt /etc/gshadow

# END fix for 'file_permissions_etc_gshadow'

###############################################################################
# BEGIN fix (28 / 46) for 'file_permissions_etc_passwd'
###############################################################################
(>&2 echo "Remediating rule 28/46: 'file_permissions_etc_passwd'")




chmod u-xs,g-xws,o-xwt /etc/passwd

# END fix for 'file_permissions_etc_passwd'

###############################################################################
# BEGIN fix (29 / 46) for 'file_permissions_etc_shadow'
###############################################################################
(>&2 echo "Remediating rule 29/46: 'file_permissions_etc_shadow'")




chmod u-xs,g-xws,o-xwrt /etc/shadow

# END fix for 'file_permissions_etc_shadow'

###############################################################################
# BEGIN fix (30 / 46) for 'sysctl_fs_suid_dumpable'
###############################################################################
(>&2 echo "Remediating rule 30/46: 'sysctl_fs_suid_dumpable'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

# Comment out any occurrences of fs.suid_dumpable from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf; do

  matching_list=$(grep -P '^(?!#).*[\s]*fs.suid_dumpable.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "fs.suid_dumpable" matches to preserve user data
      sed -i "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set runtime for fs.suid_dumpable
#
/sbin/sysctl -q -n -w fs.suid_dumpable="0"

#
# If fs.suid_dumpable present in /etc/sysctl.conf, change value to "0"
#	else, add "fs.suid_dumpable = 0" to /etc/sysctl.conf
#
# Test if the config_file is a symbolic link. If so, use --follow-symlinks with sed.
# Otherwise, regular sed command will do.
sed_command=('sed' '-i')
if test -L "/etc/sysctl.conf"; then
    sed_command+=('--follow-symlinks')
fi

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^fs.suid_dumpable")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "0"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^fs.suid_dumpable\\>" "/etc/sysctl.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    "${sed_command[@]}" "s/^fs.suid_dumpable\\>.*/$escaped_formatted_output/gi" "/etc/sysctl.conf"
else
    # \n is precaution for case where file ends without trailing newline
    
    printf '%s\n' "$formatted_output" >> "/etc/sysctl.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'sysctl_fs_suid_dumpable'

###############################################################################
# BEGIN fix (31 / 46) for 'sysctl_kernel_randomize_va_space'
###############################################################################
(>&2 echo "Remediating rule 31/46: 'sysctl_kernel_randomize_va_space'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

# Comment out any occurrences of kernel.randomize_va_space from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf; do

  matching_list=$(grep -P '^(?!#).*[\s]*kernel.randomize_va_space.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "kernel.randomize_va_space" matches to preserve user data
      sed -i "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set runtime for kernel.randomize_va_space
#
/sbin/sysctl -q -n -w kernel.randomize_va_space="2"

#
# If kernel.randomize_va_space present in /etc/sysctl.conf, change value to "2"
#	else, add "kernel.randomize_va_space = 2" to /etc/sysctl.conf
#
# Test if the config_file is a symbolic link. If so, use --follow-symlinks with sed.
# Otherwise, regular sed command will do.
sed_command=('sed' '-i')
if test -L "/etc/sysctl.conf"; then
    sed_command+=('--follow-symlinks')
fi

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^kernel.randomize_va_space")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "2"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^kernel.randomize_va_space\\>" "/etc/sysctl.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    "${sed_command[@]}" "s/^kernel.randomize_va_space\\>.*/$escaped_formatted_output/gi" "/etc/sysctl.conf"
else
    # \n is precaution for case where file ends without trailing newline
    
    printf '%s\n' "$formatted_output" >> "/etc/sysctl.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'sysctl_kernel_randomize_va_space'

###############################################################################
# BEGIN fix (32 / 46) for 'apt_conf_disallow_unauthenticated'
###############################################################################
(>&2 echo "Remediating rule 32/46: 'apt_conf_disallow_unauthenticated'")
(>&2 echo "FIX FOR THIS RULE 'apt_conf_disallow_unauthenticated' IS MISSING!")

# END fix for 'apt_conf_disallow_unauthenticated'

###############################################################################
# BEGIN fix (33 / 46) for 'package_cron_installed'
###############################################################################
(>&2 echo "Remediating rule 33/46: 'package_cron_installed'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "cron"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'package_cron_installed'

###############################################################################
# BEGIN fix (34 / 46) for 'package_inetutils-telnetd_removed'
###############################################################################
(>&2 echo "Remediating rule 34/46: 'package_inetutils-telnetd_removed'")

# CAUTION: This remediation script will remove inetutils-telnetd
#	   from the system, and may remove any packages
#	   that depend on inetutils-telnetd. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "inetutils-telnetd"

# END fix for 'package_inetutils-telnetd_removed'

###############################################################################
# BEGIN fix (35 / 46) for 'package_nis_removed'
###############################################################################
(>&2 echo "Remediating rule 35/46: 'package_nis_removed'")

# CAUTION: This remediation script will remove nis
#	   from the system, and may remove any packages
#	   that depend on nis. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "nis"

# END fix for 'package_nis_removed'

###############################################################################
# BEGIN fix (36 / 46) for 'package_ntpdate_removed'
###############################################################################
(>&2 echo "Remediating rule 36/46: 'package_ntpdate_removed'")

# CAUTION: This remediation script will remove ntpdate
#	   from the system, and may remove any packages
#	   that depend on ntpdate. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "ntpdate"

# END fix for 'package_ntpdate_removed'

###############################################################################
# BEGIN fix (37 / 46) for 'package_telnetd-ssl_removed'
###############################################################################
(>&2 echo "Remediating rule 37/46: 'package_telnetd-ssl_removed'")

# CAUTION: This remediation script will remove telnetd-ssl
#	   from the system, and may remove any packages
#	   that depend on telnetd-ssl. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "telnetd-ssl"

# END fix for 'package_telnetd-ssl_removed'

###############################################################################
# BEGIN fix (38 / 46) for 'package_telnetd_removed'
###############################################################################
(>&2 echo "Remediating rule 38/46: 'package_telnetd_removed'")

# CAUTION: This remediation script will remove telnetd
#	   from the system, and may remove any packages
#	   that depend on telnetd. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "telnetd"

# END fix for 'package_telnetd_removed'

###############################################################################
# BEGIN fix (39 / 46) for 'package_ntp_installed'
###############################################################################
(>&2 echo "Remediating rule 39/46: 'package_ntp_installed'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "ntp"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'package_ntp_installed'

###############################################################################
# BEGIN fix (40 / 46) for 'service_ntp_enabled'
###############################################################################
(>&2 echo "Remediating rule 40/46: 'service_ntp_enabled'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

SYSTEMCTL_EXEC='/usr/bin/systemctl'
"$SYSTEMCTL_EXEC" unmask 'ntp.service'
"$SYSTEMCTL_EXEC" start 'ntp.service'
"$SYSTEMCTL_EXEC" enable 'ntp.service'

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'service_ntp_enabled'

###############################################################################
# BEGIN fix (41 / 46) for 'service_timesyncd_enabled'
###############################################################################
(>&2 echo "Remediating rule 41/46: 'service_timesyncd_enabled'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

SYSTEMCTL_EXEC='/usr/bin/systemctl'
"$SYSTEMCTL_EXEC" unmask 'systemd-timesyncd.service'
"$SYSTEMCTL_EXEC" start 'systemd-timesyncd.service'
"$SYSTEMCTL_EXEC" enable 'systemd-timesyncd.service'

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'service_timesyncd_enabled'

###############################################################################
# BEGIN fix (42 / 46) for 'sshd_set_keepalive_0'
###############################################################################
(>&2 echo "Remediating rule 42/46: 'sshd_set_keepalive_0'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

if [ -e "/etc/ssh/sshd_config" ] ; then
    
    LC_ALL=C sed -i "/^\s*ClientAliveCountMax\s\+/Id" "/etc/ssh/sshd_config"
else
    touch "/etc/ssh/sshd_config"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config"

cp "/etc/ssh/sshd_config" "/etc/ssh/sshd_config.bak"
# Insert before the line matching the regex '^Match'.
line_number="$(LC_ALL=C grep -n "^Match" "/etc/ssh/sshd_config.bak" | LC_ALL=C sed 's/:.*//g')"
if [ -z "$line_number" ]; then
    # There was no match of '^Match', insert at
    # the end of the file.
    printf '%s\n' "ClientAliveCountMax 0" >> "/etc/ssh/sshd_config"
else
    head -n "$(( line_number - 1 ))" "/etc/ssh/sshd_config.bak" > "/etc/ssh/sshd_config"
    printf '%s\n' "ClientAliveCountMax 0" >> "/etc/ssh/sshd_config"
    tail -n "+$(( line_number ))" "/etc/ssh/sshd_config.bak" >> "/etc/ssh/sshd_config"
fi
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'sshd_set_keepalive_0'

###############################################################################
# BEGIN fix (43 / 46) for 'sshd_set_idle_timeout'
###############################################################################
(>&2 echo "Remediating rule 43/46: 'sshd_set_idle_timeout'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

sshd_idle_timeout_value='300'


if [ -e "/etc/ssh/sshd_config" ] ; then
    
    LC_ALL=C sed -i "/^\s*ClientAliveInterval\s\+/Id" "/etc/ssh/sshd_config"
else
    touch "/etc/ssh/sshd_config"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config"

cp "/etc/ssh/sshd_config" "/etc/ssh/sshd_config.bak"
# Insert before the line matching the regex '^Match'.
line_number="$(LC_ALL=C grep -n "^Match" "/etc/ssh/sshd_config.bak" | LC_ALL=C sed 's/:.*//g')"
if [ -z "$line_number" ]; then
    # There was no match of '^Match', insert at
    # the end of the file.
    printf '%s\n' "ClientAliveInterval $sshd_idle_timeout_value" >> "/etc/ssh/sshd_config"
else
    head -n "$(( line_number - 1 ))" "/etc/ssh/sshd_config.bak" > "/etc/ssh/sshd_config"
    printf '%s\n' "ClientAliveInterval $sshd_idle_timeout_value" >> "/etc/ssh/sshd_config"
    tail -n "+$(( line_number ))" "/etc/ssh/sshd_config.bak" >> "/etc/ssh/sshd_config"
fi
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'sshd_set_idle_timeout'

###############################################################################
# BEGIN fix (44 / 46) for 'sshd_allow_only_protocol2'
###############################################################################
(>&2 echo "Remediating rule 44/46: 'sshd_allow_only_protocol2'")
(>&2 echo "FIX FOR THIS RULE 'sshd_allow_only_protocol2' IS MISSING!")

# END fix for 'sshd_allow_only_protocol2'

###############################################################################
# BEGIN fix (45 / 46) for 'sshd_disable_empty_passwords'
###############################################################################
(>&2 echo "Remediating rule 45/46: 'sshd_disable_empty_passwords'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

if [ -e "/etc/ssh/sshd_config" ] ; then
    
    LC_ALL=C sed -i "/^\s*PermitEmptyPasswords\s\+/Id" "/etc/ssh/sshd_config"
else
    touch "/etc/ssh/sshd_config"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config"

cp "/etc/ssh/sshd_config" "/etc/ssh/sshd_config.bak"
# Insert before the line matching the regex '^Match'.
line_number="$(LC_ALL=C grep -n "^Match" "/etc/ssh/sshd_config.bak" | LC_ALL=C sed 's/:.*//g')"
if [ -z "$line_number" ]; then
    # There was no match of '^Match', insert at
    # the end of the file.
    printf '%s\n' "PermitEmptyPasswords no" >> "/etc/ssh/sshd_config"
else
    head -n "$(( line_number - 1 ))" "/etc/ssh/sshd_config.bak" > "/etc/ssh/sshd_config"
    printf '%s\n' "PermitEmptyPasswords no" >> "/etc/ssh/sshd_config"
    tail -n "+$(( line_number ))" "/etc/ssh/sshd_config.bak" >> "/etc/ssh/sshd_config"
fi
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'sshd_disable_empty_passwords'

###############################################################################
# BEGIN fix (46 / 46) for 'sshd_disable_root_login'
###############################################################################
(>&2 echo "Remediating rule 46/46: 'sshd_disable_root_login'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

if [ -e "/etc/ssh/sshd_config" ] ; then
    
    LC_ALL=C sed -i "/^\s*PermitRootLogin\s\+/Id" "/etc/ssh/sshd_config"
else
    touch "/etc/ssh/sshd_config"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config"

cp "/etc/ssh/sshd_config" "/etc/ssh/sshd_config.bak"
# Insert before the line matching the regex '^Match'.
line_number="$(LC_ALL=C grep -n "^Match" "/etc/ssh/sshd_config.bak" | LC_ALL=C sed 's/:.*//g')"
if [ -z "$line_number" ]; then
    # There was no match of '^Match', insert at
    # the end of the file.
    printf '%s\n' "PermitRootLogin no" >> "/etc/ssh/sshd_config"
else
    head -n "$(( line_number - 1 ))" "/etc/ssh/sshd_config.bak" > "/etc/ssh/sshd_config"
    printf '%s\n' "PermitRootLogin no" >> "/etc/ssh/sshd_config"
    tail -n "+$(( line_number ))" "/etc/ssh/sshd_config.bak" >> "/etc/ssh/sshd_config"
fi
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'sshd_disable_root_login'

