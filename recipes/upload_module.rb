#
# Cookbook Name:: nginx_upload_module
# Recipe:: upload_module
#
# Author:: Jeff Rafter (<jeffrafter@gmail.com>)
#
# Copyright 2013
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

upload_module_src_filename = ::File.basename(node['nginx']['upload']['url'])
upload_module_src_filepath = "#{Chef::Config['file_cache_path']}/#{upload_module_src_filename}"
upload_module_extract_path = "#{Chef::Config['file_cache_path']}/nginx_upload"

case node['nginx']['upload']['strategy']
  when 'remote_file'
    upload_module_extract_path += "/#{node['nginx']['upload']['checksum']}"

    remote_file upload_module_src_filepath do
      source node['nginx']['upload']['url']
      checksum node['nginx']['upload']['checksum']
      owner "root"
      group "root"
      mode 00644
    end

    bash "extract_upload_progress_module" do
      cwd ::File.dirname(upload_module_src_filepath)
      code <<-EOH
        mkdir -p #{upload_module_extract_path}
        tar xzf #{upload_module_src_filename} -C #{upload_module_extract_path}
        mv #{upload_module_extract_path}/*/* #{upload_module_extract_path}/
      EOH

      not_if { ::File.exists?(upload_module_extract_path) }
    end
  when 'git'
    upload_module_extract_path += "/branch-#{node['nginx']['upload']['branch']}"

    git upload_module_extract_path do
      repository node['nginx']['upload']['url']
      checkout_branch node['nginx']['upload']['branch']
      action :checkout
    end
  else
    raise 'Unknown strategy'
end




node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{upload_module_extract_path}"]
