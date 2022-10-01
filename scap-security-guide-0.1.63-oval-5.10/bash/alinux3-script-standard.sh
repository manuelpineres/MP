#!/usr/bin/env bash
###############################################################################
#
# Bash Remediation Script for Standard System Security Profile for Alibaba Cloud Linux 3
#
# Profile Description:
# This profile contains rules to ensure standard security baseline
# of a Alibaba Cloud Linux 3 system. Regardless of your system's workload
# all of these checks should pass.
#
# Profile ID:  standard
# Benchmark ID:  ALINUX-3
# Benchmark Version:  0.1.63
# XCCDF Version:  1.1
#
# This file was generated by OpenSCAP 1.3.6 using:
# $ oscap xccdf generate fix --profile standard --fix-type bash xccdf-file.xml
#
# This Bash Remediation Script is generated from an OpenSCAP profile without preliminary evaluation.
# It attempts to fix every selected rule, even if the system is already compliant.
#
# How to apply this Bash Remediation Script:
# $ sudo ./remediation-script.sh
#
###############################################################################

###############################################################################
# BEGIN fix (1 / 23) for 'rpm_verify_hashes'
###############################################################################
(>&2 echo "Remediating rule 1/23: 'rpm_verify_hashes'")
(>&2 echo "FIX FOR THIS RULE 'rpm_verify_hashes' IS MISSING!")

# END fix for 'rpm_verify_hashes'

###############################################################################
# BEGIN fix (2 / 23) for 'rpm_verify_permissions'
###############################################################################
(>&2 echo "Remediating rule 2/23: 'rpm_verify_permissions'")
(>&2 echo "FIX FOR THIS RULE 'rpm_verify_permissions' IS MISSING!")

# END fix for 'rpm_verify_permissions'

###############################################################################
# BEGIN fix (3 / 23) for 'configure_bind_crypto_policy'
###############################################################################
(>&2 echo "Remediating rule 3/23: 'configure_bind_crypto_policy'")

function remediate_bind_crypto_policy() {
	CONFIG_FILE="/etc/named.conf"
	if test -f "$CONFIG_FILE"; then
		sed -i 's|options {|&\n\tinclude "/etc/crypto-policies/back-ends/bind.config";|' "$CONFIG_FILE"
		return 0
	else
		echo "Aborting remediation as '$CONFIG_FILE' was not even found." >&2
		return 1
	fi
}

remediate_bind_crypto_policy

# END fix for 'configure_bind_crypto_policy'

###############################################################################
# BEGIN fix (4 / 23) for 'configure_crypto_policy'
###############################################################################
(>&2 echo "Remediating rule 4/23: 'configure_crypto_policy'")

var_system_crypto_policy='DEFAULT'


stderr_of_call=$(update-crypto-policies --set ${var_system_crypto_policy} 2>&1 > /dev/null)
rc=$?

if test "$rc" = 127; then
	echo "$stderr_of_call" >&2
	echo "Make sure that the script is installed on the remediated system." >&2
	echo "See output of the 'dnf provides update-crypto-policies' command" >&2
	echo "to see what package to (re)install" >&2

	false  # end with an error code
elif test "$rc" != 0; then
	echo "Error invoking the update-crypto-policies script: $stderr_of_call" >&2
	false  # end with an error code
fi

# END fix for 'configure_crypto_policy'

###############################################################################
# BEGIN fix (5 / 23) for 'configure_kerberos_crypto_policy'
###############################################################################
(>&2 echo "Remediating rule 5/23: 'configure_kerberos_crypto_policy'")

rm -f /etc/krb5.conf.d/crypto-policies
ln -s /etc/crypto-policies/back-ends/krb5.config /etc/krb5.conf.d/crypto-policies

# END fix for 'configure_kerberos_crypto_policy'

###############################################################################
# BEGIN fix (6 / 23) for 'configure_libreswan_crypto_policy'
###############################################################################
(>&2 echo "Remediating rule 6/23: 'configure_libreswan_crypto_policy'")

function remediate_libreswan_crypto_policy() {
    CONFIG_FILE="/etc/ipsec.conf"
    if ! grep -qP "^\s*include\s+/etc/crypto-policies/back-ends/libreswan.config\s*(?:#.*)?$" "$CONFIG_FILE" ; then
        # the file might not end with a new line
        echo -e '\ninclude /etc/crypto-policies/back-ends/libreswan.config' >> "$CONFIG_FILE"
    fi
    return 0
}

