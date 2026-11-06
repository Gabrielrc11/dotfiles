#!/usr/bin/env bash
# Mostra no hyprlock se a conta está bloqueada pelo pam_faillock e quanto tempo falta.
# Sem bloqueio ativo, não imprime nada (e o label fica invisível).

conf=/etc/security/faillock.conf

read_setting() { # nome, valor padrão do pam_faillock
    local value
    value=$(grep -E "^\s*$1\s*=" "$conf" 2>/dev/null | tail -1 | cut -d= -f2 | tr -d ' ')
    echo "${value:-$2}"
}

deny=$(read_setting deny 3)
fail_interval=$(read_setting fail_interval 900)
unlock_time=$(read_setting unlock_time 600)

now=$(date +%s)
recent_failures=0
latest_failure=0

# Linhas do faillock: "AAAA-MM-DD HH:MM:SS <tipo> [origem] <V|I>"
while read -r day time valid; do
    [ "$valid" = V ] || continue
    failure_time=$(date -d "$day $time" +%s)
    (( now - failure_time <= fail_interval )) && (( recent_failures++ ))
    (( failure_time > latest_failure )) && latest_failure=$failure_time
done < <(faillock --user "$USER" 2>/dev/null | awk '/^[0-9]{4}-/ {print $1, $2, $NF}')

(( recent_failures >= deny )) || exit 0

if (( unlock_time == 0 )); then
    echo "󰌾  conta bloqueada"
    exit 0
fi

remaining=$(( latest_failure + unlock_time - now ))
(( remaining > 0 )) && printf '󰌾  bloqueado · %d:%02d\n' $(( remaining / 60 )) $(( remaining % 60 ))
