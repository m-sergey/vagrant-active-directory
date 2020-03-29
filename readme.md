# Vagrant environment for a Windows Server based Active Directory

The idea of this repository is to have an easy way to test LDAP authentication against an Active Directory without the hassle of running a Windows Server, installing, configuring and populate an AD server.

To do this it provides a Vagrant file that lets you spin up a preconfigured virtual machine that has everything you need for testing.

**Note:** this image is currently a work in progress and may change over time. This means tests against the image may break in the future because the data in the provided AD changes. But I expect it to settle eventually.

## Usage

This vagrant box provides you with a preconfigured AD-Server filled with **users** to test against. Have a look at `scripts/users.csv` to see what's available.

To get started, install `vagrant` and `virtualbox` and clone this repository. In the repo run the following to **start the server**:

    vagrant up

**Login to Windows** in using rdesktop with username `EXAMPLE\vagrant` password `vagrant`:

    rdesktop -d EXAMPLE -u vagrant -p vagrant localhost:33389

The machine will map the **LDAP** Ports to `7389` (ldap) and `7636` (ldaps) on the `localhost`. Here's the data you may need to connect:

    base_dn:        DC=example,DC=local
    domain:         example.local
    netbios domain: EXAMPLE
    user:           vagrant@example.local
    password:       vagrant
    
**Shutdown** the machine with:

   vagrant halt

The box is based on the official Windows Server 2019 Trial images by Microsoft. The installation is **valid for 180 days**. You can simply destroy the machine and set it up again for another trial period.

    vagrant destroy

## Thanks

This image is based on the works and information at

  * https://github.com/bitfrickler/vagrant-active-directory-2016
  * https://github.com/rgl/windows-domain-controller-vagrant
  * https://emeneye.wordpress.com/2013/02/28/importing-users-into-active-directory-from-a-csv-file-using-powershell/
  * various tutorials on PowerShell scripting