remediate_libreswan_crypto_policy

# END fix for 'configure_libreswan_crypto_policy'

###############################################################################
# BEGIN fix (7 / 23) for 'configure_openssl_crypto_policy'
###############################################################################
(>&2 echo "Remediating rule 7/23: 'configure_openssl_crypto_policy'")

OPENSSL_CRYPTO_POLICY_SECTION='[ crypto_policy ]'
OPENSSL_CRYPTO_POLICY_SECTION_REGEX='\[\s*crypto_policy\s*\]'
OPENSSL_CRYPTO_POLICY_INCLUSION='.include /etc/crypto-policies/back-ends/opensslcnf.config'
OPENSSL_CRYPTO_POLICY_INCLUSION_REGEX='^\s*\.include\s*/etc/crypto-policies/back-ends/opensslcnf.config$'


  


function remediate_openssl_crypto_policy() {
	CONFIG_FILE=/etc/pki/tls/openssl.cnf
	if test -f "$CONFIG_FILE"; then
		if ! grep -q "^\\s*$OPENSSL_CRYPTO_POLICY_SECTION_REGEX" "$CONFIG_FILE"; then
			printf '\n%s\n\n%s' "$OPENSSL_CRYPTO_POLICY_SECTION" "$OPENSSL_CRYPTO_POLICY_INCLUSION" >> "$CONFIG_FILE"
			return 0
		elif ! grep -q "^\\s*$OPENSSL_CRYPTO_POLICY_INCLUSION_REGEX" "$CONFIG_FILE"; then
			sed -i "s|$OPENSSL_CRYPTO_POLICY_SECTION_REGEX|&\\n\\n$OPENSSL_CRYPTO_POLICY_INCLUSION\\n|" "$CONFIG_FILE"
			return 0
		fi
	else
		echo "Aborting remediation as '$CONFIG_FILE' was not even found." >&2
		return 1
	fi
}

remediate_openssl_crypto_policy

# END fix for 'configure_openssl_crypto_policy'

###############################################################################
# BEGIN fix (8 / 23) for 'configure_ssh_crypto_policy'
###############################################################################
(>&2 echo "Remediating rule 8/23: 'configure_ssh_crypto_policy'")

SSH_CONF="/etc/sysconfig/sshd"

sed -i "/^\s*CRYPTO_POLICY.*$/Id" $SSH_CONF

# END fix for 'configure_ssh_crypto_policy'

###############################################################################
# BEGIN fix (9 / 23) for 'ensure_gpgcheck_globally_activated'
###############################################################################
(>&2 echo "Remediating rule 9/23: 'ensure_gpgcheck_globally_activated'")
(>&2 echo "FIX FOR THIS RULE 'ensure_gpgcheck_globally_activated' IS MISSING!")

# END fix for 'ensure_gpgcheck_globally_activated'

###############################################################################
# BEGIN fix (10 / 23) for 'ensure_redhat_gpgkey_installed'
###############################################################################
(>&2 echo "Remediating rule 10/23: 'ensure_redhat_gpgkey_installed'")
(>&2 echo "FIX FOR THIS RULE 'ensure_redhat_gpgkey_installed' IS MISSING!")

# END fix for 'ensure_redhat_gpgkey_installed'

###############################################################################
# BEGIN fix (11 / 23) for 'security_patches_up_to_date'
###############################################################################
(>&2 echo "Remediating rule 11/23: 'security_patches_up_to_date'")
(>&2 echo "FIX FOR THIS RULE 'security_patches_up_to_date' IS MISSING!")

# END fix for 'security_patches_up_to_date'

###############################################################################
# BEGIN fix (12 / 23) for 'audit_rules_file_deletion_events'
###############################################################################
(>&2 echo "Remediating rule 12/23: 'audit_rules_file_deletion_events'")
(>&2 echo "FIX FOR THIS RULE 'audit_rules_file_deletion_events' IS MISSING!")

# END fix for 'audit_rules_file_deletion_events'

###############################################################################
# BEGIN fix (13 / 23) for 'audit_rules_unsuccessful_file_modification'
###############################################################################
(>&2 echo "Remediating rule 13/23: 'audit_rules_unsuccessful_file_modification'")
(>&2 echo "FIX FOR THIS RULE 'audit_rules_unsuccessful_file_modification' IS MISSING!")

