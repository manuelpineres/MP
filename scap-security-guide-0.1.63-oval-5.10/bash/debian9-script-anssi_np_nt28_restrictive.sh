#!/usr/bin/env bash
###############################################################################
#
# Bash Remediation Script for Profile for ANSSI DAT-NT28 Restrictive Level
#
# Profile Description:
# This profile contains items for GNU/Linux installations exposed to unauthenticated flows or multiple sources.
#
# Profile ID:  anssi_np_nt28_restrictive
# Benchmark ID:  DEBIAN-9
# Benchmark Version:  0.1.63
# XCCDF Version:  1.1
#
# This file was generated by OpenSCAP 1.3.6 using:
# $ oscap xccdf generate fix --profile anssi_np_nt28_restrictive --fix-type bash xccdf-file.xml
#
# This Bash Remediation Script is generated from an OpenSCAP profile without preliminary evaluation.
# It attempts to fix every selected rule, even if the system is already compliant.
#
# How to apply this Bash Remediation Script:
# $ sudo ./remediation-script.sh
#
###############################################################################

###############################################################################
# BEGIN fix (1 / 49) for 'partition_for_home'
###############################################################################
(>&2 echo "Remediating rule 1/49: 'partition_for_home'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_home' IS MISSING!")

# END fix for 'partition_for_home'

###############################################################################
# BEGIN fix (2 / 49) for 'partition_for_tmp'
###############################################################################
(>&2 echo "Remediating rule 2/49: 'partition_for_tmp'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_tmp' IS MISSING!")

# END fix for 'partition_for_tmp'

###############################################################################
# BEGIN fix (3 / 49) for 'partition_for_var'
###############################################################################
(>&2 echo "Remediating rule 3/49: 'partition_for_var'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_var' IS MISSING!")

# END fix for 'partition_for_var'

###############################################################################
# BEGIN fix (4 / 49) for 'partition_for_var_log'
###############################################################################
(>&2 echo "Remediating rule 4/49: 'partition_for_var_log'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_var_log' IS MISSING!")

# END fix for 'partition_for_var_log'

###############################################################################
# BEGIN fix (5 / 49) for 'partition_for_var_log_audit'
###############################################################################
(>&2 echo "Remediating rule 5/49: 'partition_for_var_log_audit'")
(>&2 echo "FIX FOR THIS RULE 'partition_for_var_log_audit' IS MISSING!")

# END fix for 'partition_for_var_log_audit'

###############################################################################
# BEGIN fix (6 / 49) for 'sudo_remove_no_authenticate'
###############################################################################
(>&2 echo "Remediating rule 6/49: 'sudo_remove_no_authenticate'")

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
# BEGIN fix (7 / 49) for 'sudo_remove_nopasswd'
###############################################################################
(>&2 echo "Remediating rule 7/49: 'sudo_remove_nopasswd'")

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
# BEGIN fix (8 / 49) for 'package_audit_installed'
###############################################################################
(>&2 echo "Remediating rule 8/49: 'package_audit_installed'")
(>&2 echo "FIX FOR THIS RULE 'package_audit_installed' IS MISSING!")

# END fix for 'package_audit_installed'

###############################################################################
# BEGIN fix (9 / 49) for 'service_auditd_enabled'
###############################################################################
(>&2 echo "Remediating rule 9/49: 'service_auditd_enabled'")
(>&2 echo "FIX FOR THIS RULE 'service_auditd_enabled' IS MISSING!")

# END fix for 'service_auditd_enabled'

###############################################################################
# BEGIN fix (10 / 49) for 'package_rsyslog_installed'
###############################################################################
(>&2 echo "Remediating rule 10/49: 'package_rsyslog_installed'")
(>&2 echo "FIX FOR THIS RULE 'package_rsyslog_installed' IS MISSING!")

# END fix for 'package_rsyslog_installed'

###############################################################################
# BEGIN fix (11 / 49) for 'service_rsyslog_enabled'
###############################################################################
(>&2 echo "Remediating rule 11/49: 'service_rsyslog_enabled'")
(>&2 echo "FIX FOR THIS RULE 'service_rsyslog_enabled' IS MISSING!")

