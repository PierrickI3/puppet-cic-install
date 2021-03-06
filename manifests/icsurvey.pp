# == Class: cicserver::icsurvey
#
# Creates an ICSurvey file for automation purposes to run the IC Setup Assistant silently
#
# === Parameters
#
# [path]
#	Required. Full path to the output icsurvey file.
#
# [installnodomain]
# 	Set to true if no domain is configured.
#
# [organizationname]
# 	Interaction Center Organization Name. Defaults to organizationname.
#
# [locationname]
# 	Interaction Center location name. Defaults to locationname.
#
# [sitename]
#	Interaction Center Site Name. Defaults to sitename.
#
# [dbreporttype]
#	Database report type. Only 'db' is supported for now.
#
# [dbservertype]
# 	Database server type. Only 'mssql' is supported for now.
#
# [dbtablename]
#	Database table name. Defaults to I3_IC.
#
# [dialplanlocalareacode]
#	local area code. Defaults to 317.
#
# [emailfbmc]
#	Set to true to enable IC's FBMC (File Based Mail Connector). Defaults to false.
#
# [recordingspath]
#	Path to store the compressed recordings. Defaults to C:/I3/IC/Recordings.
#
# [sipnic]
#	Name of the network card (NIC) to use for SIP/RTP transport. Defaults to Ethernet.
#
# [outboundaddress]
#	Phone number to show for outbound calls. Defaults to 3178723000.
#
# [defaulticpassword]
#	Default IC user password. Defaults to 1234.
#
# [licensefile]
#	Path to the .i3lic file
#
# [template]
# Default path for the ICSurvey ERB template
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class {'cicserver::icsurvey':
#	  path 					        => 'c:/i3/ic/manifest/newsurvey.icsurvey',
# 	installnodomain			  => true,			
# 	organizationname		  => 'organizationname',
# 	locationname			    => 'locationname',
# 	sitename				      => 'sitename',
# 	dbreporttype			    => 'db', 			
# 	dbtablename				    => 'I3_IC',
# 	dialplanlocalareacode	=> '317',			
# 	emailfbmc				      => true,
# 	recordingspath			  => 'C:/I3/IC/Recordings',
# 	sipnic					      => 'Ethernet',
# 	outboundaddress			  => '3178723000',
# 	defaulticpassword		  => '1234',		
# 	licensefile				    => 'C:/I3/IC/license.i3lic',
#   template              => 'cicserver/DefaultSurvey.ICSurvey.erb',
#  }
#
# === Authors
#
# Pierrick Lozach <pierrick.lozach@inin.com>
#
# === Copyright
#
# Copyright 2015, Interactive Intelligence Inc.
#
class cicserver::icsurvey (
  $path                   = 'C:/I3/IC/Manifest/newsurvey.icsurvey',
  $installnodomain        = true,
  $organizationname       = 'organizationname',
  $locationname           = 'locationname',
  $sitename               = 'sitename',
  $dbreporttype           = 'db',
  $dbservertype           = 'mssql',
  $dbtablename            = 'I3_IC',
  $dialplanlocalareacode  = '317',
  $emailfbmc              = false,
  $recordingspath         = 'C:/I3/IC/Recordings',
  $sipnic                 = 'Ethernet',
  $outboundaddress        = '3178723000',
  $defaulticpassword      = '1234',
  $licensefile            = 'C:/I3/IC/iclicense.i3lic',
  $template               = 'cicserver/DefaultSurvey.ICSurvey.erb',
){

  require stdlib

  validate_absolute_path($path)
  validate_bool($emailfbmc)

  if ($emailfbmc) {
    $emailselected = 1
    $usefbmc = 1
  }
  else {
    $emailselected = 0
  }

  $useinstallnodomain = bool2num($installnodomain)

  $manifest_dir = ['C:\\I3', 'C:\\I3\\IC', 'C:\\I3\\IC\\Manifest',]

  file {$manifest_dir:
    ensure  => directory,
  }

  file {'icsurvey':
    ensure  => present,
    path    => $path,
    content => template($template),
  }

}
