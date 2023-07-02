package 'aide' do
  action :install
end

template node['aide']['config'] do
  notifies :run, 'bash[generate_database]', :delayed
end

# Newer AIDE versions split logging/reporting so now we're left with this mess.

if node[:platform_version] == "22.04"
  quiet_report = "--before='report_quiet=true'"
  verbose_report = "--before='report_quiet=false'"
else
  quiet_report = "-V3"
  verbose_report = "-V5"
end

cron_d 'aide' do
  action :create
  minute '0'
  hour "*/6"
  user 'root'
  command "#{node['aide']['binary']} #{node['aide']['extra_parameters']} #{quiet_report} --check | sed -z '$ s/\\n$//'"
  mailto node['aide']['cron_mailto'] if node['aide']['cron_mailto']
end

cron_d 'aide-detailed' do
  action :create
  minute '0'
  hour '5'
  weekday '1'
  user 'root'
  command "#{node['aide']['binary']} #{node['aide']['extra_parameters']} #{verbose_report} --check"
  mailto node['aide']['cron_mailto'] if node['aide']['cron_mailto']
end

bash 'generate_database' do
  action :nothing
  not_if { node['aide']['testmode'] == 'true' }
  code "#{node['aide']['binary']} #{node['aide']['extra_parameters']} --init"
end
