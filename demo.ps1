#region Get and Set Puppet Node Certificate

$getPuppetNodeCertificateStatusSplat = @{
    master       = $master
    node         = 'node1.ad.piccola.us'
    certPath     = './joey.piccola.us.pfx'
    certPassword = $certpwd
}
Get-PuppetNodeCertificateStatus @getPuppetNodeCertificateStatusSplat -Verbose

$setPuppetNodeCertificateStatusSplat = @{
    master        = $master
    node          = 'node1.ad.piccola.us'
    certPath      = './joey.piccola.us.pfx'
    certPassword  = $certpwd
    desired_state = 'signed'
}
Set-PuppetNodeCertificateStatus @setPuppetNodeCertificateStatusSplat -Verbose

#endregion

#region Get, Set, and Delete Puppet Node Certificate/pdb

$getPuppetNodeCertificateStatusSplat = @{
    master       = $master
    node         = 'node2.ad.piccola.us'
    certPath     = './joey.piccola.us.pfx'
    certPassword = $certpwd
}
Get-PuppetNodeCertificateStatus @getPuppetNodeCertificateStatusSplat -Verbose

$setPuppetNodeCertificateStatusSplat = @{
    master        = $master
    node          = 'node2.ad.piccola.us'
    certPath      = './joey.piccola.us.pfx'
    certPassword  = $certpwd
    desired_state = 'revoked'
}
Set-PuppetNodeCertificateStatus @setPuppetNodeCertificateStatusSplat -Verbose

$removePuppetNodeCertificateSplat = @{
    master       = $master
    node         = 'node2.ad.piccola.us'
    certPath     = './joey.piccola.us.pfx'
    certPassword = $certpwd
}
Remove-PuppetNodeCertificate @removePuppetNodeCertificateSplat -Verbose

$getPuppetDBNodeSplat = @{
    master = $master
    node   = 'node2.ad.piccola.us'
    token  = $token
}
Get-PuppetDBNode @getPuppetDBNodeSplat -Verbose

$removePuppetDBNodeSplat = @{
    master = $master
    node   = 'node2.ad.piccola.us'
    token  = $token
}
Remove-PuppetDBNode @removePuppetDBNodeSplat -Verbose
#endregion


Invoke-PuppetTask -Token $token -Master $master -Task 'powershell_tasks::account_audit' -Scope nodes