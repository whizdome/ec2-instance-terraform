add-content -path c:/users/wisdo/.ssh/config -value @'

Host ${hostname}
  Hostname ${hostname}
  User ${user}
  Identityfile ${identityfile}
'@