# END fix for 'service_rsyslog_enabled'

###############################################################################
# BEGIN fix (12 / 49) for 'rsyslog_files_groupownership'
###############################################################################
(>&2 echo "Remediating rule 12/49: 'rsyslog_files_groupownership'")
(>&2 echo "FIX FOR THIS RULE 'rsyslog_files_groupownership' IS MISSING!")

# END fix for 'rsyslog_files_groupownership'

###############################################################################
# BEGIN fix (13 / 49) for 'rsyslog_files_ownership'
###############################################################################
(>&2 echo "Remediating rule 13/49: 'rsyslog_files_ownership'")
(>&2 echo "FIX FOR THIS RULE 'rsyslog_files_ownership' IS MISSING!")

# END fix for 'rsyslog_files_ownership'

###############################################################################
# BEGIN fix (14 / 49) for 'rsyslog_files_permissions'
###############################################################################
(>&2 echo "Remediating rule 14/49: 'rsyslog_files_permissions'")
(>&2 echo "FIX FOR THIS RULE 'rsyslog_files_permissions' IS MISSING!")

# END fix for 'rsyslog_files_permissions'

###############################################################################
# BEGIN fix (15 / 49) for 'ensure_logrotate_activated'
###############################################################################
(>&2 echo "Remediating rule 15/49: 'ensure_logrotate_activated'")
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
# BEGIN fix (16 / 49) for 'package_syslogng_installed'
###############################################################################
(>&2 echo "Remediating rule 16/49: 'package_syslogng_installed'")
(>&2 echo "FIX FOR THIS RULE 'package_syslogng_installed' IS MISSING!")

# END fix for 'package_syslogng_installed'

###############################################################################
# BEGIN fix (17 / 49) for 'service_syslogng_enabled'
###############################################################################
(>&2 echo "Remediating rule 17/49: 'service_syslogng_enabled'")
(>&2 echo "FIX FOR THIS RULE 'service_syslogng_enabled' IS MISSING!")

# END fix for 'service_syslogng_enabled'

###############################################################################
# BEGIN fix (18 / 49) for 'file_permissions_systemmap'
###############################################################################
(>&2 echo "Remediating rule 18/49: 'file_permissions_systemmap'")
(>&2 echo "FIX FOR THIS RULE 'file_permissions_systemmap' IS MISSING!")

# END fix for 'file_permissions_systemmap'

###############################################################################
# BEGIN fix (19 / 49) for 'sysctl_fs_protected_hardlinks'
###############################################################################
(>&2 echo "Remediating rule 19/49: 'sysctl_fs_protected_hardlinks'")
(>&2 echo "FIX FOR THIS RULE 'sysctl_fs_protected_hardlinks' IS MISSING!")

# END fix for 'sysctl_fs_protected_hardlinks'

###############################################################################
# BEGIN fix (20 / 49) for 'sysctl_fs_protected_symlinks'
###############################################################################
(>&2 echo "Remediating rule 20/49: 'sysctl_fs_protected_symlinks'")
(>&2 echo "FIX FOR THIS RULE 'sysctl_fs_protected_symlinks' IS MISSING!")

# END fix for 'sysctl_fs_protected_symlinks'

###############################################################################
# BEGIN fix (21 / 49) for 'file_groupowner_etc_group'
###############################################################################
(>&2 echo "Remediating rule 21/49: 'file_groupowner_etc_group'")



chgrp 0 /etc/group

# END fix for 'file_groupowner_etc_group'

###############################################################################
# BEGIN fix (22 / 49) for 'file_groupowner_etc_gshadow'
###############################################################################
(>&2 echo "Remediating rule 22/49: 'file_groupowner_etc_gshadow'")



chgrp 42 /etc/gshadow

# END fix for 'file_groupowner_etc_gshadow'

###############################################################################
# BEGIN fix (23 / 49) for 'file_groupowner_etc_passwd'
###############################################################################
(>&2 echo "Remediating rule 23/49: 'file_groupowner_etc_passwd'")



chgrp 0 /etc/passwd

# END fix for 'file_groupowner_etc_passwd'