# END fix for 'audit_rules_unsuccessful_file_modification'

###############################################################################
# BEGIN fix (14 / 23) for 'audit_rules_kernel_module_loading'
###############################################################################
(>&2 echo "Remediating rule 14/23: 'audit_rules_kernel_module_loading'")
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit; then

# First perform the remediation of the syscall rule
# Retrieve hardware architecture of the underlying system
# Note: 32-bit and 64-bit kernel syscall numbers not always line up =>
#       it's required on a 64-bit system to check also for the presence
#       of 32-bit's equivalent of the corresponding rule.
#       (See `man 7 audit.rules` for details )
[ "$(getconf LONG_BIT)" = "32" ] && RULE_ARCHS=("b32") || RULE_ARCHS=("b32" "b64")

for ARCH in "${RULE_ARCHS[@]}"
do
        ACTION_ARCH_FILTERS="-a always,exit -F arch=$ARCH"
        OTHER_FILTERS=""
        
        AUID_FILTERS=""
        
        SYSCALL="init_module finit_module delete_module"
        KEY="modules"
        SYSCALL_GROUPING="init_module finit_module delete_module"
        # Perform the remediation for both possible tools: 'auditctl' and 'augenrules'
        unset syscall_a
unset syscall_grouping
unset syscall_string
unset syscall
unset file_to_edit
unset rule_to_edit
unset rule_syscalls_to_edit
unset other_string
unset auid_string
unset full_rule

# Load macro arguments into arrays
read -a syscall_a <<< $SYSCALL
read -a syscall_grouping <<< $SYSCALL_GROUPING

# Create a list of audit *.rules files that should be inspected for presence and correctness
# of a particular audit rule. The scheme is as follows:
#
# -----------------------------------------------------------------------------------------
#  Tool used to load audit rules | Rule already defined  |  Audit rules file to inspect    |
# -----------------------------------------------------------------------------------------
#        auditctl                |     Doesn't matter    |  /etc/audit/audit.rules         |
# -----------------------------------------------------------------------------------------
#        augenrules              |          Yes          |  /etc/audit/rules.d/*.rules     |
#        augenrules              |          No           |  /etc/audit/rules.d/$key.rules  |
# -----------------------------------------------------------------------------------------
#
files_to_inspect=()


