# Sub-Module: TFE Instance

This sub-module is responsible for creating the GCP Compute Instance on which TFE will be installed. It will also use a `metadata_startup_script` to perform an automated, online, demo installation of TFE.

Additionally, this sub-module will create the appropriate GCP firewall rules to allow access to TFE.