###############################################################################
# BEGIN fix (24 / 49) for 'file_groupowner_etc_shadow'
###############################################################################
(>&2 echo "Remediating rule 24/49: 'file_groupowner_etc_shadow'")



chgrp 42 /etc/shadow

# END fix for 'file_groupowner_etc_shadow'

###############################################################################
# BEGIN fix (25 / 49) for 'file_owner_etc_group'
###############################################################################
(>&2 echo "Remediating rule 25/49: 'file_owner_etc_group'")



chown 0 /etc/group

# END fix for 'file_owner_etc_group'

###############################################################################
# BEGIN fix (26 / 49) for 'file_owner_etc_gshadow'
###############################################################################
(>&2 echo "Remediating rule 26/49: 'file_owner_etc_gshadow'")



chown 0 /etc/gshadow

# END fix for 'file_owner_etc_gshadow'

###############################################################################
# BEGIN fix (27 / 49) for 'file_owner_etc_passwd'
###############################################################################
(>&2 echo "Remediating rule 27/49: 'file_owner_etc_passwd'")



chown 0 /etc/passwd

# END fix for 'file_owner_etc_passwd'

###############################################################################
# BEGIN fix (28 / 49) for 'file_owner_etc_shadow'
###############################################################################
(>&2 echo "Remediating rule 28/49: 'file_owner_etc_shadow'")



chown 0 /etc/shadow

# END fix for 'file_owner_etc_shadow'

###############################################################################
# BEGIN fix (29 / 49) for 'file_permissions_etc_group'
###############################################################################
(>&2 echo "Remediating rule 29/49: 'file_permissions_etc_group'")




chmod u-xs,g-xws,o-xwt /etc/group

# END fix for 'file_permissions_etc_group'

###############################################################################
# BEGIN fix (30 / 49) for 'file_permissions_etc_gshadow'
###############################################################################
(>&2 echo "Remediating rule 30/49: 'file_permissions_etc_gshadow'")




chmod u-xs,g-xws,o-xwrt /etc/gshadow

# END fix for 'file_permissions_etc_gshadow'

###############################################################################
# BEGIN fix (31 / 49) for 'file_permissions_etc_passwd'
###############################################################################
(>&2 echo "Remediating rule 31/49: 'file_permissions_etc_passwd'")




chmod u-xs,g-xws,o-xwt /etc/passwd

# END fix for 'file_permissions_etc_passwd'

###############################################################################
# BEGIN fix (32 / 49) for 'file_permissions_etc_shadow'
###############################################################################
(>&2 echo "Remediating rule 32/49: 'file_permissions_etc_shadow'")




chmod u-xs,g-xws,o-xwrt /etc/shadow

# END fix for 'file_permissions_etc_shadow'

###############################################################################
# BEGIN fix (33 / 49) for 'sysctl_fs_suid_dumpable'
###############################################################################
(>&2 echo "Remediating rule 33/49: 'sysctl_fs_suid_dumpable'")
(>&2 echo "FIX FOR THIS RULE 'sysctl_fs_suid_dumpable' IS MISSING!")

# END fix for 'sysctl_fs_suid_dumpable'

###############################################################################
# BEGIN fix (34 / 49) for 'sysctl_kernel_randomize_va_space'
###############################################################################
(>&2 echo "Remediating rule 34/49: 'sysctl_kernel_randomize_va_space'")
(>&2 echo "FIX FOR THIS RULE 'sysctl_kernel_randomize_va_space' IS MISSING!")

# END fix for 'sysctl_kernel_randomize_va_space'

###############################################################################
# BEGIN fix (35 / 49) for 'apt_conf_disallow_unauthenticated'
###############################################################################
(>&2 echo "Remediating rule 35/49: 'apt_conf_disallow_unauthenticated'")
(>&2 echo "FIX FOR THIS RULE 'apt_conf_disallow_unauthenticated' IS MISSING!")

# END fix for 'apt_conf_disallow_unauthenticated'

###############################################################################
# BEGIN fix (36 / 49) for 'apt_sources_list_official'
###############################################################################
(>&2 echo "Remediating rule 36/49: 'apt_sources_list_official'")
(>&2 echo "FIX FOR THIS RULE 'apt_sources_list_official' IS MISSING!")

# END fix for 'apt_sources_list_official'

