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

#region Invoke(Get) and Get Puppet Task

$scope = @('node2.ad.piccola.us','joey-clone-test.ad.piccola.us')
$invokePuppetTaskSplat = @{
    Token = $token
    Master = $master
    Task = 'powershell_tasks::account_audit'
    Environment = 'development'
    Description = 'local admin account audit'
    Scope = $scope
    ScopeType = 'nodes'
}

Invoke-PuppetTask @invokePuppetTaskSplat -Wait 120

$getPuppetJobResultsSplat = @{
    master = $master
    token  = $token
    id     = '?'
}

Get-PuppetJobResults @getPuppetJobResultsSplat

#endregion

#region Invoke(Set) and Get Puppet Task

$scope = @('node2.ad.piccola.us','joey-clone-test.ad.piccola.us')
$invokePuppetTaskSplat = @{
    Token = $token
    Master = $master
    Task = 'powershell_tasks::disablesmbv1'
    Environment = 'production'
    Parameters = [PSCustomObject]@{
        action = 'set'
        reboot = $true
    }
    Description = 'Set SMBv1'
    Scope = $scope
    ScopeType = 'nodes'
}

Invoke-PuppetTask @invokePuppetTaskSplat -Wait 120

#endregion