# If audit tool is 'augenrules', then check if the audit rule is defined
# If rule is defined, add '/etc/audit/rules.d/*.rules' to the list for inspection
# If rule isn't defined yet, add '/etc/audit/rules.d/$key.rules' to the list for inspection
default_file="/etc/audit/rules.d/$KEY.rules"
# As other_filters may include paths, lets use a different delimiter for it
# The "F" script expression tells sed to print the filenames where the expressions matched
readarray -t files_to_inspect < <(sed -s -n -e "/^$ACTION_ARCH_FILTERS/!d" -e "\#$OTHER_FILTERS#!d" -e "/$AUID_FILTERS/!d" -e "F" /etc/audit/rules.d/*.rules)
# Case when particular rule isn't defined in /etc/audit/rules.d/*.rules yet
if [ ${#files_to_inspect[@]} -eq "0" ]
then
    file_to_inspect="/etc/audit/rules.d/$KEY.rules"
    files_to_inspect=("$file_to_inspect")
    if [ ! -e "$file_to_inspect" ]
    then
        touch "$file_to_inspect"
        chmod 0640 "$file_to_inspect"
    fi
fi

# After converting to jinja, we cannot return; therefore we skip the rest of the macro if needed instead
skip=1

for audit_file in "${files_to_inspect[@]}"
do
    # Filter existing $audit_file rules' definitions to select those that satisfy the rule pattern,
    # i.e, collect rules that match:
    # * the action, list and arch, (2-nd argument)
    # * the other filters, (3-rd argument)
    # * the auid filters, (4-rd argument)
    readarray -t similar_rules < <(sed -e "/^$ACTION_ARCH_FILTERS/!d"  -e "\#$OTHER_FILTERS#!d" -e "/$AUID_FILTERS/!d" "$audit_file")

    candidate_rules=()
    # Filter out rules that have more fields then required. This will remove rules more specific than the required scope
    for s_rule in "${similar_rules[@]}"
    do
        # Strip all the options and fields we know of,
        # than check if there was any field left over
        extra_fields=$(sed -E -e "s/^$ACTION_ARCH_FILTERS//"  -e "s#$OTHER_FILTERS##" -e "s/$AUID_FILTERS//" -e "s/((:?-S [[:alnum:],]+)+)//g" -e "s/-F key=\w+|-k \w+//"<<< "$s_rule")
        grep -q -- "-F" <<< "$extra_fields" || candidate_rules+=("$s_rule")
    done

    if [[ ${#syscall_a[@]} -ge 1 ]]
    then
        # Check if the syscall we want is present in any of the similar existing rules
        for rule in "${candidate_rules[@]}"
        do
            rule_syscalls=$(echo "$rule" | grep -o -P '(-S [\w,]+)+' | xargs)
            all_syscalls_found=0
            for syscall in "${syscall_a[@]}"
            do
                grep -q -- "\b${syscall}\b" <<< "$rule_syscalls" || {
                   # A syscall was not found in the candidate rule
                   all_syscalls_found=1
                   }
            done
            if [[ $all_syscalls_found -eq 0 ]]
            then
                # We found a rule with all the syscall(s) we want; skip rest of macro
                skip=0
                break
            fi

            # Check if this rule can be grouped with our target syscall and keep track of it
            for syscall_g in "${syscall_grouping[@]}"
            do
                if grep -q -- "\b${syscall_g}\b" <<< "$rule_syscalls"
                then
                    file_to_edit=${audit_file}
                    rule_to_edit=${rule}
                    rule_syscalls_to_edit=${rule_syscalls}
                fi
            done
        done
    else
        # If there is any candidate rule, it is compliant; skip rest of macro
        if [ "${#candidate_rules[@]}" -gt 0 ]
        then
            skip=0
        fi
    fi

    if [ "$skip" -eq 0 ]; then
        break
    fi
done

if [ "$skip" -ne 0 ]; then
    # We checked all rules that matched the expected resemblance pattern (action, arch & auid)
    # At this point we know if we need to either append the $full_rule or group
    # the syscall together with an exsiting rule

    # Append the full_rule if it cannot be grouped to any other rule
    if [ -z ${rule_to_edit+x} ]
    then
        # Build full_rule while avoid adding double spaces when other_filters is empty
        if [ "${#syscall_a[@]}" -gt 0 ]
        then
            syscall_string=""
            for syscall in "${syscall_a[@]}"
            do
                syscall_string+=" -S $syscall"
            done
        fi
        other_string=$([[ $OTHER_FILTERS ]] && echo " $OTHER_FILTERS") || /bin/true
        auid_string=$([[ $AUID_FILTERS ]] && echo " $AUID_FILTERS") || /bin/true
        full_rule="$ACTION_ARCH_FILTERS${syscall_string}${other_string}${auid_string} -F key=$KEY" || /bin/true
        echo "$full_rule" >> "$default_file"
        chmod o-rwx ${default_file}
    else
        # Check if the syscalls are declared as a comma separated list or
        # as multiple -S parameters
        if grep -q -- "," <<< "${rule_syscalls_to_edit}"
        then
            delimiter=","
        else
            delimiter=" -S "
        fi
        new_grouped_syscalls="${rule_syscalls_to_edit}"
        for syscall in "${syscall_a[@]}"
        do
            grep -q -- "\b${syscall}\b" <<< "${rule_syscalls_to_edit}" || {
               # A syscall was not found in the candidate rule
               new_grouped_syscalls+="${delimiter}${syscall}"
               }
        done

        # Group the syscall in the rule
        sed -i -e "\#${rule_to_edit}#s#${rule_syscalls_to_edit}#${new_grouped_syscalls}#" "$file_to_edit"
    fi
fi
        unset syscall_a
unset syscall_grouping
unset syscall_string
unset syscall
unset file_to_edit
unset rule_to_edit
unset rule_syscalls_to_edit
unset other_string
unset auid_string
unset full_rule

# Load macro arguments into arrays
read -a syscall_a <<< $SYSCALL
read -a syscall_grouping <<< $SYSCALL_GROUPING

# Create a list of audit *.rules files that should be inspected for presence and correctness
# of a particular audit rule. The scheme is as follows:
#
# -----------------------------------------------------------------------------------------
#  Tool used to load audit rules | Rule already defined  |  Audit rules file to inspect    |
# -----------------------------------------------------------------------------------------
#        auditctl                |     Doesn't matter    |  /etc/audit/audit.rules         |
# -----------------------------------------------------------------------------------------
#        augenrules              |          Yes          |  /etc/audit/rules.d/*.rules     |
#        augenrules              |          No           |  /etc/audit/rules.d/$key.rules  |
# -----------------------------------------------------------------------------------------
#
files_to_inspect=()



# If audit tool is 'auditctl', then add '/etc/audit/audit.rules'
# file to the list of files to be inspected
default_file="/etc/audit/audit.rules"
files_to_inspect+=('/etc/audit/audit.rules' )

# After converting to jinja, we cannot return; therefore we skip the rest of the macro if needed instead
skip=1

for audit_file in "${files_to_inspect[@]}"
do
    # Filter existing $audit_file rules' definitions to select those that satisfy the rule pattern,
    # i.e, collect rules that match:
    # * the action, list and arch, (2-nd argument)
    # * the other filters, (3-rd argument)
    # * the auid filters, (4-rd argument)
    readarray -t similar_rules < <(sed -e "/^$ACTION_ARCH_FILTERS/!d"  -e "\#$OTHER_FILTERS#!d" -e "/$AUID_FILTERS/!d" "$audit_file")

    candidate_rules=()
    # Filter out rules that have more fields then required. This will remove rules more specific than the required scope
    for s_rule in "${similar_rules[@]}"
    do
        # Strip all the options and fields we know of,
        # than check if there was any field left over
        extra_fields=$(sed -E -e "s/^$ACTION_ARCH_FILTERS//"  -e "s#$OTHER_FILTERS##" -e "s/$AUID_FILTERS//" -e "s/((:?-S [[:alnum:],]+)+)//g" -e "s/-F key=\w+|-k \w+//"<<< "$s_rule")
        grep -q -- "-F" <<< "$extra_fields" || candidate_rules+=("$s_rule")
    done

    if [[ ${#syscall_a[@]} -ge 1 ]]
    then
        # Check if the syscall we want is present in any of the similar existing rules
        for rule in "${candidate_rules[@]}"
        do
            rule_syscalls=$(echo "$rule" | grep -o -P '(-S [\w,]+)+' | xargs)
            all_syscalls_found=0
            for syscall in "${syscall_a[@]}"
            do
                grep -q -- "\b${syscall}\b" <<< "$rule_syscalls" || {
                   # A syscall was not found in the candidate rule
                   all_syscalls_found=1
                   }
            done
            if [[ $all_syscalls_found -eq 0 ]]
            then
                # We found a rule with all the syscall(s) we want; skip rest of macro
                skip=0
                break
            fi

            # Check if this rule can be grouped with our target syscall and keep track of it
            for syscall_g in "${syscall_grouping[@]}"
            do
                if grep -q -- "\b${syscall_g}\b" <<< "$rule_syscalls"
                then
                    file_to_edit=${audit_file}
                    rule_to_edit=${rule}
                    rule_syscalls_to_edit=${rule_syscalls}
                fi
            done
        done
    else
        # If there is any candidate rule, it is compliant; skip rest of macro
        if [ "${#candidate_rules[@]}" -gt 0 ]
        then
            skip=0
        fi
    fi

    if [ "$skip" -eq 0 ]; then
        break
    fi
done

if [ "$skip" -ne 0 ]; then
    # We checked all rules that matched the expected resemblance pattern (action, arch & auid)
    # At this point we know if we need to either append the $full_rule or group
    # the syscall together with an exsiting rule

    # Append the full_rule if it cannot be grouped to any other rule
    if [ -z ${rule_to_edit+x} ]
    then
        # Build full_rule while avoid adding double spaces when other_filters is empty
        if [ "${#syscall_a[@]}" -gt 0 ]
        then
            syscall_string=""
            for syscall in "${syscall_a[@]}"
            do
                syscall_string+=" -S $syscall"
            done
        fi
        other_string=$([[ $OTHER_FILTERS ]] && echo " $OTHER_FILTERS") || /bin/true
        auid_string=$([[ $AUID_FILTERS ]] && echo " $AUID_FILTERS") || /bin/true
        full_rule="$ACTION_ARCH_FILTERS${syscall_string}${other_string}${auid_string} -F key=$KEY" || /bin/true
        echo "$full_rule" >> "$default_file"
        chmod o-rwx ${default_file}
    else
        # Check if the syscalls are declared as a comma separated list or
        # as multiple -S parameters
        if grep -q -- "," <<< "${rule_syscalls_to_edit}"
        then
            delimiter=","
        else
            delimiter=" -S "
        fi
        new_grouped_syscalls="${rule_syscalls_to_edit}"
        for syscall in "${syscall_a[@]}"
        do
            grep -q -- "\b${syscall}\b" <<< "${rule_syscalls_to_edit}" || {
               # A syscall was not found in the candidate rule
               new_grouped_syscalls+="${delimiter}${syscall}"
               }
        done

        # Group the syscall in the rule
        sed -i -e "\#${rule_to_edit}#s#${rule_syscalls_to_edit}#${new_grouped_syscalls}#" "$file_to_edit"
    fi
fi
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi

# END fix for 'audit_rules_kernel_module_loading'

###############################################################################
# BEGIN fix (15 / 23) for 'file_permissions_unauthorized_sgid'
###############################################################################
(>&2 echo "Remediating rule 15/23: 'file_permissions_unauthorized_sgid'")
(>&2 echo "FIX FOR THIS RULE 'file_permissions_unauthorized_sgid' IS MISSING!")

# END fix for 'file_permissions_unauthorized_sgid'

###############################################################################
# BEGIN fix (16 / 23) for 'file_permissions_unauthorized_suid'
###############################################################################
(>&2 echo "Remediating rule 16/23: 'file_permissions_unauthorized_suid'")
(>&2 echo "FIX FOR THIS RULE 'file_permissions_unauthorized_suid' IS MISSING!")

# END fix for 'file_permissions_unauthorized_suid'

###############################################################################
# BEGIN fix (17 / 23) for 'service_autofs_disabled'
###############################################################################
(>&2 echo "Remediating rule 17/23: 'service_autofs_disabled'")
(>&2 echo "FIX FOR THIS RULE 'service_autofs_disabled' IS MISSING!")

# END fix for 'service_autofs_disabled'

###############################################################################
# BEGIN fix (18 / 23) for 'service_abrtd_disabled'
###############################################################################
(>&2 echo "Remediating rule 18/23: 'service_abrtd_disabled'")
(>&2 echo "FIX FOR THIS RULE 'service_abrtd_disabled' IS MISSING!")

# END fix for 'service_abrtd_disabled'

###############################################################################
# BEGIN fix (19 / 23) for 'service_ntpdate_disabled'
###############################################################################
(>&2 echo "Remediating rule 19/23: 'service_ntpdate_disabled'")
(>&2 echo "FIX FOR THIS RULE 'service_ntpdate_disabled' IS MISSING!")

# END fix for 'service_ntpdate_disabled'

###############################################################################
# BEGIN fix (20 / 23) for 'service_oddjobd_disabled'
###############################################################################
(>&2 echo "Remediating rule 20/23: 'service_oddjobd_disabled'")
(>&2 echo "FIX FOR THIS RULE 'service_oddjobd_disabled' IS MISSING!")

# END fix for 'service_oddjobd_disabled'

###############################################################################
# BEGIN fix (21 / 23) for 'service_qpidd_disabled'
###############################################################################
(>&2 echo "Remediating rule 21/23: 'service_qpidd_disabled'")
(>&2 echo "FIX FOR THIS RULE 'service_qpidd_disabled' IS MISSING!")

# END fix for 'service_qpidd_disabled'

###############################################################################
# BEGIN fix (22 / 23) for 'service_rdisc_disabled'
###############################################################################
(>&2 echo "Remediating rule 22/23: 'service_rdisc_disabled'")
(>&2 echo "FIX FOR THIS RULE 'service_rdisc_disabled' IS MISSING!")

# END fix for 'service_rdisc_disabled'

###############################################################################
# BEGIN fix (23 / 23) for 'service_atd_disabled'
###############################################################################
(>&2 echo "Remediating rule 23/23: 'service_atd_disabled'")
(>&2 echo "FIX FOR THIS RULE 'service_atd_disabled' IS MISSING!")

# END fix for 'service_atd_disabled'

