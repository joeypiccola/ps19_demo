#region Get and Set Puppet Node Certificate

Clear-Host
$getPuppetNodeCertificateStatusSplat = @{
    master       = $master
    node         = 'node1.ad.piccola.us'
    certPath     = './joey.piccola.us.pfx'
    certPassword = $certpwd
}
Get-PuppetNodeCertificateStatus @getPuppetNodeCertificateStatusSplat

Clear-Host
$setPuppetNodeCertificateStatusSplat = @{
    master        = $master
    node          = 'node1.ad.piccola.us'
    certPath      = './joey.piccola.us.pfx'
    certPassword  = $certpwd
    desired_state = 'signed'
}
Set-PuppetNodeCertificateStatus @setPuppetNodeCertificateStatusSplat

#endregion

#region Get, Set, and Delete Puppet Node Certificate/pdb

Clear-Host
$getPuppetNodeCertificateStatusSplat = @{
    master       = $master
    node         = 'node2.ad.piccola.us'
    certPath     = './joey.piccola.us.pfx'
    certPassword = $certpwd
}
Get-PuppetNodeCertificateStatus @getPuppetNodeCertificateStatusSplat

Clear-Host
$setPuppetNodeCertificateStatusSplat = @{
    master        = $master
    node          = 'node2.ad.piccola.us'
    certPath      = './joey.piccola.us.pfx'
    certPassword  = $certpwd
    desired_state = 'revoked'
}
Set-PuppetNodeCertificateStatus @setPuppetNodeCertificateStatusSplat

Clear-Host
$removePuppetNodeCertificateSplat = @{
    master       = $master
    node         = 'node2.ad.piccola.us'
    certPath     = './joey.piccola.us.pfx'
    certPassword = $certpwd
}
Remove-PuppetNodeCertificate @removePuppetNodeCertificateSplat

Clear-Host
$getPuppetDBNodeSplat = @{
    master = $master
    node   = 'node2.ad.piccola.us'
    token  = $token
}
Get-PuppetDBNode @getPuppetDBNodeSplat

Clear-Host
$removePuppetDBNodeSplat = @{
    master = $master
    node   = 'node2.ad.piccola.us'
    token  = $token
}
Remove-PuppetDBNode @removePuppetDBNodeSplat
#endregion

#region Invoke(Get) and Get Puppet Task

Clear-Host
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

Clear-Host
$getPuppetJobResultsSplat = @{
    master = $master
    token  = $token
    id     = '785'
}

Get-PuppetJobResults @getPuppetJobResultsSplat

#endregion

#region Invoke(Set) and Get Puppet Task

Clear-Host
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