###############################################################################
# BEGIN fix (37 / 49) for 'package_cron_installed'
###############################################################################
(>&2 echo "Remediating rule 37/49: 'package_cron_installed'")
(>&2 echo "FIX FOR THIS RULE 'package_cron_installed' IS MISSING!")

# END fix for 'package_cron_installed'

###############################################################################
# BEGIN fix (38 / 49) for 'package_inetutils-telnetd_removed'
###############################################################################
(>&2 echo "Remediating rule 38/49: 'package_inetutils-telnetd_removed'")

# CAUTION: This remediation script will remove inetutils-telnetd
#	   from the system, and may remove any packages
#	   that depend on inetutils-telnetd. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "inetutils-telnetd"

# END fix for 'package_inetutils-telnetd_removed'

###############################################################################
# BEGIN fix (39 / 49) for 'package_nis_removed'
###############################################################################
(>&2 echo "Remediating rule 39/49: 'package_nis_removed'")

# CAUTION: This remediation script will remove nis
#	   from the system, and may remove any packages
#	   that depend on nis. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "nis"

# END fix for 'package_nis_removed'

###############################################################################
# BEGIN fix (40 / 49) for 'package_ntpdate_removed'
###############################################################################
(>&2 echo "Remediating rule 40/49: 'package_ntpdate_removed'")

# CAUTION: This remediation script will remove ntpdate
#	   from the system, and may remove any packages
#	   that depend on ntpdate. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "ntpdate"

# END fix for 'package_ntpdate_removed'

###############################################################################
# BEGIN fix (41 / 49) for 'package_telnetd-ssl_removed'
###############################################################################
(>&2 echo "Remediating rule 41/49: 'package_telnetd-ssl_removed'")

# CAUTION: This remediation script will remove telnetd-ssl
#	   from the system, and may remove any packages
#	   that depend on telnetd-ssl. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "telnetd-ssl"

# END fix for 'package_telnetd-ssl_removed'

###############################################################################
# BEGIN fix (42 / 49) for 'package_telnetd_removed'
###############################################################################
(>&2 echo "Remediating rule 42/49: 'package_telnetd_removed'")

# CAUTION: This remediation script will remove telnetd
#	   from the system, and may remove any packages
#	   that depend on telnetd. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "telnetd"

# END fix for 'package_telnetd_removed'

###############################################################################
# BEGIN fix (43 / 49) for 'package_ntp_installed'
###############################################################################
(>&2 echo "Remediating rule 43/49: 'package_ntp_installed'")
(>&2 echo "FIX FOR THIS RULE 'package_ntp_installed' IS MISSING!")

# END fix for 'package_ntp_installed'

###############################################################################
# BEGIN fix (44 / 49) for 'service_ntp_enabled'
###############################################################################
(>&2 echo "Remediating rule 44/49: 'service_ntp_enabled'")
(>&2 echo "FIX FOR THIS RULE 'service_ntp_enabled' IS MISSING!")

# END fix for 'service_ntp_enabled'

###############################################################################
# BEGIN fix (45 / 49) for 'sshd_set_keepalive_0'
###############################################################################
(>&2 echo "Remediating rule 45/49: 'sshd_set_keepalive_0'")
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
# BEGIN fix (46 / 49) for 'sshd_set_idle_timeout'
###############################################################################
(>&2 echo "Remediating rule 46/49: 'sshd_set_idle_timeout'")
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
# BEGIN fix (47 / 49) for 'sshd_allow_only_protocol2'
###############################################################################
(>&2 echo "Remediating rule 47/49: 'sshd_allow_only_protocol2'")
(>&2 echo "FIX FOR THIS RULE 'sshd_allow_only_protocol2' IS MISSING!")

# END fix for 'sshd_allow_only_protocol2'

###############################################################################
# BEGIN fix (48 / 49) for 'sshd_disable_empty_passwords'
###############################################################################
(>&2 echo "Remediating rule 48/49: 'sshd_disable_empty_passwords'")
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
# BEGIN fix (49 / 49) for 'sshd_disable_root_login'
###############################################################################
(>&2 echo "Remediating rule 49/49: 'sshd_disable_root_login'")
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

