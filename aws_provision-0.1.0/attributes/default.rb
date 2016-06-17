default[:aws_provision][:environment][:name] = 'dev'
default[:aws_provision][:image_id] ="ami-96f1c1c4"
default[:aws_provision][:instance_type] ="t2.small"
default[:aws_provision][:key_name]="arajdevops"
default[:aws_provision][:dbserver][:instance_name]="US_DBSERVER"
default[:aws_provision][:dbserver][:role]="dbserver"
default[:aws_provision][:appserver][:instance_name]="US_APPSERVER"
default[:aws_provision][:appserver][:role]="appserver"
